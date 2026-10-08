import 'package:serverpod/serverpod.dart';

import '../generated/protocol.dart';
import '../shared/farm_access.dart';
import 'sentinel_service.dart';
import 'sentinel_explanation_service.dart';

class SentinelEndpoint extends Endpoint {
  SentinelEndpoint({SentinelExplanationService? explanationService})
    : _explanationService = explanationService ?? SentinelExplanationService();

  final SentinelExplanationService _explanationService;

  Future<SentinelAiExplanation?> explainLatest(
    Session session,
    int animalId,
  ) => _explanationService.explainLatest(session, animalId);

  Future<SentinelAssessment?> getLatest(Session session, int animalId) async {
    await FarmAccess.ownedAnimal(session, animalId);
    return SentinelAssessment.db.findFirstRow(
      session,
      where: (t) => t.animalId.equals(animalId),
      orderBy: (t) => t.assessedAt.desc(),
    );
  }

  Future<SentinelAssessment?> evaluate(Session session, int animalId) =>
      SentinelService.evaluateAnimal(session, animalId);
}
