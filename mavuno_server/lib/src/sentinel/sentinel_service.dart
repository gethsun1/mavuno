import 'package:serverpod/serverpod.dart';

import '../generated/protocol.dart';
import '../shared/farm_access.dart';
import 'sentinel_rules.dart';

class SentinelService {
  static const _alertTitlePrefix = 'Farm Sentinel';
  static const _taskTitlePrefix = 'Sentinel follow-up';

  static Future<SentinelAssessment?> evaluateAnimal(
    Session session,
    int animalId,
  ) async {
    final animal = await FarmAccess.ownedAnimal(session, animalId);
    final observations = await AnimalObservation.db.find(
      session,
      where: (t) => t.animalId.equals(animalId),
      orderBy: (t) => t.recordedAt.desc(),
    );
    final production = await ProductionRecord.db.find(
      session,
      where: (t) => t.animalId.equals(animalId),
      orderBy: (t) => t.recordedAt.desc(),
    );
    final result = SentinelEngine.evaluate(
      observations: observations,
      production: production,
    );
    if (result == null) return null;

    final previous = await SentinelAssessment.db.findFirstRow(
      session,
      where: (t) => t.animalId.equals(animalId),
      orderBy: (t) => t.assessedAt.desc(),
    );
    final changed =
        previous == null ||
        previous.riskLevel != result.riskLevel ||
        previous.detectedSignals != result.serializedSignals ||
        previous.baselineSummary != result.baselineSummary;
    final assessedAt = DateTime.now().toUtc();
    final assessment = previous == null
        ? await SentinelAssessment.db.insertRow(
            session,
            SentinelAssessment(
              farmId: animal.farmId,
              animalId: animalId,
              assessedAt: assessedAt,
              riskScore: result.signalCount,
              riskLevel: result.riskLevel,
              detectedSignals: result.serializedSignals,
              baselineSummary: result.baselineSummary,
              explanation:
                  'Deterministic assessment based on the latest available structured records. Signals indicate patterns requiring attention and are not a diagnosis.',
              recommendedAction: result.recommendedAction,
              sourceObservationId: result.sourceObservationId,
            ),
          )
        : await SentinelAssessment.db.updateRow(
            session,
            previous.copyWith(
              assessedAt: assessedAt,
              riskScore: result.signalCount,
              riskLevel: result.riskLevel,
              detectedSignals: result.serializedSignals,
              baselineSummary: result.baselineSummary,
              explanation:
                  'Deterministic assessment based on the latest available structured records. Signals indicate patterns requiring attention and are not a diagnosis.',
              recommendedAction: result.recommendedAction,
              sourceObservationId: result.sourceObservationId,
            ),
          );

    final alerts = await FarmAlert.db.find(
      session,
      where: (t) =>
          t.farmId.equals(animal.farmId) &
          t.animalId.equals(animalId) &
          t.title.like('$_alertTitlePrefix%') &
          t.resolvedAt.equals(null),
    );
    if (result.riskLevel == RiskLevel.low) {
      for (final alert in alerts) {
        await FarmAlert.db.updateRow(
          session,
          alert.copyWith(resolvedAt: assessedAt),
        );
      }
    } else {
      final severity = switch (result.riskLevel) {
        RiskLevel.moderate => AlertSeverity.moderate,
        RiskLevel.high => AlertSeverity.high,
        RiskLevel.critical => AlertSeverity.critical,
        RiskLevel.low => AlertSeverity.low,
      };
      final detail = result.signals
          .map((signal) => '- ${signal['title']}: ${signal['evidence']}')
          .join('\n');
      final title =
          '$_alertTitlePrefix · ${result.riskLevel.name.toUpperCase()}';
      final description = '$detail\n\n${result.recommendedAction}';
      if (alerts.isNotEmpty) {
        final alert = alerts.first;
        await FarmAlert.db.updateRow(
          session,
          alert.copyWith(
            severity: severity,
            title: title,
            description: description,
          ),
        );
        for (final duplicate in alerts.skip(1)) {
          await FarmAlert.db.updateRow(
            session,
            duplicate.copyWith(resolvedAt: assessedAt),
          );
        }
      } else {
        await FarmAlert.db.insertRow(
          session,
          FarmAlert(
            farmId: animal.farmId,
            animalId: animalId,
            severity: severity,
            alertType: AlertType.health,
            title: title,
            description: description,
            createdAt: assessedAt,
          ),
        );
      }
    }

    final tasks = await FarmTask.db.find(
      session,
      where: (t) =>
          t.farmId.equals(animal.farmId) &
          t.animalId.equals(animalId) &
          t.title.like('$_taskTitlePrefix%') &
          t.status.equals(TaskStatus.open),
    );
    if (result.riskLevel == RiskLevel.low) {
      for (final task in tasks) {
        await FarmTask.db.updateRow(
          session,
          task.copyWith(status: TaskStatus.cancelled),
        );
      }
    } else if (tasks.isNotEmpty) {
      final task = tasks.first;
      await FarmTask.db.updateRow(
        session,
        task.copyWith(
          title: '$_taskTitlePrefix · ${animal.tag}',
          description: result.recommendedAction,
          priority: result.riskLevel == RiskLevel.moderate
              ? TaskPriority.medium
              : result.riskLevel == RiskLevel.high
              ? TaskPriority.high
              : TaskPriority.urgent,
        ),
      );
      for (final duplicate in tasks.skip(1)) {
        await FarmTask.db.updateRow(
          session,
          duplicate.copyWith(status: TaskStatus.cancelled),
        );
      }
    } else if (result.riskLevel != RiskLevel.low && changed) {
      await FarmTask.db.insertRow(
        session,
        FarmTask(
          farmId: animal.farmId,
          animalId: animalId,
          title: '$_taskTitlePrefix · ${animal.tag}',
          description: result.recommendedAction,
          priority: result.riskLevel == RiskLevel.moderate
              ? TaskPriority.medium
              : result.riskLevel == RiskLevel.high
              ? TaskPriority.high
              : TaskPriority.urgent,
          status: TaskStatus.open,
          createdAt: assessedAt,
        ),
      );
    }
    return assessment;
  }
}
