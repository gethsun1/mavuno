import 'package:serverpod/serverpod.dart';

import '../generated/protocol.dart';

/// Centralizes tenant checks so endpoint methods never trust a client owner id.
class FarmAccess {
  static String requireUser(Session session) {
    final userId = session.authenticated?.userIdentifier;
    if (userId == null) throw Exception('Authentication is required.');
    return userId;
  }

  static Future<Farm> ownedFarm(Session session, int farmId) async {
    final farm = await Farm.db.findById(session, farmId);
    if (farm == null || farm.ownerId != requireUser(session)) {
      throw Exception('Farm not found or access is not permitted.');
    }
    return farm;
  }

  static Future<Animal> ownedAnimal(Session session, int animalId) async {
    final animal = await Animal.db.findById(session, animalId);
    if (animal == null) throw Exception('Animal not found.');
    await ownedFarm(session, animal.farmId);
    return animal;
  }
}
