import 'package:test/test.dart';

import 'test_tools/serverpod_test_tools.dart';

void main() {
  withServerpod('Given FarmEndpoint', (sessionBuilder, endpoints) {
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

    group('create', () {
      test('creates a farm with required name', () async {
        final farm = await endpoints.farm.create(aliceSession, 'Green Acres');
        expect(farm.id, isNotNull);
        expect(farm.name, equals('Green Acres'));
        expect(farm.ownerId, equals('user-alice'));
      });

      test('trims whitespace from name', () async {
        final farm = await endpoints.farm.create(
          aliceSession,
          '  Trimmed Farm  ',
        );
        expect(farm.name, equals('Trimmed Farm'));
      });

      test('rejects empty name', () async {
        await expectLater(
          endpoints.farm.create(aliceSession, '   '),
          throwsA(isA<Exception>()),
        );
      });

      test('rejects unauthenticated request', () async {
        await expectLater(
          endpoints.farm.create(sessionBuilder, 'Farm'),
          throwsA(isA<Exception>()),
        );
      });
    });

    group('list and get', () {
      test('lists only farms owned by the requesting user', () async {
        final aliceFarm = await endpoints.farm.create(
          aliceSession,
          'Alice Farm',
        );
        await endpoints.farm.create(bobSession, 'Bob Farm');

        final aliceFarms = await endpoints.farm.list(aliceSession);
        expect(aliceFarms, hasLength(1));
        expect(aliceFarms.first.id, equals(aliceFarm.id));
      });

      test('get returns own farm by id', () async {
        final created = await endpoints.farm.create(aliceSession, 'My Farm');
        final fetched = await endpoints.farm.get(aliceSession, created.id!);
        expect(fetched.id, equals(created.id));
        expect(fetched.name, equals('My Farm'));
      });

      test("get rejects access to another user's farm", () async {
        final aliceFarm = await endpoints.farm.create(
          aliceSession,
          'Alice Farm',
        );
        await expectLater(
          endpoints.farm.get(bobSession, aliceFarm.id!),
          throwsA(isA<Exception>()),
        );
      });
    });

    group('update', () {
      test('updates farm name and location', () async {
        final farm = await endpoints.farm.create(aliceSession, 'Old Name');
        final updated = await endpoints.farm.update(
          aliceSession,
          farm.id!,
          'New Name',
          location: 'Naivasha',
        );
        expect(updated.name, equals('New Name'));
        expect(updated.location, equals('Naivasha'));
      });
    });
  });
}
