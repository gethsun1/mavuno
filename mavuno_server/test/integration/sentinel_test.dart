import 'package:mavuno_server/src/generated/protocol.dart';
import 'package:test/test.dart';

import 'test_tools/serverpod_test_tools.dart';

void main() {
  withServerpod('Given Farm Sentinel', (sessionBuilder, endpoints) {
    final alice = sessionBuilder.copyWith(
      authentication: AuthenticationOverride.authenticationInfo(
        'sentinel-alice',
        {},
      ),
    );
    final bob = sessionBuilder.copyWith(
      authentication: AuthenticationOverride.authenticationInfo(
        'sentinel-bob',
        {},
      ),
    );
    late int farmId;
    late int animalId;

    setUp(() async {
      final farm = await endpoints.farm.create(alice, 'Sentinel test farm');
      farmId = farm.id!;
      final animal = await endpoints.animal.create(
        alice,
        farmId,
        'SENT-1',
        AnimalSpecies.cattle,
        AnimalSex.female,
        status: AnimalStatus.active,
      );
      animalId = animal.id!;
    });

    test(
      'no data returns unassessed and assessment access is tenant scoped',
      () async {
        expect(await endpoints.sentinel.getLatest(alice, animalId), isNull);
        expect(await endpoints.sentinel.evaluate(alice, animalId), isNull);
        await expectLater(
          endpoints.sentinel.getLatest(bob, animalId),
          throwsA(isA<Exception>()),
        );
        await expectLater(
          endpoints.sentinel.evaluate(bob, animalId),
          throwsA(isA<Exception>()),
        );
      },
    );

    test('farm dashboard snapshot is aggregated and tenant scoped', () async {
      final empty = await endpoints.dashboard.getFarmSnapshot(alice, farmId);
      expect(empty.animals.map((animal) => animal.id), contains(animalId));
      expect(empty.assessments, isEmpty);
      expect(empty.observations, isEmpty);
      expect(empty.production, isEmpty);

      await endpoints.observation.create(
        alice,
        animalId,
        DateTime.now().toUtc(),
        temperature: 40.1,
        appetiteScore: 2,
        activityScore: 3,
      );
      await SentinelAssessment.db.insertRow(
        alice.build(),
        SentinelAssessment(
          farmId: farmId,
          animalId: animalId,
          assessedAt: DateTime.utc(2020),
          riskScore: 0,
          riskLevel: RiskLevel.low,
          detectedSignals: '[]',
          baselineSummary: 'historical',
          explanation: 'historical',
          recommendedAction: 'historical',
        ),
      );
      final snapshot = await endpoints.dashboard.getFarmSnapshot(alice, farmId);
      expect(snapshot.assessments, hasLength(1));
      expect(snapshot.assessments.single.riskLevel, RiskLevel.high);
      expect(snapshot.alerts, hasLength(1));
      expect(snapshot.tasks, hasLength(1));
      expect(snapshot.tasks.single.dueAt, isNull);
      expect(snapshot.observations, hasLength(1));

      await expectLater(
        endpoints.dashboard.getFarmSnapshot(bob, farmId),
        throwsA(isA<Exception>()),
      );
      final otherFarm = await endpoints.farm.create(bob, 'Other farm');
      final otherSnapshot = await endpoints.dashboard.getFarmSnapshot(
        bob,
        otherFarm.id!,
      );
      expect(otherSnapshot.animals, isEmpty);
      expect(otherSnapshot.alerts, isEmpty);
    });

    test(
      'observation persists assessment, actionable alert/task, idempotently',
      () async {
        await endpoints.observation.create(
          alice,
          animalId,
          DateTime.now().toUtc(),
          temperature: 40.1,
          appetiteScore: 2,
          activityScore: 3,
        );
        final first = await endpoints.sentinel.getLatest(alice, animalId);
        expect(first, isNotNull);
        expect(first!.riskLevel, RiskLevel.high);
        expect(first.detectedSignals, contains('elevated_temperature'));

        await endpoints.sentinel.evaluate(alice, animalId);
        final alerts = await endpoints.alert.listActive(alice, farmId);
        final tasks = await endpoints.task.list(
          alice,
          farmId,
          status: TaskStatus.open,
        );
        expect(
          alerts.where(
            (a) =>
                a.animalId == animalId && a.title.startsWith('Farm Sentinel'),
          ),
          hasLength(1),
        );
        final sentinelTasks = tasks
            .where(
              (t) =>
                  t.animalId == animalId &&
                  t.title.startsWith('Sentinel follow-up'),
            )
            .toList();
        expect(sentinelTasks, hasLength(1));
        // Sentinel follow-ups are persisted without an explicit due date.
        expect(sentinelTasks.single.dueAt, isNull);

        final persisted = await SentinelAssessment.db.find(
          alice.build(),
          where: (t) => t.animalId.equals(animalId),
        );
        expect(persisted, hasLength(1));
      },
    );

    test(
      'declining milk is detected only after two persisted records',
      () async {
        final now = DateTime.now().toUtc();
        await endpoints.production.create(
          alice,
          animalId,
          now.subtract(const Duration(days: 1)),
          'milk',
          10,
          'L',
        );
        final one = await endpoints.sentinel.getLatest(alice, animalId);
        expect(one, isNotNull);
        expect(
          one!.detectedSignals,
          isNot(contains('declining_milk_production')),
        );
        await endpoints.production.create(alice, animalId, now, 'milk', 7, 'L');
        final two = await endpoints.sentinel.getLatest(alice, animalId);
        expect(two!.detectedSignals, contains('declining_milk_production'));
      },
    );

    test(
      'low risk resolves the alert and cancels the open follow-up',
      () async {
        final now = DateTime.now().toUtc();
        await endpoints.observation.create(
          alice,
          animalId,
          now.subtract(const Duration(minutes: 1)),
          temperature: 40.1,
          appetiteScore: 2,
          activityScore: 3,
        );
        await endpoints.observation.create(
          alice,
          animalId,
          now,
          temperature: 38.5,
          appetiteScore: 8,
          activityScore: 8,
        );

        final assessment = await endpoints.sentinel.getLatest(alice, animalId);
        final alerts = await endpoints.alert.listActive(alice, farmId);
        final openTasks = await endpoints.task.list(
          alice,
          farmId,
          status: TaskStatus.open,
        );
        final allTasks = await endpoints.task.list(alice, farmId);

        expect(assessment!.riskLevel, RiskLevel.low);
        expect(alerts.where((a) => a.animalId == animalId), isEmpty);
        expect(
          openTasks.where((t) => t.title.startsWith('Sentinel follow-up')),
          isEmpty,
        );
        expect(
          allTasks
              .singleWhere((t) => t.title.startsWith('Sentinel follow-up'))
              .status,
          TaskStatus.cancelled,
        );
      },
    );
  });
}
