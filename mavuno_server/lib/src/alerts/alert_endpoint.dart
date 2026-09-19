import 'package:serverpod/serverpod.dart';
import '../generated/protocol.dart';
import '../shared/farm_access.dart';

class AlertEndpoint extends Endpoint {
  Future<List<FarmAlert>> listActive(Session session, int farmId) async {
    await FarmAccess.ownedFarm(session, farmId);
    return FarmAlert.db.find(
      session,
      where: (t) => (t.farmId.equals(farmId) & t.resolvedAt.equals(null)),
      orderBy: (t) => t.createdAt,
    );
  }

  Future<FarmAlert> acknowledge(Session session, int alertId) async {
    final alert = await FarmAlert.db.findById(session, alertId);
    if (alert == null) throw Exception('Alert not found.');
    await FarmAccess.ownedFarm(session, alert.farmId);
    return FarmAlert.db.updateRow(
      session,
      alert.copyWith(acknowledgedAt: DateTime.now().toUtc()),
    );
  }

  Future<FarmAlert> resolve(Session session, int alertId) async {
    final alert = await FarmAlert.db.findById(session, alertId);
    if (alert == null) throw Exception('Alert not found.');
    await FarmAccess.ownedFarm(session, alert.farmId);
    return FarmAlert.db.updateRow(
      session,
      alert.copyWith(resolvedAt: DateTime.now().toUtc()),
    );
  }
}
