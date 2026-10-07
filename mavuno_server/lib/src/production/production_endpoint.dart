import 'package:serverpod/serverpod.dart';
import '../generated/protocol.dart';
import '../shared/farm_access.dart';

class ProductionEndpoint extends Endpoint {
  Future<ProductionRecord> create(
    Session session,
    int animalId,
    DateTime recordedAt,
    String metricType,
    double value,
    String unit, {
    String? notes,
  }) async {
    await FarmAccess.ownedAnimal(session, animalId);
    if (metricType.trim().isEmpty ||
        unit.trim().isEmpty ||
        !value.isFinite ||
        value < 0) {
      throw Exception(
        'Metric, unit, and a non-negative value are required.',
      );
    }
    if (recordedAt.isAfter(DateTime.now().add(const Duration(minutes: 5)))) {
      throw Exception('Production record cannot be in the future.');
    }
    return ProductionRecord.db.insertRow(
      session,
      ProductionRecord(
        animalId: animalId,
        recordedAt: recordedAt.toUtc(),
        metricType: metricType.trim(),
        value: value,
        unit: unit.trim(),
        notes: notes?.trim(),
      ),
    );
  }

  Future<List<ProductionRecord>> listByAnimal(
    Session session,
    int animalId,
  ) async {
    await FarmAccess.ownedAnimal(session, animalId);
    return ProductionRecord.db.find(
      session,
      where: (t) => t.animalId.equals(animalId),
      orderBy: (t) => t.recordedAt.desc(),
    );
  }
}
