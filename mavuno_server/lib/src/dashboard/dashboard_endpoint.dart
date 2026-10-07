import 'package:serverpod/serverpod.dart';

import '../generated/protocol.dart';
import '../shared/farm_access.dart';

class DashboardEndpoint extends Endpoint {
  Future<FarmDashboardSnapshot> getFarmSnapshot(
    Session session,
    int farmId,
  ) async {
    await FarmAccess.ownedFarm(session, farmId);
    final animals = await Animal.db.find(
      session,
      where: (t) => t.farmId.equals(farmId),
      orderBy: (t) => t.tag,
    );
    final animalIds = animals.map((animal) => animal.id!).toSet();
    if (animalIds.isEmpty) {
      final farmRows = await Future.wait([
        FarmAlert.db.find(
          session,
          where: (t) => t.farmId.equals(farmId) & t.resolvedAt.equals(null),
          orderBy: (t) => t.createdAt.desc(),
        ),
        FarmTask.db.find(
          session,
          where: (t) =>
              t.farmId.equals(farmId) & t.status.equals(TaskStatus.open),
          orderBy: (t) => t.createdAt.desc(),
        ),
      ]);
      return FarmDashboardSnapshot(
        animals: [],
        assessments: [],
        alerts: farmRows[0] as List<FarmAlert>,
        tasks: farmRows[1] as List<FarmTask>,
        observations: [],
        production: [],
      );
    }

    final rows = await Future.wait([
      SentinelAssessment.db.find(
        session,
        where: (t) => t.farmId.equals(farmId),
        orderBy: (t) => t.assessedAt.desc(),
      ),
      FarmAlert.db.find(
        session,
        where: (t) => t.farmId.equals(farmId) & t.resolvedAt.equals(null),
        orderBy: (t) => t.createdAt.desc(),
      ),
      FarmTask.db.find(
        session,
        where: (t) =>
            t.farmId.equals(farmId) & t.status.equals(TaskStatus.open),
        orderBy: (t) => t.createdAt.desc(),
      ),
      AnimalObservation.db.find(
        session,
        where: (t) => t.animalId.inSet(animalIds),
        orderBy: (t) => t.recordedAt.desc(),
        limit: 8,
      ),
      ProductionRecord.db.find(
        session,
        where: (t) => t.animalId.inSet(animalIds),
        orderBy: (t) => t.recordedAt.desc(),
      ),
    ]);

    final latestByAnimal = <int, SentinelAssessment>{};
    for (final assessment in rows[0] as List<SentinelAssessment>) {
      latestByAnimal.putIfAbsent(assessment.animalId, () => assessment);
    }
    return FarmDashboardSnapshot(
      animals: animals,
      assessments: latestByAnimal.values.toList(),
      alerts: rows[1] as List<FarmAlert>,
      tasks: rows[2] as List<FarmTask>,
      observations: rows[3] as List<AnimalObservation>,
      production: rows[4] as List<ProductionRecord>,
    );
  }
}
