import 'package:serverpod/serverpod.dart';
import '../generated/protocol.dart';
import '../shared/farm_access.dart';

class FarmEndpoint extends Endpoint {
  Future<Farm> create(
    Session session,
    String name, {
    String? location,
    String? farmType,
    String? description,
  }) async {
    if (name.trim().isEmpty) {
      throw Exception('Farm name is required.');
    }
    final now = DateTime.now().toUtc();
    return Farm.db.insertRow(
      session,
      Farm(
        ownerId: FarmAccess.requireUser(session),
        name: name.trim(),
        location: location?.trim(),
        farmType: farmType?.trim(),
        description: description?.trim(),
        createdAt: now,
        updatedAt: now,
      ),
    );
  }

  Future<List<Farm>> list(Session session) => Farm.db.find(
    session,
    where: (t) => t.ownerId.equals(FarmAccess.requireUser(session)),
    orderBy: (t) => t.createdAt,
  );
  Future<Farm> get(Session session, int farmId) =>
      FarmAccess.ownedFarm(session, farmId);
  Future<Farm> update(
    Session session,
    int farmId,
    String name, {
    String? location,
    String? farmType,
    String? description,
  }) async {
    final farm = await FarmAccess.ownedFarm(session, farmId);
    if (name.trim().isEmpty) {
      throw Exception('Farm name is required.');
    }
    return Farm.db.updateRow(
      session,
      farm.copyWith(
        name: name.trim(),
        location: location?.trim(),
        farmType: farmType?.trim(),
        description: description?.trim(),
        updatedAt: DateTime.now().toUtc(),
      ),
    );
  }
}
