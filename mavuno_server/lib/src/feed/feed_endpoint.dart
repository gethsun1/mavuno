import 'package:serverpod/serverpod.dart';
import '../generated/protocol.dart';
import '../shared/farm_access.dart';

class FeedEndpoint extends Endpoint {
  /// Record feed given to a farm or an individual animal.
  ///
  /// [animalId] is optional — pass null when recording herd-level feeding
  /// where individual attribution is not practical.
  Future<FeedRecord> create(
    Session session,
    int farmId,
    DateTime recordedAt,
    String feedType,
    double quantity,
    String unit, {
    int? animalId,
    String? notes,
  }) async {
    await FarmAccess.ownedFarm(session, farmId);
    if (animalId != null) {
      final animal = await FarmAccess.ownedAnimal(session, animalId);
      if (animal.farmId != farmId) {
        throw Exception('Animal does not belong to the specified farm.');
      }
    }
    if (feedType.trim().isEmpty) {
      throw Exception('Feed type is required.');
    }
    if (unit.trim().isEmpty) {
      throw Exception('Unit is required.');
    }
    if (quantity < 0) {
      throw Exception('Quantity cannot be negative.');
    }
    return FeedRecord.db.insertRow(
      session,
      FeedRecord(
        farmId: farmId,
        animalId: animalId,
        recordedAt: recordedAt.toUtc(),
        feedType: feedType.trim(),
        quantity: quantity,
        unit: unit.trim(),
        notes: notes?.trim(),
      ),
    );
  }

  /// List all feed records for a farm, ordered by recorded time.
  Future<List<FeedRecord>> listByFarm(
    Session session,
    int farmId, {
    int limit = 100,
  }) async {
    await FarmAccess.ownedFarm(session, farmId);
    return FeedRecord.db.find(
      session,
      where: (t) => t.farmId.equals(farmId),
      orderBy: (t) => t.recordedAt,
      limit: limit.clamp(1, 500),
    );
  }

  /// List feed records attributed to a specific animal.
  Future<List<FeedRecord>> listByAnimal(
    Session session,
    int animalId, {
    int limit = 100,
  }) async {
    await FarmAccess.ownedAnimal(session, animalId);
    return FeedRecord.db.find(
      session,
      where: (t) => t.animalId.equals(animalId),
      orderBy: (t) => t.recordedAt,
      limit: limit.clamp(1, 500),
    );
  }
}
