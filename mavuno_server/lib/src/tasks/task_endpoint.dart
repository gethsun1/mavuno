import 'package:serverpod/serverpod.dart';
import '../generated/protocol.dart';
import '../shared/farm_access.dart';
import '../intelligence/intelligence_event_service.dart';

class TaskEndpoint extends Endpoint {
  Future<FarmTask> create(
    Session session,
    int farmId,
    String title, {
    int? animalId,
    String? description,
    TaskPriority priority = TaskPriority.medium,
    DateTime? dueAt,
  }) async {
    await FarmAccess.ownedFarm(session, farmId);
    if (animalId != null) {
      final animal = await FarmAccess.ownedAnimal(session, animalId);
      if (animal.farmId != farmId) {
        throw Exception('Animal does not belong to this farm.');
      }
    }
    if (title.trim().isEmpty) throw Exception('Task title is required.');
    final task = await FarmTask.db.insertRow(
      session,
      FarmTask(
        farmId: farmId,
        animalId: animalId,
        title: title.trim(),
        description: description?.trim(),
        priority: priority,
        dueAt: dueAt?.toUtc(),
        status: TaskStatus.open,
        createdAt: DateTime.now().toUtc(),
      ),
    );
    await IntelligenceEventService.publish(session, farmId);
    return task;
  }

  Future<List<FarmTask>> list(
    Session session,
    int farmId, {
    TaskStatus? status,
  }) async {
    await FarmAccess.ownedFarm(session, farmId);
    return FarmTask.db.find(
      session,
      where: (t) => status == null
          ? t.farmId.equals(farmId)
          : (t.farmId.equals(farmId) & t.status.equals(status)),
      orderBy: (t) => t.createdAt,
    );
  }

  Future<FarmTask> complete(Session session, int taskId) async {
    final task = await FarmTask.db.findById(session, taskId);
    if (task == null) throw Exception('Task not found.');
    await FarmAccess.ownedFarm(session, task.farmId);
    final updated = await FarmTask.db.updateRow(
      session,
      task.copyWith(
        status: TaskStatus.completed,
        completedAt: DateTime.now().toUtc(),
      ),
    );
    await IntelligenceEventService.publish(session, task.farmId);
    return updated;
  }
}
