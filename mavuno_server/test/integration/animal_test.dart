import 'package:mavuno_server/src/generated/protocol.dart';
import 'package:test/test.dart';

import 'test_tools/serverpod_test_tools.dart';

void main() {
  withServerpod('Given AnimalEndpoint', (sessionBuilder, endpoints) {
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

    setUp(() async {
      final farm = await endpoints.farm.create(aliceSession, 'Test Farm');
      farmId = farm.id!;
    });

    group('create', () {
      test('creates an animal on an owned farm', () async {
        final animal = await endpoints.animal.create(
          aliceSession,
          farmId,
          'COW-01',
          AnimalSpecies.cattle,
          AnimalSex.female,
          name: 'Bessie',
          status: AnimalStatus.active,
        );
        expect(animal.id, isNotNull);
        expect(animal.tag, equals('COW-01'));
        expect(animal.farmId, equals(farmId));
        expect(animal.species, equals(AnimalSpecies.cattle));
      });

      test('animal is linked to the correct farm', () async {
        final animal = await endpoints.animal.create(
          aliceSession,
          farmId,
          'SHEEP-01',
          AnimalSpecies.sheep,
          AnimalSex.female,
          status: AnimalStatus.active,
        );
        final fetched = await endpoints.animal.get(aliceSession, animal.id!);
        expect(fetched.farmId, equals(farmId));
      });

      test('rejects empty tag', () async {
        await expectLater(
          endpoints.animal.create(
            aliceSession,
            farmId,
            '   ',
            AnimalSpecies.cattle,
            AnimalSex.female,
            status: AnimalStatus.active,
          ),
          throwsA(isA<Exception>()),
        );
      });

      test('rejects future date of birth', () async {
        await expectLater(
          endpoints.animal.create(
            aliceSession,
            farmId,
            'COW-FUT',
            AnimalSpecies.cattle,
            AnimalSex.female,
            dateOfBirth: DateTime.now().add(const Duration(days: 10)),
            status: AnimalStatus.active,
          ),
          throwsA(isA<Exception>()),
        );
      });

      test("rejects creation on another user's farm", () async {
        await expectLater(
          endpoints.animal.create(
            bobSession,
            farmId,
            'COW-BOB',
            AnimalSpecies.cattle,
            AnimalSex.male,
            status: AnimalStatus.active,
          ),
          throwsA(isA<Exception>()),
        );
      });
    });

    group('listByFarm', () {
      test('returns all animals for an owned farm', () async {
        await endpoints.animal.create(
          aliceSession,
          farmId,
          'G1',
          AnimalSpecies.goats,
          AnimalSex.female,
          status: AnimalStatus.active,
        );
        await endpoints.animal.create(
          aliceSession,
          farmId,
          'G2',
          AnimalSpecies.goats,
          AnimalSex.male,
          status: AnimalStatus.active,
        );
        final animals = await endpoints.animal.listByFarm(aliceSession, farmId);
        expect(animals.length, greaterThanOrEqualTo(2));
        expect(animals.every((a) => a.farmId == farmId), isTrue);
      });
    });

    group('update', () {
      test('updates animal status and notes', () async {
        final animal = await endpoints.animal.create(
          aliceSession,
          farmId,
          'COW-UPD',
          AnimalSpecies.cattle,
          AnimalSex.female,
          status: AnimalStatus.active,
        );
        final updated = await endpoints.animal.update(
          aliceSession,
          animal.id!,
          status: AnimalStatus.quarantined,
          notes: 'Isolated for observation',
        );
        expect(updated.status, equals(AnimalStatus.quarantined));
        expect(updated.notes, equals('Isolated for observation'));
      });
    });
  });
}
