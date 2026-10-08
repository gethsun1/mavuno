import 'package:mavuno_server/src/generated/protocol.dart';
import 'package:test/test.dart';

import 'test_tools/serverpod_test_tools.dart';

void main() {
  withServerpod('Given IntelligenceEndpoint', (sessionBuilder, endpoints) {
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

    test('requires authentication and farm ownership to subscribe', () async {
      final farm = await endpoints.farm.create(aliceSession, 'Alice farm');

      await expectLater(
        endpoints.intelligence.watchFarm(sessionBuilder, farm.id!).first,
        throwsA(isA<Exception>()),
      );
      await expectLater(
        endpoints.intelligence.watchFarm(bobSession, farm.id!).first,
        throwsA(isA<Exception>()),
      );
    });

    test(
      'observation publishes a small event after Sentinel completes',
      () async {
        final farm = await endpoints.farm.create(aliceSession, 'Alice farm');
        final animal = await endpoints.animal.create(
          aliceSession,
          farm.id!,
        'COW-07',
        AnimalSpecies.cattle,
        AnimalSex.female,
        status: AnimalStatus.active,
      );
        final event = endpoints.intelligence
            .watchFarm(
              aliceSession,
              farm.id!,
            )
            .first
            .timeout(const Duration(seconds: 5));

        // Let the Serverpod method stream register its MessageCentral listener.
        await Future<void>.delayed(const Duration(milliseconds: 100));
        await endpoints.observation.create(
          aliceSession,
          animal.id!,
          DateTime.now().toUtc(),
          temperature: 40.1,
          appetiteScore: 2,
          activityScore: 3,
        );

      expect((await event).farmId, farm.id);
      },
    );
  });
}
