import 'package:serverpod/serverpod.dart';
import '../generated/protocol.dart';
import '../shared/farm_access.dart';

class HealthEndpoint extends Endpoint {
  Future<HealthRecord> create(
    Session session,
    int animalId,
    DateTime recordedAt,
    String recordType,
    String description, {
    String? professionalName,
    String? notes,
  }) async {
    await FarmAccess.ownedAnimal(session, animalId);
    if (recordType.trim().isEmpty || description.trim().isEmpty) {
      throw ArgumentError('Record type and description are required.');
    }
    return HealthRecord.db.insertRow(
      session,
      HealthRecord(
        animalId: animalId,
        recordedAt: recordedAt.toUtc(),
        recordType: recordType.trim(),
        description: description.trim(),
        professionalName: professionalName?.trim(),
        notes: notes?.trim(),
      ),
    );
  }

  Future<List<HealthRecord>> listByAnimal(Session session, int animalId) async {
    await FarmAccess.ownedAnimal(session, animalId);
    return HealthRecord.db.find(
      session,
      where: (t) => t.animalId.equals(animalId),
      orderBy: (t) => t.recordedAt,
    );
  }

  Future<VaccinationRecord> createVaccination(
    Session session,
    int animalId,
    String vaccination,
    DateTime administeredAt, {
    DateTime? nextDueAt,
    String? provider,
    String? notes,
  }) async {
    await FarmAccess.ownedAnimal(session, animalId);
    if (vaccination.trim().isEmpty ||
        (nextDueAt != null && nextDueAt.isBefore(administeredAt))) {
      throw ArgumentError(
        'Vaccination and a valid next due date are required.',
      );
    }
    return VaccinationRecord.db.insertRow(
      session,
      VaccinationRecord(
        animalId: animalId,
        vaccination: vaccination.trim(),
        administeredAt: administeredAt.toUtc(),
        nextDueAt: nextDueAt?.toUtc(),
        provider: provider?.trim(),
        notes: notes?.trim(),
      ),
    );
  }

  Future<List<VaccinationRecord>> listVaccinations(
    Session session,
    int animalId,
  ) async {
    await FarmAccess.ownedAnimal(session, animalId);
    return VaccinationRecord.db.find(
      session,
      where: (t) => t.animalId.equals(animalId),
      orderBy: (t) => t.administeredAt,
    );
  }
}
