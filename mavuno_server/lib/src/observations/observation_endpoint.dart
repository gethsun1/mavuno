import 'package:serverpod/serverpod.dart';
import '../generated/protocol.dart';
import '../shared/farm_access.dart';

class ObservationEndpoint extends Endpoint {
  Future<AnimalObservation> create(
    Session session,
    int animalId,
    DateTime recordedAt, {
    double? temperature,
    int? activityScore,
    int? appetiteScore,
    double? feedIntake,
    double? productionValue,
    String? productionUnit,
    String? visibleSymptoms,
    String? notes,
  }) async {
    await FarmAccess.ownedAnimal(session, animalId);
    if (temperature != null && (temperature < 30 || temperature > 45)) {
      throw ArgumentError('Temperature must be between 30 and 45 °C.');
    }
    if ((activityScore != null && (activityScore < 0 || activityScore > 10)) ||
        (appetiteScore != null && (appetiteScore < 0 || appetiteScore > 10))) {
      throw ArgumentError('Scores must be between 0 and 10.');
    }
    if ((feedIntake ?? 0) < 0 || (productionValue ?? 0) < 0) {
      throw ArgumentError('Measured values cannot be negative.');
    }
    if (recordedAt.isAfter(DateTime.now().add(const Duration(minutes: 5)))) {
      throw ArgumentError('Observation cannot be in the future.');
    }
    return AnimalObservation.db.insertRow(
      session,
      AnimalObservation(
        animalId: animalId,
        recordedAt: recordedAt.toUtc(),
        temperature: temperature,
        activityScore: activityScore,
        appetiteScore: appetiteScore,
        feedIntake: feedIntake,
        productionValue: productionValue,
        productionUnit: productionUnit?.trim(),
        visibleSymptoms: visibleSymptoms?.trim(),
        notes: notes?.trim(),
        recordedBy: FarmAccess.requireUser(session),
      ),
    );
  }

  Future<List<AnimalObservation>> listByAnimal(
    Session session,
    int animalId, {
    int limit = 100,
  }) async {
    await FarmAccess.ownedAnimal(session, animalId);
    return AnimalObservation.db.find(
      session,
      where: (t) => t.animalId.equals(animalId),
      orderBy: (t) => t.recordedAt,
      limit: limit.clamp(1, 500),
    );
  }
}
