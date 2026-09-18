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
import '../alerts/alert_severity.dart' as _ifq13nbh;
import '../alerts/alert_type.dart' as _i9unj23o;

abstract class FarmAlert
    implements _is.TableRow<int?>, _is.ProtocolSerialization {
  FarmAlert._({
    this.id,
    required this.farmId,
    this.animalId,
    required this.severity,
    required this.alertType,
    required this.title,
    required this.description,
    required this.createdAt,
    this.acknowledgedAt,
    this.resolvedAt,
  });

  factory FarmAlert({
    int? id,
    required int farmId,
    int? animalId,
    required _ifq13nbh.AlertSeverity severity,
    required _i9unj23o.AlertType alertType,
    required String title,
    required String description,
    required DateTime createdAt,
    DateTime? acknowledgedAt,
    DateTime? resolvedAt,
  }) = _FarmAlertImpl;

  factory FarmAlert.fromJson(Map<String, dynamic> jsonSerialization) {
    return FarmAlert(
      id: jsonSerialization['id'] as int?,
      farmId: jsonSerialization['farmId'] as int,
      animalId: jsonSerialization['animalId'] as int?,
      severity: _ifq13nbh.AlertSeverity.fromJson(
        (jsonSerialization['severity'] as String),
      ),
      alertType: _i9unj23o.AlertType.fromJson(
        (jsonSerialization['alertType'] as String),
      ),
      title: jsonSerialization['title'] as String,
      description: jsonSerialization['description'] as String,
      createdAt: _is.DateTimeJsonExtension.fromJson(
        jsonSerialization['createdAt'],
      ),
      acknowledgedAt: jsonSerialization['acknowledgedAt'] == null
          ? null
          : _is.DateTimeJsonExtension.fromJson(
              jsonSerialization['acknowledgedAt'],
            ),
      resolvedAt: jsonSerialization['resolvedAt'] == null
          ? null
          : _is.DateTimeJsonExtension.fromJson(jsonSerialization['resolvedAt']),
    );
  }

  static final t = FarmAlertTable();

  static const db = FarmAlertRepository._();

  @override
  int? id;

  int farmId;

  int? animalId;

  _ifq13nbh.AlertSeverity severity;

  _i9unj23o.AlertType alertType;

  String title;

  String description;

  DateTime createdAt;

  DateTime? acknowledgedAt;

  DateTime? resolvedAt;

  @override
  _is.Table<int?> get table => t;

  /// Returns a shallow copy of this [FarmAlert]
  /// with some or all fields replaced by the given arguments.
  @_is.useResult
  FarmAlert copyWith({
    int? id,
    int? farmId,
    int? animalId,
    _ifq13nbh.AlertSeverity? severity,
    _i9unj23o.AlertType? alertType,
    String? title,
    String? description,
    DateTime? createdAt,
    DateTime? acknowledgedAt,
    DateTime? resolvedAt,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'FarmAlert',
      if (id != null) 'id': id,
      'farmId': farmId,
      if (animalId != null) 'animalId': animalId,
      'severity': severity.toJson(),
      'alertType': alertType.toJson(),
      'title': title,
      'description': description,
      'createdAt': createdAt.toJson(),
      if (acknowledgedAt != null) 'acknowledgedAt': acknowledgedAt?.toJson(),
      if (resolvedAt != null) 'resolvedAt': resolvedAt?.toJson(),
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {
      '__className__': 'FarmAlert',
      if (id != null) 'id': id,
      'farmId': farmId,
      if (animalId != null) 'animalId': animalId,
      'severity': severity.toJson(),
      'alertType': alertType.toJson(),
      'title': title,
      'description': description,
      'createdAt': createdAt.toJson(),
      if (acknowledgedAt != null) 'acknowledgedAt': acknowledgedAt?.toJson(),
      if (resolvedAt != null) 'resolvedAt': resolvedAt?.toJson(),
    };
  }

  static FarmAlertInclude include() {
    return FarmAlertInclude._();
  }

  static FarmAlertIncludeList includeList({
    _is.WhereExpressionBuilder<FarmAlertTable>? where,
    int? limit,
    int? offset,
    _is.OrderByBuilder<FarmAlertTable>? orderBy,
    _is.OrderByListBuilder<FarmAlertTable>? orderByList,
    FarmAlertInclude? include,
  }) {
    return FarmAlertIncludeList._(
      where: where,
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(FarmAlert.t),
      orderByList: orderByList?.call(FarmAlert.t),
      include: include,
    );
  }

  @override
  String toString() {
    return _is.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _FarmAlertImpl extends FarmAlert {
  _FarmAlertImpl({
    int? id,
    required int farmId,
    int? animalId,
    required _ifq13nbh.AlertSeverity severity,
    required _i9unj23o.AlertType alertType,
    required String title,
    required String description,
    required DateTime createdAt,
    DateTime? acknowledgedAt,
    DateTime? resolvedAt,
  }) : super._(
         id: id,
         farmId: farmId,
         animalId: animalId,
         severity: severity,
         alertType: alertType,
         title: title,
         description: description,
         createdAt: createdAt,
         acknowledgedAt: acknowledgedAt,
         resolvedAt: resolvedAt,
       );

  /// Returns a shallow copy of this [FarmAlert]
  /// with some or all fields replaced by the given arguments.
  @_is.useResult
  @override
  FarmAlert copyWith({
    Object? id = _Undefined,
    int? farmId,
    Object? animalId = _Undefined,
    _ifq13nbh.AlertSeverity? severity,
    _i9unj23o.AlertType? alertType,
    String? title,
    String? description,
    DateTime? createdAt,
    Object? acknowledgedAt = _Undefined,
    Object? resolvedAt = _Undefined,
  }) {
    return FarmAlert(
      id: id is int? ? id : this.id,
      farmId: farmId ?? this.farmId,
      animalId: animalId is int? ? animalId : this.animalId,
      severity: severity ?? this.severity,
      alertType: alertType ?? this.alertType,
      title: title ?? this.title,
      description: description ?? this.description,
      createdAt: createdAt ?? this.createdAt,
      acknowledgedAt: acknowledgedAt is DateTime?
          ? acknowledgedAt
          : this.acknowledgedAt,
      resolvedAt: resolvedAt is DateTime? ? resolvedAt : this.resolvedAt,
    );
  }
}

class FarmAlertUpdateTable extends _is.UpdateTable<FarmAlertTable> {
  FarmAlertUpdateTable(super.table);

  _is.ColumnValue<int, int> farmId(int value) => _is.ColumnValue(
    table.farmId,
    value,
  );

  _is.ColumnValue<int, int> animalId(int? value) => _is.ColumnValue(
    table.animalId,
    value,
  );

  _is.ColumnValue<_ifq13nbh.AlertSeverity, _ifq13nbh.AlertSeverity> severity(
    _ifq13nbh.AlertSeverity value,
  ) => _is.ColumnValue(
    table.severity,
    value,
  );

  _is.ColumnValue<_i9unj23o.AlertType, _i9unj23o.AlertType> alertType(
    _i9unj23o.AlertType value,
  ) => _is.ColumnValue(
    table.alertType,
    value,
  );

  _is.ColumnValue<String, String> title(String value) => _is.ColumnValue(
    table.title,
    value,
  );

  _is.ColumnValue<String, String> description(String value) => _is.ColumnValue(
    table.description,
    value,
  );

  _is.ColumnValue<DateTime, DateTime> createdAt(DateTime value) =>
      _is.ColumnValue(
        table.createdAt,
        value,
      );

  _is.ColumnValue<DateTime, DateTime> acknowledgedAt(DateTime? value) =>
      _is.ColumnValue(
        table.acknowledgedAt,
        value,
      );

  _is.ColumnValue<DateTime, DateTime> resolvedAt(DateTime? value) =>
      _is.ColumnValue(
        table.resolvedAt,
        value,
      );
}

class FarmAlertTable extends _is.Table<int?> {
  FarmAlertTable({super.tableRelation}) : super(tableName: 'farm_alert') {
    updateTable = FarmAlertUpdateTable(this);
    farmId = _is.ColumnInt(
      'farmId',
      this,
    );
    animalId = _is.ColumnInt(
      'animalId',
      this,
    );
    severity = _is.ColumnEnum(
      'severity',
      this,
      _is.EnumSerialization.byName,
    );
    alertType = _is.ColumnEnum(
      'alertType',
      this,
      _is.EnumSerialization.byName,
    );
    title = _is.ColumnString(
      'title',
      this,
    );
    description = _is.ColumnString(
      'description',
      this,
    );
    createdAt = _is.ColumnDateTime(
      'createdAt',
      this,
    );
    acknowledgedAt = _is.ColumnDateTime(
      'acknowledgedAt',
      this,
    );
    resolvedAt = _is.ColumnDateTime(
      'resolvedAt',
      this,
    );
  }

  late final FarmAlertUpdateTable updateTable;

  late final _is.ColumnInt farmId;

  late final _is.ColumnInt animalId;

  late final _is.ColumnEnum<_ifq13nbh.AlertSeverity> severity;

  late final _is.ColumnEnum<_i9unj23o.AlertType> alertType;

  late final _is.ColumnString title;

  late final _is.ColumnString description;

  late final _is.ColumnDateTime createdAt;

  late final _is.ColumnDateTime acknowledgedAt;

  late final _is.ColumnDateTime resolvedAt;

  @override
  List<_is.Column> get columns => [
    id,
    farmId,
    animalId,
    severity,
    alertType,
    title,
    description,
    createdAt,
    acknowledgedAt,
    resolvedAt,
  ];
}

class FarmAlertInclude extends _is.IncludeObject {
  FarmAlertInclude._();

  @override
  Map<String, _is.Include?> get includes => {};

  @override
  _is.Table<int?> get table => FarmAlert.t;
}

class FarmAlertIncludeList extends _is.IncludeList {
  FarmAlertIncludeList._({
    _is.WhereExpressionBuilder<FarmAlertTable>? where,
    super.limit,
    super.offset,
    super.orderBy,
    super.orderByList,
    super.include,
  }) {
    super.where = where?.call(FarmAlert.t);
  }

  @override
  Map<String, _is.Include?> get includes => include?.includes ?? {};

  @override
  _is.Table<int?> get table => FarmAlert.t;
}

class FarmAlertRepository {
  const FarmAlertRepository._();

  /// Returns a list of [FarmAlert]s matching the given query parameters.
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
  Future<List<FarmAlert>> find(
    _is.DatabaseSession session, {
    _is.WhereExpressionBuilder<FarmAlertTable>? where,
    int? limit,
    int? offset,
    _is.OrderByBuilder<FarmAlertTable>? orderBy,
    _is.OrderByListBuilder<FarmAlertTable>? orderByList,
    _is.Transaction? transaction,
    _is.LockMode? lockMode,
    _is.LockBehavior? lockBehavior,
  }) async {
    return session.db.find<FarmAlert>(
      where: where?.call(FarmAlert.t),
      orderBy: orderBy?.call(FarmAlert.t),
      orderByList: orderByList?.call(FarmAlert.t),
      limit: limit,
      offset: offset,
      transaction: transaction,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Returns the first matching [FarmAlert] matching the given query parameters.
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
  Future<FarmAlert?> findFirstRow(
    _is.DatabaseSession session, {
    _is.WhereExpressionBuilder<FarmAlertTable>? where,
    int? offset,
    _is.OrderByBuilder<FarmAlertTable>? orderBy,
    _is.OrderByListBuilder<FarmAlertTable>? orderByList,
    _is.Transaction? transaction,
    _is.LockMode? lockMode,
    _is.LockBehavior? lockBehavior,
  }) async {
    return session.db.findFirstRow<FarmAlert>(
      where: where?.call(FarmAlert.t),
      orderBy: orderBy?.call(FarmAlert.t),
      orderByList: orderByList?.call(FarmAlert.t),
      offset: offset,
      transaction: transaction,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Finds a single [FarmAlert] by its [id] or null if no such row exists.
  Future<FarmAlert?> findById(
    _is.DatabaseSession session,
    int id, {
    _is.Transaction? transaction,
    _is.LockMode? lockMode,
    _is.LockBehavior? lockBehavior,
  }) async {
    return session.db.findById<FarmAlert>(
      id,
      transaction: transaction,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Inserts all [FarmAlert]s in the list and returns the inserted rows.
  ///
  /// The returned [FarmAlert]s will have their `id` fields set.
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
  Future<List<FarmAlert>> insert(
    _is.DatabaseSession session,
    List<FarmAlert> rows, {
    _is.Transaction? transaction,
    bool ignoreConflicts = false,
    bool noReturn = false,
  }) async {
    return session.db.insert<FarmAlert>(
      rows,
      transaction: transaction,
      ignoreConflicts: ignoreConflicts,
      noReturn: noReturn,
    );
  }

  /// Inserts a single [FarmAlert] and returns the inserted row.
  ///
  /// The returned [FarmAlert] will have its `id` field set.
  Future<FarmAlert> insertRow(
    _is.DatabaseSession session,
    FarmAlert row, {
    _is.Transaction? transaction,
  }) async {
    return session.db.insertRow<FarmAlert>(
      row,
      transaction: transaction,
    );
  }

  /// Upserts all [FarmAlert]s in the list and returns the resulting rows.
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
  /// The returned [FarmAlert]s will have their `id` fields set.
  ///
  /// This is an atomic operation, meaning that if one of the rows fails,
  /// none of the rows will be affected.
  ///
  /// If [noReturn] is set to `true`, the resulting rows are not read back from
  /// the database and an empty list is returned. This avoids the overhead of
  /// transferring and deserializing the rows when the result is not needed.
  Future<List<FarmAlert>> upsert(
    _is.DatabaseSession session,
    List<FarmAlert> rows, {
    required _is.ColumnSelections<FarmAlertTable> conflictColumns,
    _is.ColumnSelections<FarmAlertTable>? updateColumns,
    _is.WhereExpressionBuilder<FarmAlertTable>? updateWhere,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.upsert<FarmAlert>(
      rows,
      conflictColumns: conflictColumns(FarmAlert.t),
      updateColumns: updateColumns?.call(FarmAlert.t),
      updateWhere: updateWhere?.call(FarmAlert.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Upserts a single [FarmAlert] and returns the resulting row.
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
  /// The returned [FarmAlert] will have its `id` field set.
  Future<FarmAlert?> upsertRow(
    _is.DatabaseSession session,
    FarmAlert row, {
    required _is.ColumnSelections<FarmAlertTable> conflictColumns,
    _is.ColumnSelections<FarmAlertTable>? updateColumns,
    _is.WhereExpressionBuilder<FarmAlertTable>? updateWhere,
    _is.Transaction? transaction,
  }) async {
    return session.db.upsertRow<FarmAlert>(
      row,
      conflictColumns: conflictColumns(FarmAlert.t),
      updateColumns: updateColumns?.call(FarmAlert.t),
      updateWhere: updateWhere?.call(FarmAlert.t),
      transaction: transaction,
    );
  }

  /// Updates all [FarmAlert]s in the list and returns the updated rows. If
  /// [columns] is provided, only those columns will be updated. Defaults to
  /// all columns.
  /// This is an atomic operation, meaning that if one of the rows fails to
  /// update, none of the rows will be updated.
  ///
  /// If [noReturn] is set to `true`, the updated rows are not read back from
  /// the database and an empty list is returned. This avoids the overhead of
  /// transferring and deserializing the rows when the result is not needed.
  Future<List<FarmAlert>> update(
    _is.DatabaseSession session,
    List<FarmAlert> rows, {
    _is.ColumnSelections<FarmAlertTable>? columns,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.update<FarmAlert>(
      rows,
      columns: columns?.call(FarmAlert.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Updates a single [FarmAlert]. The row needs to have its id set.
  /// Optionally, a list of [columns] can be provided to only update those
  /// columns. Defaults to all columns.
  Future<FarmAlert> updateRow(
    _is.DatabaseSession session,
    FarmAlert row, {
    _is.ColumnSelections<FarmAlertTable>? columns,
    _is.Transaction? transaction,
  }) async {
    return session.db.updateRow<FarmAlert>(
      row,
      columns: columns?.call(FarmAlert.t),
      transaction: transaction,
    );
  }

  /// Updates a single [FarmAlert] by its [id] with the specified [columnValues].
  /// Returns the updated row or null if no row with the given id exists.
  Future<FarmAlert?> updateById(
    _is.DatabaseSession session,
    int id, {
    required _is.ColumnValueListBuilder<FarmAlertUpdateTable> columnValues,
    _is.Transaction? transaction,
  }) async {
    return session.db.updateById<FarmAlert>(
      id,
      columnValues: columnValues(FarmAlert.t.updateTable),
      transaction: transaction,
    );
  }

  /// Updates all [FarmAlert]s matching the [where] expression with the specified [columnValues].
  /// Returns the list of updated rows.
  ///
  /// If [noReturn] is set to `true`, the updated rows are not read back from
  /// the database and an empty list is returned. This avoids the overhead of
  /// transferring and deserializing the rows when the result is not needed.
  Future<List<FarmAlert>> updateWhere(
    _is.DatabaseSession session, {
    required _is.ColumnValueListBuilder<FarmAlertUpdateTable> columnValues,
    required _is.WhereExpressionBuilder<FarmAlertTable> where,
    int? limit,
    int? offset,
    _is.OrderByBuilder<FarmAlertTable>? orderBy,
    _is.OrderByListBuilder<FarmAlertTable>? orderByList,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.updateWhere<FarmAlert>(
      columnValues: columnValues(FarmAlert.t.updateTable),
      where: where(FarmAlert.t),
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(FarmAlert.t),
      orderByList: orderByList?.call(FarmAlert.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Deletes all [FarmAlert]s in the list and returns the deleted rows.
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
  Future<List<FarmAlert>> delete(
    _is.DatabaseSession session,
    List<FarmAlert> rows, {
    _is.OrderByBuilder<FarmAlertTable>? orderBy,
    _is.OrderByListBuilder<FarmAlertTable>? orderByList,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.delete<FarmAlert>(
      rows,
      orderBy: orderBy?.call(FarmAlert.t),
      orderByList: orderByList?.call(FarmAlert.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Deletes a single [FarmAlert].
  Future<FarmAlert> deleteRow(
    _is.DatabaseSession session,
    FarmAlert row, {
    _is.Transaction? transaction,
  }) async {
    return session.db.deleteRow<FarmAlert>(
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
  Future<List<FarmAlert>> deleteWhere(
    _is.DatabaseSession session, {
    required _is.WhereExpressionBuilder<FarmAlertTable> where,
    _is.OrderByBuilder<FarmAlertTable>? orderBy,
    _is.OrderByListBuilder<FarmAlertTable>? orderByList,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.deleteWhere<FarmAlert>(
      where: where(FarmAlert.t),
      orderBy: orderBy?.call(FarmAlert.t),
      orderByList: orderByList?.call(FarmAlert.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Counts the number of rows matching the [where] expression. If omitted,
  /// will return the count of all rows in the table.
  Future<int> count(
    _is.DatabaseSession session, {
    _is.WhereExpressionBuilder<FarmAlertTable>? where,
    int? limit,
    _is.Transaction? transaction,
  }) async {
    return session.db.count<FarmAlert>(
      where: where?.call(FarmAlert.t),
      limit: limit,
      transaction: transaction,
    );
  }

  /// Acquires row-level locks on [FarmAlert] rows matching the [where] expression.
  Future<void> lockRows(
    _is.DatabaseSession session, {
    required _is.WhereExpressionBuilder<FarmAlertTable> where,
    required _is.LockMode lockMode,
    required _is.Transaction transaction,
    _is.LockBehavior lockBehavior = _is.LockBehavior.wait,
  }) async {
    return session.db.lockRows<FarmAlert>(
      where: where(FarmAlert.t),
      lockMode: lockMode,
      lockBehavior: lockBehavior,
      transaction: transaction,
    );
  }
}
