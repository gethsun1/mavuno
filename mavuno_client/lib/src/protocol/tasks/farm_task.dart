/* AUTOMATICALLY GENERATED CODE DO NOT MODIFY */
/*   To generate run: "serverpod generate"    */

// ignore_for_file: implementation_imports
// ignore_for_file: library_private_types_in_public_api
// ignore_for_file: non_constant_identifier_names
// ignore_for_file: public_member_api_docs
// ignore_for_file: type_literal_in_constant_pattern
// ignore_for_file: use_super_parameters
// ignore_for_file: invalid_use_of_internal_member

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:serverpod_client/serverpod_client.dart' as _isc;
import '../tasks/task_priority.dart' as _i8wm0pu0;
import '../tasks/task_status.dart' as _i18yar27;

abstract class FarmTask
    implements _isc.SerializableModel, _isc.ProtocolSerialization {
  FarmTask._({
    this.id,
    required this.farmId,
    this.animalId,
    required this.title,
    this.description,
    required this.priority,
    this.dueAt,
    required this.status,
    required this.createdAt,
    this.completedAt,
  });

  factory FarmTask({
    int? id,
    required int farmId,
    int? animalId,
    required String title,
    String? description,
    required _i8wm0pu0.TaskPriority priority,
    DateTime? dueAt,
    required _i18yar27.TaskStatus status,
    required DateTime createdAt,
    DateTime? completedAt,
  }) = _FarmTaskImpl;

  factory FarmTask.fromJson(Map<String, dynamic> jsonSerialization) {
    return FarmTask(
      id: jsonSerialization['id'] as int?,
      farmId: jsonSerialization['farmId'] as int,
      animalId: jsonSerialization['animalId'] as int?,
      title: jsonSerialization['title'] as String,
      description: jsonSerialization['description'] as String?,
      priority: _i8wm0pu0.TaskPriority.fromJson(
        (jsonSerialization['priority'] as String),
      ),
      dueAt: jsonSerialization['dueAt'] == null
          ? null
          : _isc.DateTimeJsonExtension.fromJson(jsonSerialization['dueAt']),
      status: _i18yar27.TaskStatus.fromJson(
        (jsonSerialization['status'] as String),
      ),
      createdAt: _isc.DateTimeJsonExtension.fromJson(
        jsonSerialization['createdAt'],
      ),
      completedAt: jsonSerialization['completedAt'] == null
          ? null
          : _isc.DateTimeJsonExtension.fromJson(
              jsonSerialization['completedAt'],
            ),
    );
  }

  /// The database id, set if the object has been inserted into the
  /// database or if it has been fetched from the database. Otherwise,
  /// the id will be null.
  int? id;

  int farmId;

  int? animalId;

  String title;

  String? description;

  _i8wm0pu0.TaskPriority priority;

  DateTime? dueAt;

  _i18yar27.TaskStatus status;

  DateTime createdAt;

  DateTime? completedAt;

  /// Returns a shallow copy of this [FarmTask]
  /// with some or all fields replaced by the given arguments.
  @_isc.useResult
  FarmTask copyWith({
    int? id,
    int? farmId,
    int? animalId,
    String? title,
    String? description,
    _i8wm0pu0.TaskPriority? priority,
    DateTime? dueAt,
    _i18yar27.TaskStatus? status,
    DateTime? createdAt,
    DateTime? completedAt,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'FarmTask',
      if (id != null) 'id': id,
      'farmId': farmId,
      if (animalId != null) 'animalId': animalId,
      'title': title,
      if (description != null) 'description': description,
      'priority': priority.toJson(),
      if (dueAt != null) 'dueAt': dueAt?.toJson(),
      'status': status.toJson(),
      'createdAt': createdAt.toJson(),
      if (completedAt != null) 'completedAt': completedAt?.toJson(),
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {
      '__className__': 'FarmTask',
      if (id != null) 'id': id,
      'farmId': farmId,
      if (animalId != null) 'animalId': animalId,
      'title': title,
      if (description != null) 'description': description,
      'priority': priority.toJson(),
      if (dueAt != null) 'dueAt': dueAt?.toJson(),
      'status': status.toJson(),
      'createdAt': createdAt.toJson(),
      if (completedAt != null) 'completedAt': completedAt?.toJson(),
    };
  }

  @override
  String toString() {
    return _isc.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _FarmTaskImpl extends FarmTask {
  _FarmTaskImpl({
    int? id,
    required int farmId,
    int? animalId,
    required String title,
    String? description,
    required _i8wm0pu0.TaskPriority priority,
    DateTime? dueAt,
    required _i18yar27.TaskStatus status,
    required DateTime createdAt,
    DateTime? completedAt,
  }) : super._(
         id: id,
         farmId: farmId,
         animalId: animalId,
         title: title,
         description: description,
         priority: priority,
         dueAt: dueAt,
         status: status,
         createdAt: createdAt,
         completedAt: completedAt,
       );

  /// Returns a shallow copy of this [FarmTask]
  /// with some or all fields replaced by the given arguments.
  @_isc.useResult
  @override
  FarmTask copyWith({
    Object? id = _Undefined,
    int? farmId,
    Object? animalId = _Undefined,
    String? title,
    Object? description = _Undefined,
    _i8wm0pu0.TaskPriority? priority,
    Object? dueAt = _Undefined,
    _i18yar27.TaskStatus? status,
    DateTime? createdAt,
    Object? completedAt = _Undefined,
  }) {
    return FarmTask(
      id: id is int? ? id : this.id,
      farmId: farmId ?? this.farmId,
      animalId: animalId is int? ? animalId : this.animalId,
      title: title ?? this.title,
      description: description is String? ? description : this.description,
      priority: priority ?? this.priority,
      dueAt: dueAt is DateTime? ? dueAt : this.dueAt,
      status: status ?? this.status,
      createdAt: createdAt ?? this.createdAt,
      completedAt: completedAt is DateTime? ? completedAt : this.completedAt,
    );
  }
}
