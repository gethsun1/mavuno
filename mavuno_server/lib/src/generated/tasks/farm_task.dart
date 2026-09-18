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
import 'package:serverpod/serverpod.dart' as _is;
import '../tasks/task_priority.dart' as _i8wm0pu0;
import '../tasks/task_status.dart' as _i18yar27;

abstract class FarmTask
    implements _is.TableRow<int?>, _is.ProtocolSerialization {
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
          : _is.DateTimeJsonExtension.fromJson(jsonSerialization['dueAt']),
      status: _i18yar27.TaskStatus.fromJson(
        (jsonSerialization['status'] as String),
      ),
      createdAt: _is.DateTimeJsonExtension.fromJson(
        jsonSerialization['createdAt'],
      ),
      completedAt: jsonSerialization['completedAt'] == null
          ? null
          : _is.DateTimeJsonExtension.fromJson(
              jsonSerialization['completedAt'],
            ),
    );
  }

  static final t = FarmTaskTable();

  static const db = FarmTaskRepository._();

  @override
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

  @override
  _is.Table<int?> get table => t;

  /// Returns a shallow copy of this [FarmTask]
  /// with some or all fields replaced by the given arguments.
  @_is.useResult
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

  static FarmTaskInclude include() {
    return FarmTaskInclude._();
  }

  static FarmTaskIncludeList includeList({
    _is.WhereExpressionBuilder<FarmTaskTable>? where,
    int? limit,
    int? offset,
    _is.OrderByBuilder<FarmTaskTable>? orderBy,
    _is.OrderByListBuilder<FarmTaskTable>? orderByList,
    FarmTaskInclude? include,
  }) {
    return FarmTaskIncludeList._(
      where: where,
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(FarmTask.t),
      orderByList: orderByList?.call(FarmTask.t),
      include: include,
    );
  }

  @override
  String toString() {
    return _is.SerializationManager.encode(this);
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
  @_is.useResult
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

class FarmTaskUpdateTable extends _is.UpdateTable<FarmTaskTable> {
  FarmTaskUpdateTable(super.table);

  _is.ColumnValue<int, int> farmId(int value) => _is.ColumnValue(
    table.farmId,
    value,
  );

  _is.ColumnValue<int, int> animalId(int? value) => _is.ColumnValue(
    table.animalId,
    value,
  );

  _is.ColumnValue<String, String> title(String value) => _is.ColumnValue(
    table.title,
    value,
  );

  _is.ColumnValue<String, String> description(String? value) => _is.ColumnValue(
    table.description,
    value,
  );

  _is.ColumnValue<_i8wm0pu0.TaskPriority, _i8wm0pu0.TaskPriority> priority(
    _i8wm0pu0.TaskPriority value,
  ) => _is.ColumnValue(
    table.priority,
    value,
  );

  _is.ColumnValue<DateTime, DateTime> dueAt(DateTime? value) => _is.ColumnValue(
    table.dueAt,
    value,
  );

  _is.ColumnValue<_i18yar27.TaskStatus, _i18yar27.TaskStatus> status(
    _i18yar27.TaskStatus value,
  ) => _is.ColumnValue(
    table.status,
    value,
  );

  _is.ColumnValue<DateTime, DateTime> createdAt(DateTime value) =>
      _is.ColumnValue(
        table.createdAt,
        value,
      );

  _is.ColumnValue<DateTime, DateTime> completedAt(DateTime? value) =>
      _is.ColumnValue(
        table.completedAt,
        value,
      );
}

class FarmTaskTable extends _is.Table<int?> {
  FarmTaskTable({super.tableRelation}) : super(tableName: 'farm_task') {
    updateTable = FarmTaskUpdateTable(this);
    farmId = _is.ColumnInt(
      'farmId',
      this,
    );
    animalId = _is.ColumnInt(
      'animalId',
      this,
    );
    title = _is.ColumnString(
      'title',
      this,
    );
    description = _is.ColumnString(
      'description',
      this,
    );
    priority = _is.ColumnEnum(
      'priority',
      this,
      _is.EnumSerialization.byName,
    );
    dueAt = _is.ColumnDateTime(
      'dueAt',
      this,
    );
    status = _is.ColumnEnum(
      'status',
      this,
      _is.EnumSerialization.byName,
    );
    createdAt = _is.ColumnDateTime(
      'createdAt',
      this,
    );
    completedAt = _is.ColumnDateTime(
      'completedAt',
      this,
    );
  }

  late final FarmTaskUpdateTable updateTable;

  late final _is.ColumnInt farmId;

  late final _is.ColumnInt animalId;

  late final _is.ColumnString title;

  late final _is.ColumnString description;

  late final _is.ColumnEnum<_i8wm0pu0.TaskPriority> priority;

  late final _is.ColumnDateTime dueAt;

  late final _is.ColumnEnum<_i18yar27.TaskStatus> status;

  late final _is.ColumnDateTime createdAt;

  late final _is.ColumnDateTime completedAt;

  @override
  List<_is.Column> get columns => [
    id,
    farmId,
    animalId,
    title,
    description,
    priority,
    dueAt,
    status,
    createdAt,
    completedAt,
  ];
}

class FarmTaskInclude extends _is.IncludeObject {
  FarmTaskInclude._();

  @override
  Map<String, _is.Include?> get includes => {};

  @override
  _is.Table<int?> get table => FarmTask.t;
}

class FarmTaskIncludeList extends _is.IncludeList {
  FarmTaskIncludeList._({
    _is.WhereExpressionBuilder<FarmTaskTable>? where,
    super.limit,
    super.offset,
    super.orderBy,
    super.orderByList,
    super.include,
  }) {
    super.where = where?.call(FarmTask.t);
  }

  @override
  Map<String, _is.Include?> get includes => include?.includes ?? {};

  @override
  _is.Table<int?> get table => FarmTask.t;
}

class FarmTaskRepository {
  const FarmTaskRepository._();

  /// Returns a list of [FarmTask]s matching the given query parameters.
  ///
  /// Use [where] to specify which items to include in the return value.
  /// If none is specified, all items will be returned.
  ///
  /// To specify the order of the items use [orderBy] or [orderByList]
  /// when sorting by multiple columns.
  ///
  /// The maximum number of items can be set by [limit]. If no limit is set,
  /// all items matching the query will be returned.
  ///
  /// [offset] defines how many items to skip, after which [limit] (or all)
  /// items are read from the database.
  ///
  /// ```dart
  /// var persons = await Persons.db.find(
  ///   session,
  ///   where: (t) => t.lastName.equals('Jones'),
  ///   orderBy: (t) => t.firstName,
  ///   limit: 100,
  /// );
  /// ```
  Future<List<FarmTask>> find(
    _is.DatabaseSession session, {
    _is.WhereExpressionBuilder<FarmTaskTable>? where,
    int? limit,
    int? offset,
    _is.OrderByBuilder<FarmTaskTable>? orderBy,
    _is.OrderByListBuilder<FarmTaskTable>? orderByList,
    _is.Transaction? transaction,
    _is.LockMode? lockMode,
    _is.LockBehavior? lockBehavior,
  }) async {
    return session.db.find<FarmTask>(
      where: where?.call(FarmTask.t),
      orderBy: orderBy?.call(FarmTask.t),
      orderByList: orderByList?.call(FarmTask.t),
      limit: limit,
      offset: offset,
      transaction: transaction,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Returns the first matching [FarmTask] matching the given query parameters.
  ///
  /// Use [where] to specify which items to include in the return value.
  /// If none is specified, all items will be returned.
  ///
  /// To specify the order use [orderBy] or [orderByList]
  /// when sorting by multiple columns.
  ///
  /// [offset] defines how many items to skip, after which the next one will be picked.
  ///
  /// ```dart
  /// var youngestPerson = await Persons.db.findFirstRow(
  ///   session,
  ///   where: (t) => t.lastName.equals('Jones'),
  ///   orderBy: (t) => t.age,
  /// );
  /// ```
  Future<FarmTask?> findFirstRow(
    _is.DatabaseSession session, {
    _is.WhereExpressionBuilder<FarmTaskTable>? where,
    int? offset,
    _is.OrderByBuilder<FarmTaskTable>? orderBy,
    _is.OrderByListBuilder<FarmTaskTable>? orderByList,
    _is.Transaction? transaction,
    _is.LockMode? lockMode,
    _is.LockBehavior? lockBehavior,
  }) async {
    return session.db.findFirstRow<FarmTask>(
      where: where?.call(FarmTask.t),
      orderBy: orderBy?.call(FarmTask.t),
      orderByList: orderByList?.call(FarmTask.t),
      offset: offset,
      transaction: transaction,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Finds a single [FarmTask] by its [id] or null if no such row exists.
  Future<FarmTask?> findById(
    _is.DatabaseSession session,
    int id, {
    _is.Transaction? transaction,
    _is.LockMode? lockMode,
    _is.LockBehavior? lockBehavior,
  }) async {
    return session.db.findById<FarmTask>(
      id,
      transaction: transaction,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Inserts all [FarmTask]s in the list and returns the inserted rows.
  ///
  /// The returned [FarmTask]s will have their `id` fields set.
  ///
  /// This is an atomic operation, meaning that if one of the rows fails to
  /// insert, none of the rows will be inserted.
  ///
  /// If [ignoreConflicts] is set to `true`, rows that conflict with existing
  /// rows are silently skipped, and only the successfully inserted rows are
  /// returned.
  ///
  /// If [noReturn] is set to `true`, the inserted rows are not read back from
  /// the database and an empty list is returned. This avoids the overhead of
  /// transferring and deserializing the rows when the result is not needed.
  Future<List<FarmTask>> insert(
    _is.DatabaseSession session,
    List<FarmTask> rows, {
    _is.Transaction? transaction,
    bool ignoreConflicts = false,
    bool noReturn = false,
  }) async {
    return session.db.insert<FarmTask>(
      rows,
      transaction: transaction,
      ignoreConflicts: ignoreConflicts,
      noReturn: noReturn,
    );
  }

  /// Inserts a single [FarmTask] and returns the inserted row.
  ///
  /// The returned [FarmTask] will have its `id` field set.
  Future<FarmTask> insertRow(
    _is.DatabaseSession session,
    FarmTask row, {
    _is.Transaction? transaction,
  }) async {
    return session.db.insertRow<FarmTask>(
      row,
      transaction: transaction,
    );
  }

  /// Upserts all [FarmTask]s in the list and returns the resulting rows.
  ///
  /// If a row conflicts on the given [conflictColumns], the existing row is
  /// updated with the new values. Otherwise, a new row is inserted.
  ///
  /// If [updateColumns] is provided, only those columns will be updated on
  /// conflict. If null, all non-conflict, non-id columns are updated.
  ///
  /// If [updateWhere] is provided, the update only applies to rows matching the
  /// given expression. Conflicting rows that don't match are skipped and not
  /// returned, so the resulting list may be shorter than [rows].
  ///
  /// The returned [FarmTask]s will have their `id` fields set.
  ///
  /// This is an atomic operation, meaning that if one of the rows fails,
  /// none of the rows will be affected.
  ///
  /// If [noReturn] is set to `true`, the resulting rows are not read back from
  /// the database and an empty list is returned. This avoids the overhead of
  /// transferring and deserializing the rows when the result is not needed.
  Future<List<FarmTask>> upsert(
    _is.DatabaseSession session,
    List<FarmTask> rows, {
    required _is.ColumnSelections<FarmTaskTable> conflictColumns,
    _is.ColumnSelections<FarmTaskTable>? updateColumns,
    _is.WhereExpressionBuilder<FarmTaskTable>? updateWhere,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.upsert<FarmTask>(
      rows,
      conflictColumns: conflictColumns(FarmTask.t),
      updateColumns: updateColumns?.call(FarmTask.t),
      updateWhere: updateWhere?.call(FarmTask.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Upserts a single [FarmTask] and returns the resulting row.
  ///
  /// If the row conflicts on the given [conflictColumns], the existing row is
  /// updated. Otherwise, a new row is inserted.
  ///
  /// If [updateColumns] is provided, only those columns will be updated on
  /// conflict. If null, all non-conflict, non-id columns are updated.
  ///
  /// If [updateWhere] is provided, the update only applies when the existing
  /// row matches the expression. Returns `null` if no row was affected — for
  /// example when [updateWhere] does not match the conflicting row.
  ///
  /// The returned [FarmTask] will have its `id` field set.
  Future<FarmTask?> upsertRow(
    _is.DatabaseSession session,
    FarmTask row, {
    required _is.ColumnSelections<FarmTaskTable> conflictColumns,
    _is.ColumnSelections<FarmTaskTable>? updateColumns,
    _is.WhereExpressionBuilder<FarmTaskTable>? updateWhere,
    _is.Transaction? transaction,
  }) async {
    return session.db.upsertRow<FarmTask>(
      row,
      conflictColumns: conflictColumns(FarmTask.t),
      updateColumns: updateColumns?.call(FarmTask.t),
      updateWhere: updateWhere?.call(FarmTask.t),
      transaction: transaction,
    );
  }

  /// Updates all [FarmTask]s in the list and returns the updated rows. If
  /// [columns] is provided, only those columns will be updated. Defaults to
  /// all columns.
  /// This is an atomic operation, meaning that if one of the rows fails to
  /// update, none of the rows will be updated.
  ///
  /// If [noReturn] is set to `true`, the updated rows are not read back from
  /// the database and an empty list is returned. This avoids the overhead of
  /// transferring and deserializing the rows when the result is not needed.
  Future<List<FarmTask>> update(
    _is.DatabaseSession session,
    List<FarmTask> rows, {
    _is.ColumnSelections<FarmTaskTable>? columns,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.update<FarmTask>(
      rows,
      columns: columns?.call(FarmTask.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Updates a single [FarmTask]. The row needs to have its id set.
  /// Optionally, a list of [columns] can be provided to only update those
  /// columns. Defaults to all columns.
  Future<FarmTask> updateRow(
    _is.DatabaseSession session,
    FarmTask row, {
    _is.ColumnSelections<FarmTaskTable>? columns,
    _is.Transaction? transaction,
  }) async {
    return session.db.updateRow<FarmTask>(
      row,
      columns: columns?.call(FarmTask.t),
      transaction: transaction,
    );
  }

  /// Updates a single [FarmTask] by its [id] with the specified [columnValues].
  /// Returns the updated row or null if no row with the given id exists.
  Future<FarmTask?> updateById(
    _is.DatabaseSession session,
    int id, {
    required _is.ColumnValueListBuilder<FarmTaskUpdateTable> columnValues,
    _is.Transaction? transaction,
  }) async {
    return session.db.updateById<FarmTask>(
      id,
      columnValues: columnValues(FarmTask.t.updateTable),
      transaction: transaction,
    );
  }

  /// Updates all [FarmTask]s matching the [where] expression with the specified [columnValues].
  /// Returns the list of updated rows.
  ///
  /// If [noReturn] is set to `true`, the updated rows are not read back from
  /// the database and an empty list is returned. This avoids the overhead of
  /// transferring and deserializing the rows when the result is not needed.
  Future<List<FarmTask>> updateWhere(
    _is.DatabaseSession session, {
    required _is.ColumnValueListBuilder<FarmTaskUpdateTable> columnValues,
    required _is.WhereExpressionBuilder<FarmTaskTable> where,
    int? limit,
    int? offset,
    _is.OrderByBuilder<FarmTaskTable>? orderBy,
    _is.OrderByListBuilder<FarmTaskTable>? orderByList,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.updateWhere<FarmTask>(
      columnValues: columnValues(FarmTask.t.updateTable),
      where: where(FarmTask.t),
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(FarmTask.t),
      orderByList: orderByList?.call(FarmTask.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Deletes all [FarmTask]s in the list and returns the deleted rows.
  ///
  /// To specify the order of the returned rows use [orderBy] or [orderByList]
  /// when sorting by multiple columns.
  ///
  /// This is an atomic operation, meaning that if one of the rows fail to
  /// be deleted, none of the rows will be deleted.
  ///
  /// If [noReturn] is set to `true`, the deleted rows are not read back from
  /// the database and an empty list is returned. This avoids the overhead of
  /// transferring and deserializing the rows when the result is not needed.
  Future<List<FarmTask>> delete(
    _is.DatabaseSession session,
    List<FarmTask> rows, {
    _is.OrderByBuilder<FarmTaskTable>? orderBy,
    _is.OrderByListBuilder<FarmTaskTable>? orderByList,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.delete<FarmTask>(
      rows,
      orderBy: orderBy?.call(FarmTask.t),
      orderByList: orderByList?.call(FarmTask.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Deletes a single [FarmTask].
  Future<FarmTask> deleteRow(
    _is.DatabaseSession session,
    FarmTask row, {
    _is.Transaction? transaction,
  }) async {
    return session.db.deleteRow<FarmTask>(
      row,
      transaction: transaction,
    );
  }

  /// Deletes all rows matching the [where] expression.
  ///
  /// To specify the order of the returned rows use [orderBy] or [orderByList]
  /// when sorting by multiple columns.
  ///
  /// If [noReturn] is set to `true`, the deleted rows are not read back from
  /// the database and an empty list is returned. This avoids the overhead of
  /// transferring and deserializing the rows when the result is not needed.
  Future<List<FarmTask>> deleteWhere(
    _is.DatabaseSession session, {
    required _is.WhereExpressionBuilder<FarmTaskTable> where,
    _is.OrderByBuilder<FarmTaskTable>? orderBy,
    _is.OrderByListBuilder<FarmTaskTable>? orderByList,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.deleteWhere<FarmTask>(
      where: where(FarmTask.t),
      orderBy: orderBy?.call(FarmTask.t),
      orderByList: orderByList?.call(FarmTask.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Counts the number of rows matching the [where] expression. If omitted,
  /// will return the count of all rows in the table.
  Future<int> count(
    _is.DatabaseSession session, {
    _is.WhereExpressionBuilder<FarmTaskTable>? where,
    int? limit,
    _is.Transaction? transaction,
  }) async {
    return session.db.count<FarmTask>(
      where: where?.call(FarmTask.t),
      limit: limit,
      transaction: transaction,
    );
  }

  /// Acquires row-level locks on [FarmTask] rows matching the [where] expression.
  Future<void> lockRows(
    _is.DatabaseSession session, {
    required _is.WhereExpressionBuilder<FarmTaskTable> where,
    required _is.LockMode lockMode,
    required _is.Transaction transaction,
    _is.LockBehavior lockBehavior = _is.LockBehavior.wait,
  }) async {
    return session.db.lockRows<FarmTask>(
      where: where(FarmTask.t),
      lockMode: lockMode,
      lockBehavior: lockBehavior,
      transaction: transaction,
    );
  }
}
