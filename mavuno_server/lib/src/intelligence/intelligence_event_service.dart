import 'package:serverpod/serverpod.dart';

import '../generated/protocol.dart';

class IntelligenceEventService {
  static String channelForFarm(int farmId) => 'farm-intelligence-$farmId';

  static Future<void> publish(Session session, int farmId) async {
    await session.messages.postMessage(
      channelForFarm(farmId),
      FarmIntelligenceChanged(farmId: farmId),
      scope: MessageScope.auto,
    );
  }
}
