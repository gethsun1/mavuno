import 'package:serverpod/serverpod.dart';
import '../generated/protocol.dart';
import '../shared/farm_access.dart';

class AnimalEndpoint extends Endpoint {
  Future<Animal> create(
    Session session,
    int farmId,
    String tag,
    AnimalSpecies species,
    AnimalSex sex, {
    String? name,
    String? breed,
    DateTime? dateOfBirth,
    AnimalStatus status = AnimalStatus.active,
    String? notes,
  }) async {
    await FarmAccess.ownedFarm(session, farmId);
    if (tag.trim().isEmpty) {
      throw Exception('Animal tag is required.');
    }
    if (dateOfBirth != null && dateOfBirth.isAfter(DateTime.now())) {
      throw Exception('Date of birth cannot be in the future.');
    }
    final now = DateTime.now().toUtc();
    return Animal.db.insertRow(
      session,
      Animal(
        farmId: farmId,
        tag: tag.trim(),
        name: name?.trim(),
        species: species,
        breed: breed?.trim(),
        sex: sex,
        dateOfBirth: dateOfBirth?.toUtc(),
        status: status,
        notes: notes?.trim(),
        createdAt: now,
        updatedAt: now,
      ),
    );
  }

  Future<Animal> get(Session session, int animalId) =>
      FarmAccess.ownedAnimal(session, animalId);

  Future<List<Animal>> listByFarm(Session session, int farmId) async {
    await FarmAccess.ownedFarm(session, farmId);
    return Animal.db.find(
      session,
      where: (t) => t.farmId.equals(farmId),
      orderBy: (t) => t.tag,
    );
  }

  Future<Animal> update(
    Session session,
    int animalId, {
    String? tag,
    String? name,
    String? breed,
    AnimalStatus? status,
    DateTime? dateOfBirth,
    String? notes,
  }) async {
    final animal = await FarmAccess.ownedAnimal(session, animalId);
    final newTag = tag?.trim() ?? animal.tag;
    if (newTag.isEmpty) {
      throw Exception('Animal tag cannot be empty.');
    }
    if (dateOfBirth != null && dateOfBirth.isAfter(DateTime.now())) {
      throw Exception('Date of birth cannot be in the future.');
    }
    return Animal.db.updateRow(
      session,
      animal.copyWith(
        tag: newTag,
        name: name?.trim() ?? animal.name,
        breed: breed?.trim() ?? animal.breed,
        status: status ?? animal.status,
        dateOfBirth: dateOfBirth?.toUtc() ?? animal.dateOfBirth,
        notes: notes?.trim() ?? animal.notes,
        updatedAt: DateTime.now().toUtc(),
      ),
    );
  }
}
