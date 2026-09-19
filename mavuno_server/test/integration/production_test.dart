import 'package:mavuno_server/src/generated/protocol.dart';
import 'package:test/test.dart';

import 'test_tools/serverpod_test_tools.dart';

void main() {
  withServerpod('Given ProductionEndpoint', (sessionBuilder, endpoints) {
    final aliceSession = sessionBuilder.copyWith(
      authentication: AuthenticationOverride.authenticationInfo(
        'user-alice',
        {},
      ),
    );

    late int farmId;
    late int animalId;

    setUp(() async {
      final farm = await endpoints.farm.create(aliceSession, 'Prod Test Farm');
      farmId = farm.id!;
      final animal = await endpoints.animal.create(
        aliceSession,
        farmId,
        'COW-PROD',
        AnimalSpecies.cattle,
        AnimalSex.female,
        status: AnimalStatus.active,
      );
      animalId = animal.id!;
    });

    group('create', () {
      test('creates a milk production record', () async {
        final record = await endpoints.production.create(
          aliceSession,
          animalId,
          DateTime.now().subtract(const Duration(hours: 1)),
          'milk',
          22.5,
          'litres',
        );
        expect(record.id, isNotNull);
        expect(record.animalId, equals(animalId));
        expect(record.metricType, equals('milk'));
        expect(record.value, closeTo(22.5, 0.01));
        expect(record.unit, equals('litres'));
      });

      test('creates a weight record (flexible metricType)', () async {
        final record = await endpoints.production.create(
          aliceSession,
          animalId,
          DateTime.now().subtract(const Duration(hours: 1)),
          'weight',
          485.0,
          'kg',
        );
        expect(record.metricType, equals('weight'));
        expect(record.value, closeTo(485.0, 0.01));
      });

      test('rejects negative value', () async {
        await expectLater(
          endpoints.production.create(
            aliceSession,
            animalId,
            DateTime.now().subtract(const Duration(hours: 1)),
            'milk',
            -5.0,
            'litres',
          ),
          throwsA(isA<Exception>()),
        );
      });

      test('rejects empty metric type', () async {
        await expectLater(
          endpoints.production.create(
            aliceSession,
            animalId,
            DateTime.now().subtract(const Duration(hours: 1)),
            '',
            10.0,
            'litres',
          ),
          throwsA(isA<Exception>()),
        );
      });
    });

    group('listByAnimal', () {
      test('returns all records for an animal', () async {
        for (var i = 3; i >= 1; i--) {
          await endpoints.production.create(
            aliceSession,
            animalId,
            DateTime.now().subtract(Duration(days: i)),
            'milk',
            20.0 + i,
            'litres',
          );
        }
        final records = await endpoints.production.listByAnimal(
          aliceSession,
          animalId,
        );
        expect(records.length, greaterThanOrEqualTo(3));
        expect(records.every((r) => r.animalId == animalId), isTrue);
      });
    });
  });
}
