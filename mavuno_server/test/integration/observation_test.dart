import 'package:mavuno_server/src/generated/protocol.dart';
import 'package:test/test.dart';

import 'test_tools/serverpod_test_tools.dart';

void main() {
  withServerpod('Given ObservationEndpoint', (sessionBuilder, endpoints) {
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
      final farm = await endpoints.farm.create(aliceSession, 'Obs Test Farm');
      farmId = farm.id!;
      final animal = await endpoints.animal.create(
        aliceSession,
        farmId,
        'COW-OBS',
        AnimalSpecies.cattle,
        AnimalSex.female,
        status: AnimalStatus.active,
      );
      animalId = animal.id!;
    });

    group('create', () {
      test('creates an observation with valid data', () async {
        final obs = await endpoints.observation.create(
          aliceSession,
          animalId,
          DateTime.now().subtract(const Duration(hours: 1)),
          temperature: 38.5,
          activityScore: 8,
          appetiteScore: 7,
          feedIntake: 15.0,
          productionValue: 20.0,
          productionUnit: 'litres',
        );
        expect(obs.id, isNotNull);
        expect(obs.animalId, equals(animalId));
        expect(obs.temperature, closeTo(38.5, 0.01));
        expect(obs.activityScore, equals(8));
      });

      test('rejects temperature below 30', () async {
        await expectLater(
          endpoints.observation.create(
            aliceSession,
            animalId,
            DateTime.now().subtract(const Duration(minutes: 5)),
            temperature: 25.0,
          ),
          throwsA(isA<Exception>()),
        );
      });

      test('rejects temperature above 45', () async {
        await expectLater(
          endpoints.observation.create(
            aliceSession,
            animalId,
            DateTime.now().subtract(const Duration(minutes: 5)),
            temperature: 50.0,
          ),
          throwsA(isA<Exception>()),
        );
      });

      test('rejects negative feedIntake', () async {
        await expectLater(
          endpoints.observation.create(
            aliceSession,
            animalId,
            DateTime.now().subtract(const Duration(minutes: 5)),
            feedIntake: -5.0,
          ),
          throwsA(isA<Exception>()),
        );
      });

      test('rejects activity score above 10', () async {
        await expectLater(
          endpoints.observation.create(
            aliceSession,
            animalId,
            DateTime.now().subtract(const Duration(minutes: 5)),
            activityScore: 11,
          ),
          throwsA(isA<Exception>()),
        );
      });

      test('rejects future observation timestamp', () async {
        await expectLater(
          endpoints.observation.create(
            aliceSession,
            animalId,
            DateTime.now().add(const Duration(hours: 2)),
          ),
          throwsA(isA<Exception>()),
        );
      });

      test("rejects observation on another user's animal", () async {
        await expectLater(
          endpoints.observation.create(
            bobSession,
            animalId,
            DateTime.now().subtract(const Duration(minutes: 5)),
          ),
          throwsA(isA<Exception>()),
        );
      });
    });

    group('listByAnimal', () {
      test('retrieves observations in chronological order', () async {
        for (var i = 3; i >= 1; i--) {
          await endpoints.observation.create(
            aliceSession,
            animalId,
            DateTime.now().subtract(Duration(hours: i)),
            temperature: 38.0 + i * 0.1,
          );
        }
        final records = await endpoints.observation.listByAnimal(
          aliceSession,
          animalId,
          limit: 50,
        );
        expect(records.length, greaterThanOrEqualTo(3));
        for (var i = 1; i < records.length; i++) {
          expect(
            !records[i].recordedAt.isBefore(records[i - 1].recordedAt),
            isTrue,
            reason: 'Observations must be in ascending recordedAt order',
          );
        }
      });

      test('respects limit parameter', () async {
        for (var i = 15; i >= 1; i--) {
          await endpoints.observation.create(
            aliceSession,
            animalId,
            DateTime.now().subtract(Duration(hours: i)),
          );
        }
        final records = await endpoints.observation.listByAnimal(
          aliceSession,
          animalId,
          limit: 5,
        );
        expect(records.length, lessThanOrEqualTo(5));
      });
    });
  });
}
