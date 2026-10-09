import 'package:serverpod/serverpod.dart';
import '../generated/protocol.dart';
import '../shared/farm_access.dart';

class AnimalEndpoint extends Endpoint {
  static const _maxPhotoBytes = 5 * 1024 * 1024;

  Future<String> createPhotoUpload(
    Session session,
    int animalId,
    String contentType,
    int size,
  ) async {
    final animal = await FarmAccess.ownedAnimal(session, animalId);
    const accepted = {'image/jpeg', 'image/png', 'image/webp'};
    if (!accepted.contains(contentType)) {
      throw Exception('Choose a JPEG, PNG, or WebP image.');
    }
    if (size <= 0 || size > _maxPhotoBytes) {
      throw Exception('Animal photos must be smaller than 5 MB.');
    }
    final path = 'farms/${animal.farmId}/animals/$animalId/profile';
    return session.storage.createUploadDescription(
      storageId: 'private',
      path: path,
      options: UploadOptions(
        maxFileSize: _maxPhotoBytes,
        contentLength: size,
        metadata: FileMetadata(contentType: contentType),
      ),
    );
  }

  Future<bool> completePhotoUpload(Session session, int animalId) async {
    final animal = await FarmAccess.ownedAnimal(session, animalId);
    final path = 'farms/${animal.farmId}/animals/$animalId/profile';
    final verified = await session.storage.verifyUpload(
      storageId: 'private',
      path: path,
    );
    if (!verified) throw Exception('The photo upload could not be verified.');
    await Animal.db.updateRow(
      session,
      animal.copyWith(photoPath: path, updatedAt: DateTime.now().toUtc()),
    );
    return true;
  }

  Future<String?> getPhotoUrl(Session session, int animalId) async {
    final animal = await FarmAccess.ownedAnimal(session, animalId);
    final path = animal.photoPath;
    if (path == null) return null;
    return (await session.storage.temporaryDownloadUrl(
      storageId: 'private',
      path: path,
      options: const TemporaryDownloadUrlOptions(
        expirationDuration: Duration(minutes: 15),
      ),
    )).toString();
  }

  Future<bool> removePhoto(Session session, int animalId) async {
    final animal = await FarmAccess.ownedAnimal(session, animalId);
    final path = animal.photoPath;
    if (path == null) return true;
    await Animal.db.updateRow(
      session,
      animal.copyWith(photoPath: null, updatedAt: DateTime.now().toUtc()),
    );
    await session.storage.deleteFile(storageId: 'private', path: path);
    return true;
  }

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
