import 'package:serverpod/serverpod.dart';

import '../generated/protocol.dart';
import '../shared/farm_access.dart';
import 'intelligence_event_service.dart';

class IntelligenceEndpoint extends Endpoint {
  @override
  bool get requireLogin => true;

  Future<void> _authorize(Session session, int farmId) async {
    await FarmAccess.ownedFarm(session, farmId);
  }

  Stream<FarmIntelligenceChanged> watchFarm(
    Session session,
    int farmId,
  ) async* {
    await _authorize(session, farmId);
    yield* session.messages.createStream<FarmIntelligenceChanged>(
      IntelligenceEventService.channelForFarm(farmId),
    );
  }
}
