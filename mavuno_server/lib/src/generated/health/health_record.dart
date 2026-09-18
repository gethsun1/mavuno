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

abstract class HealthRecord
    implements _is.TableRow<int?>, _is.ProtocolSerialization {
  HealthRecord._({
    this.id,
    required this.animalId,
    required this.recordedAt,
    required this.recordType,
    required this.description,
    this.professionalName,
    this.notes,
  });

  factory HealthRecord({
    int? id,
    required int animalId,
    required DateTime recordedAt,
    required String recordType,
    required String description,
    String? professionalName,
    String? notes,
  }) = _HealthRecordImpl;

  factory HealthRecord.fromJson(Map<String, dynamic> jsonSerialization) {
    return HealthRecord(
      id: jsonSerialization['id'] as int?,
      animalId: jsonSerialization['animalId'] as int,
      recordedAt: _is.DateTimeJsonExtension.fromJson(
        jsonSerialization['recordedAt'],
      ),
      recordType: jsonSerialization['recordType'] as String,
      description: jsonSerialization['description'] as String,
      professionalName: jsonSerialization['professionalName'] as String?,
      notes: jsonSerialization['notes'] as String?,
    );
  }

  static final t = HealthRecordTable();

  static const db = HealthRecordRepository._();

  @override
  int? id;

  int animalId;

  DateTime recordedAt;

  String recordType;

  String description;

  String? professionalName;

  String? notes;

  @override
  _is.Table<int?> get table => t;

  /// Returns a shallow copy of this [HealthRecord]
  /// with some or all fields replaced by the given arguments.
  @_is.useResult
  HealthRecord copyWith({
    int? id,
    int? animalId,
    DateTime? recordedAt,
    String? recordType,
    String? description,
    String? professionalName,
    String? notes,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'HealthRecord',
      if (id != null) 'id': id,
      'animalId': animalId,
      'recordedAt': recordedAt.toJson(),
      'recordType': recordType,
      'description': description,
      if (professionalName != null) 'professionalName': professionalName,
      if (notes != null) 'notes': notes,
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {
      '__className__': 'HealthRecord',
      if (id != null) 'id': id,
      'animalId': animalId,
      'recordedAt': recordedAt.toJson(),
      'recordType': recordType,
      'description': description,
      if (professionalName != null) 'professionalName': professionalName,
      if (notes != null) 'notes': notes,
    };
  }

  static HealthRecordInclude include() {
    return HealthRecordInclude._();
  }

  static HealthRecordIncludeList includeList({
    _is.WhereExpressionBuilder<HealthRecordTable>? where,
    int? limit,
    int? offset,
    _is.OrderByBuilder<HealthRecordTable>? orderBy,
    _is.OrderByListBuilder<HealthRecordTable>? orderByList,
    HealthRecordInclude? include,
  }) {
    return HealthRecordIncludeList._(
      where: where,
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(HealthRecord.t),
      orderByList: orderByList?.call(HealthRecord.t),
      include: include,
    );
  }

  @override
  String toString() {
    return _is.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _HealthRecordImpl extends HealthRecord {
  _HealthRecordImpl({
    int? id,
    required int animalId,
    required DateTime recordedAt,
    required String recordType,
    required String description,
    String? professionalName,
    String? notes,
  }) : super._(
         id: id,
         animalId: animalId,
         recordedAt: recordedAt,
         recordType: recordType,
         description: description,
         professionalName: professionalName,
         notes: notes,
       );

  /// Returns a shallow copy of this [HealthRecord]
  /// with some or all fields replaced by the given arguments.
  @_is.useResult
  @override
  HealthRecord copyWith({
    Object? id = _Undefined,
    int? animalId,
    DateTime? recordedAt,
    String? recordType,
    String? description,
    Object? professionalName = _Undefined,
    Object? notes = _Undefined,
  }) {
    return HealthRecord(
      id: id is int? ? id : this.id,
      animalId: animalId ?? this.animalId,
      recordedAt: recordedAt ?? this.recordedAt,
      recordType: recordType ?? this.recordType,
      description: description ?? this.description,
      professionalName: professionalName is String?
          ? professionalName
          : this.professionalName,
      notes: notes is String? ? notes : this.notes,
    );
  }
}

class HealthRecordUpdateTable extends _is.UpdateTable<HealthRecordTable> {
  HealthRecordUpdateTable(super.table);

  _is.ColumnValue<int, int> animalId(int value) => _is.ColumnValue(
    table.animalId,
    value,
  );

  _is.ColumnValue<DateTime, DateTime> recordedAt(DateTime value) =>
      _is.ColumnValue(
        table.recordedAt,
        value,
      );

  _is.ColumnValue<String, String> recordType(String value) => _is.ColumnValue(
    table.recordType,
    value,
  );

  _is.ColumnValue<String, String> description(String value) => _is.ColumnValue(
    table.description,
    value,
  );

  _is.ColumnValue<String, String> professionalName(String? value) =>
      _is.ColumnValue(
        table.professionalName,
        value,
      );

  _is.ColumnValue<String, String> notes(String? value) => _is.ColumnValue(
    table.notes,
    value,
  );
}

class HealthRecordTable extends _is.Table<int?> {
  HealthRecordTable({super.tableRelation}) : super(tableName: 'health_record') {
    updateTable = HealthRecordUpdateTable(this);
    animalId = _is.ColumnInt(
      'animalId',
      this,
    );
    recordedAt = _is.ColumnDateTime(
      'recordedAt',
      this,
    );
    recordType = _is.ColumnString(
      'recordType',
      this,
    );
    description = _is.ColumnString(
      'description',
      this,
    );
    professionalName = _is.ColumnString(
      'professionalName',
      this,
    );
    notes = _is.ColumnString(
      'notes',
      this,
    );
  }

  late final HealthRecordUpdateTable updateTable;

  late final _is.ColumnInt animalId;

  late final _is.ColumnDateTime recordedAt;

  late final _is.ColumnString recordType;

  late final _is.ColumnString description;

  late final _is.ColumnString professionalName;

  late final _is.ColumnString notes;

  @override
  List<_is.Column> get columns => [
    id,
    animalId,
    recordedAt,
    recordType,
    description,
    professionalName,
    notes,
  ];
}

class HealthRecordInclude extends _is.IncludeObject {
  HealthRecordInclude._();

  @override
  Map<String, _is.Include?> get includes => {};

  @override
  _is.Table<int?> get table => HealthRecord.t;
}

class HealthRecordIncludeList extends _is.IncludeList {
  HealthRecordIncludeList._({
    _is.WhereExpressionBuilder<HealthRecordTable>? where,
    super.limit,
    super.offset,
    super.orderBy,
    super.orderByList,
    super.include,
  }) {
    super.where = where?.call(HealthRecord.t);
  }

  @override
  Map<String, _is.Include?> get includes => include?.includes ?? {};

  @override
  _is.Table<int?> get table => HealthRecord.t;
}

class HealthRecordRepository {
  const HealthRecordRepository._();

  /// Returns a list of [HealthRecord]s matching the given query parameters.
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
  Future<List<HealthRecord>> find(
    _is.DatabaseSession session, {
    _is.WhereExpressionBuilder<HealthRecordTable>? where,
    int? limit,
    int? offset,
    _is.OrderByBuilder<HealthRecordTable>? orderBy,
    _is.OrderByListBuilder<HealthRecordTable>? orderByList,
    _is.Transaction? transaction,
    _is.LockMode? lockMode,
    _is.LockBehavior? lockBehavior,
  }) async {
    return session.db.find<HealthRecord>(
      where: where?.call(HealthRecord.t),
      orderBy: orderBy?.call(HealthRecord.t),
      orderByList: orderByList?.call(HealthRecord.t),
      limit: limit,
      offset: offset,
      transaction: transaction,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Returns the first matching [HealthRecord] matching the given query parameters.
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
  Future<HealthRecord?> findFirstRow(
    _is.DatabaseSession session, {
    _is.WhereExpressionBuilder<HealthRecordTable>? where,
    int? offset,
    _is.OrderByBuilder<HealthRecordTable>? orderBy,
    _is.OrderByListBuilder<HealthRecordTable>? orderByList,
    _is.Transaction? transaction,
    _is.LockMode? lockMode,
    _is.LockBehavior? lockBehavior,
  }) async {
    return session.db.findFirstRow<HealthRecord>(
      where: where?.call(HealthRecord.t),
      orderBy: orderBy?.call(HealthRecord.t),
      orderByList: orderByList?.call(HealthRecord.t),
      offset: offset,
      transaction: transaction,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Finds a single [HealthRecord] by its [id] or null if no such row exists.
  Future<HealthRecord?> findById(
    _is.DatabaseSession session,
    int id, {
    _is.Transaction? transaction,
    _is.LockMode? lockMode,
    _is.LockBehavior? lockBehavior,
  }) async {
    return session.db.findById<HealthRecord>(
      id,
      transaction: transaction,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Inserts all [HealthRecord]s in the list and returns the inserted rows.
  ///
  /// The returned [HealthRecord]s will have their `id` fields set.
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
  Future<List<HealthRecord>> insert(
    _is.DatabaseSession session,
    List<HealthRecord> rows, {
    _is.Transaction? transaction,
    bool ignoreConflicts = false,
    bool noReturn = false,
  }) async {
    return session.db.insert<HealthRecord>(
      rows,
      transaction: transaction,
      ignoreConflicts: ignoreConflicts,
      noReturn: noReturn,
    );
  }

  /// Inserts a single [HealthRecord] and returns the inserted row.
  ///
  /// The returned [HealthRecord] will have its `id` field set.
  Future<HealthRecord> insertRow(
    _is.DatabaseSession session,
    HealthRecord row, {
    _is.Transaction? transaction,
  }) async {
    return session.db.insertRow<HealthRecord>(
      row,
      transaction: transaction,
    );
  }

  /// Upserts all [HealthRecord]s in the list and returns the resulting rows.
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
  /// The returned [HealthRecord]s will have their `id` fields set.
  ///
  /// This is an atomic operation, meaning that if one of the rows fails,
  /// none of the rows will be affected.
  ///
  /// If [noReturn] is set to `true`, the resulting rows are not read back from
  /// the database and an empty list is returned. This avoids the overhead of
  /// transferring and deserializing the rows when the result is not needed.
  Future<List<HealthRecord>> upsert(
    _is.DatabaseSession session,
    List<HealthRecord> rows, {
    required _is.ColumnSelections<HealthRecordTable> conflictColumns,
    _is.ColumnSelections<HealthRecordTable>? updateColumns,
    _is.WhereExpressionBuilder<HealthRecordTable>? updateWhere,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.upsert<HealthRecord>(
      rows,
      conflictColumns: conflictColumns(HealthRecord.t),
      updateColumns: updateColumns?.call(HealthRecord.t),
      updateWhere: updateWhere?.call(HealthRecord.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Upserts a single [HealthRecord] and returns the resulting row.
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
  /// The returned [HealthRecord] will have its `id` field set.
  Future<HealthRecord?> upsertRow(
    _is.DatabaseSession session,
    HealthRecord row, {
    required _is.ColumnSelections<HealthRecordTable> conflictColumns,
    _is.ColumnSelections<HealthRecordTable>? updateColumns,
    _is.WhereExpressionBuilder<HealthRecordTable>? updateWhere,
    _is.Transaction? transaction,
  }) async {
    return session.db.upsertRow<HealthRecord>(
      row,
      conflictColumns: conflictColumns(HealthRecord.t),
      updateColumns: updateColumns?.call(HealthRecord.t),
      updateWhere: updateWhere?.call(HealthRecord.t),
      transaction: transaction,
    );
  }

  /// Updates all [HealthRecord]s in the list and returns the updated rows. If
  /// [columns] is provided, only those columns will be updated. Defaults to
  /// all columns.
  /// This is an atomic operation, meaning that if one of the rows fails to
  /// update, none of the rows will be updated.
  ///
  /// If [noReturn] is set to `true`, the updated rows are not read back from
  /// the database and an empty list is returned. This avoids the overhead of
  /// transferring and deserializing the rows when the result is not needed.
  Future<List<HealthRecord>> update(
    _is.DatabaseSession session,
    List<HealthRecord> rows, {
    _is.ColumnSelections<HealthRecordTable>? columns,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.update<HealthRecord>(
      rows,
      columns: columns?.call(HealthRecord.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Updates a single [HealthRecord]. The row needs to have its id set.
  /// Optionally, a list of [columns] can be provided to only update those
  /// columns. Defaults to all columns.
  Future<HealthRecord> updateRow(
    _is.DatabaseSession session,
    HealthRecord row, {
    _is.ColumnSelections<HealthRecordTable>? columns,
    _is.Transaction? transaction,
  }) async {
    return session.db.updateRow<HealthRecord>(
      row,
      columns: columns?.call(HealthRecord.t),
      transaction: transaction,
    );
  }

  /// Updates a single [HealthRecord] by its [id] with the specified [columnValues].
  /// Returns the updated row or null if no row with the given id exists.
  Future<HealthRecord?> updateById(
    _is.DatabaseSession session,
    int id, {
    required _is.ColumnValueListBuilder<HealthRecordUpdateTable> columnValues,
    _is.Transaction? transaction,
  }) async {
    return session.db.updateById<HealthRecord>(
      id,
      columnValues: columnValues(HealthRecord.t.updateTable),
      transaction: transaction,
    );
  }

  /// Updates all [HealthRecord]s matching the [where] expression with the specified [columnValues].
  /// Returns the list of updated rows.
  ///
  /// If [noReturn] is set to `true`, the updated rows are not read back from
  /// the database and an empty list is returned. This avoids the overhead of
  /// transferring and deserializing the rows when the result is not needed.
  Future<List<HealthRecord>> updateWhere(
    _is.DatabaseSession session, {
    required _is.ColumnValueListBuilder<HealthRecordUpdateTable> columnValues,
    required _is.WhereExpressionBuilder<HealthRecordTable> where,
    int? limit,
    int? offset,
    _is.OrderByBuilder<HealthRecordTable>? orderBy,
    _is.OrderByListBuilder<HealthRecordTable>? orderByList,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.updateWhere<HealthRecord>(
      columnValues: columnValues(HealthRecord.t.updateTable),
      where: where(HealthRecord.t),
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(HealthRecord.t),
      orderByList: orderByList?.call(HealthRecord.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Deletes all [HealthRecord]s in the list and returns the deleted rows.
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
  Future<List<HealthRecord>> delete(
    _is.DatabaseSession session,
    List<HealthRecord> rows, {
    _is.OrderByBuilder<HealthRecordTable>? orderBy,
    _is.OrderByListBuilder<HealthRecordTable>? orderByList,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.delete<HealthRecord>(
      rows,
      orderBy: orderBy?.call(HealthRecord.t),
      orderByList: orderByList?.call(HealthRecord.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Deletes a single [HealthRecord].
  Future<HealthRecord> deleteRow(
    _is.DatabaseSession session,
    HealthRecord row, {
    _is.Transaction? transaction,
  }) async {
    return session.db.deleteRow<HealthRecord>(
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
  Future<List<HealthRecord>> deleteWhere(
    _is.DatabaseSession session, {
    required _is.WhereExpressionBuilder<HealthRecordTable> where,
    _is.OrderByBuilder<HealthRecordTable>? orderBy,
    _is.OrderByListBuilder<HealthRecordTable>? orderByList,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.deleteWhere<HealthRecord>(
      where: where(HealthRecord.t),
      orderBy: orderBy?.call(HealthRecord.t),
      orderByList: orderByList?.call(HealthRecord.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Counts the number of rows matching the [where] expression. If omitted,
  /// will return the count of all rows in the table.
  Future<int> count(
    _is.DatabaseSession session, {
    _is.WhereExpressionBuilder<HealthRecordTable>? where,
    int? limit,
    _is.Transaction? transaction,
  }) async {
    return session.db.count<HealthRecord>(
      where: where?.call(HealthRecord.t),
      limit: limit,
      transaction: transaction,
    );
  }

  /// Acquires row-level locks on [HealthRecord] rows matching the [where] expression.
  Future<void> lockRows(
    _is.DatabaseSession session, {
    required _is.WhereExpressionBuilder<HealthRecordTable> where,
    required _is.LockMode lockMode,
    required _is.Transaction transaction,
    _is.LockBehavior lockBehavior = _is.LockBehavior.wait,
  }) async {
    return session.db.lockRows<HealthRecord>(
      where: where(HealthRecord.t),
      lockMode: lockMode,
      lockBehavior: lockBehavior,
      transaction: transaction,
    );
  }
}
