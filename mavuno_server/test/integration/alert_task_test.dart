import 'package:mavuno_server/src/generated/protocol.dart';
import 'package:test/test.dart';

import 'test_tools/serverpod_test_tools.dart';

void main() {
  // ─── Alert tests ────────────────────────────────────────────────────────────

  withServerpod('Given AlertEndpoint', (sessionBuilder, endpoints) {
    final aliceSession = sessionBuilder.copyWith(
      authentication: AuthenticationOverride.authenticationInfo(
        'user-alice',
        {},
      ),
    );
    final bobSession = sessionBuilder.copyWith(
      authentication: AuthenticationOverride.authenticationInfo(
        'user-bob',
        {},
      ),
    );

    late int farmId;
    late int animalId;

    setUp(() async {
      final farm = await endpoints.farm.create(aliceSession, 'Alert Test Farm');
      farmId = farm.id!;
      final animal = await endpoints.animal.create(
        aliceSession,
        farmId,
        'COW-ALERT',
        AnimalSpecies.cattle,
        AnimalSex.female,
        status: AnimalStatus.active,
      );
      animalId = animal.id!;
    });

    group('alerts — lifecycle', () {
      test('seeded alert appears in active list', () async {
        // Alerts are server-generated in production; seed via direct DB insert.
        final rawSession = aliceSession.build();
        await FarmAlert.db.insertRow(
          rawSession,
          FarmAlert(
            farmId: farmId,
            animalId: animalId,
            severity: AlertSeverity.high,
            alertType: AlertType.health,
            title: 'Test alert',
            description: 'Integration test alert.',
            createdAt: DateTime.now().toUtc(),
          ),
        );

        final active = await endpoints.alert.listActive(aliceSession, farmId);
        expect(active, isNotEmpty);
        expect(active.any((a) => a.title == 'Test alert'), isTrue);
      });

      test('resolved alert disappears from active list', () async {
        final rawSession = aliceSession.build();
        final alert = await FarmAlert.db.insertRow(
          rawSession,
          FarmAlert(
            farmId: farmId,
            animalId: null,
            severity: AlertSeverity.low,
            alertType: AlertType.operational,
            title: 'Resolved alert',
            description: 'Will be resolved.',
            createdAt: DateTime.now().toUtc(),
          ),
        );

        await endpoints.alert.resolve(aliceSession, alert.id!);

        final active = await endpoints.alert.listActive(aliceSession, farmId);
        expect(active.any((a) => a.id == alert.id), isFalse);
      });

      test('acknowledge sets acknowledgedAt timestamp', () async {
        final rawSession = aliceSession.build();
        final alert = await FarmAlert.db.insertRow(
          rawSession,
          FarmAlert(
            farmId: farmId,
            animalId: null,
            severity: AlertSeverity.moderate,
            alertType: AlertType.nutrition,
            title: 'Feed alert',
            description: 'Low feed stock.',
            createdAt: DateTime.now().toUtc(),
          ),
        );

        expect(alert.acknowledgedAt, isNull);
        final acked = await endpoints.alert.acknowledge(
          aliceSession,
          alert.id!,
        );
        expect(acked.acknowledgedAt, isNotNull);
      });

      test("rejects access to another user's farm alerts", () async {
        await expectLater(
          endpoints.alert.listActive(bobSession, farmId),
          throwsA(isA<Exception>()),
        );
      });
    });
  });

  // ─── Task tests ─────────────────────────────────────────────────────────────

  withServerpod('Given TaskEndpoint', (sessionBuilder, endpoints) {
    final aliceSession = sessionBuilder.copyWith(
      authentication: AuthenticationOverride.authenticationInfo(
        'user-alice',
        {},
      ),
    );
    final bobSession = sessionBuilder.copyWith(
      authentication: AuthenticationOverride.authenticationInfo(
        'user-bob',
        {},
      ),
    );

    late int farmId;
    late int animalId;

    setUp(() async {
      final farm = await endpoints.farm.create(aliceSession, 'Task Test Farm');
      farmId = farm.id!;
      final animal = await endpoints.animal.create(
        aliceSession,
        farmId,
        'COW-TASK',
        AnimalSpecies.cattle,
        AnimalSex.female,
        status: AnimalStatus.active,
      );
      animalId = animal.id!;
    });

    group('tasks — creation and lifecycle', () {
      test('creates a task with priority, animalId, and due date', () async {
        final task = await endpoints.task.create(
          aliceSession,
          farmId,
          'Vet check',
          animalId: animalId,
          description: 'Schedule veterinary examination.',
          priority: TaskPriority.urgent,
          dueAt: DateTime.now().add(const Duration(days: 1)),
        );
        expect(task.id, isNotNull);
        expect(task.title, equals('Vet check'));
        expect(task.farmId, equals(farmId));
        expect(task.animalId, equals(animalId));
        expect(task.status, equals(TaskStatus.open));
        expect(task.priority, equals(TaskPriority.urgent));
      });

      test('rejects task with blank title', () async {
        await expectLater(
          endpoints.task.create(
            aliceSession,
            farmId,
            '   ',
            priority: TaskPriority.low,
          ),
          throwsA(isA<Exception>()),
        );
      });

      test('complete sets status=completed and completedAt', () async {
        final task = await endpoints.task.create(
          aliceSession,
          farmId,
          'Restock feed',
          priority: TaskPriority.high,
        );
        expect(task.status, equals(TaskStatus.open));
        expect(task.completedAt, isNull);

        final done = await endpoints.task.complete(aliceSession, task.id!);
        expect(done.status, equals(TaskStatus.completed));
        expect(done.completedAt, isNotNull);
      });

      test('status filter excludes completed tasks from open list', () async {
        final t1 = await endpoints.task.create(
          aliceSession,
          farmId,
          'Open task',
          priority: TaskPriority.medium,
        );
        final t2 = await endpoints.task.create(
          aliceSession,
          farmId,
          'Completing this one',
          priority: TaskPriority.low,
        );
        await endpoints.task.complete(aliceSession, t2.id!);

        final openTasks = await endpoints.task.list(
          aliceSession,
          farmId,
          status: TaskStatus.open,
        );
        expect(openTasks.any((t) => t.id == t1.id), isTrue);
        expect(openTasks.any((t) => t.id == t2.id), isFalse);
      });

      test("rejects task creation on another user's farm", () async {
        await expectLater(
          endpoints.task.create(
            bobSession,
            farmId,
            'Bob task',
            priority: TaskPriority.low,
          ),
          throwsA(isA<Exception>()),
        );
      });
    });
  });
}
