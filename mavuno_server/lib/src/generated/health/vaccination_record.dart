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

abstract class VaccinationRecord
    implements _is.TableRow<int?>, _is.ProtocolSerialization {
  VaccinationRecord._({
    this.id,
    required this.animalId,
    required this.vaccination,
    required this.administeredAt,
    this.nextDueAt,
    this.provider,
    this.notes,
  });

  factory VaccinationRecord({
    int? id,
    required int animalId,
    required String vaccination,
    required DateTime administeredAt,
    DateTime? nextDueAt,
    String? provider,
    String? notes,
  }) = _VaccinationRecordImpl;

  factory VaccinationRecord.fromJson(Map<String, dynamic> jsonSerialization) {
    return VaccinationRecord(
      id: jsonSerialization['id'] as int?,
      animalId: jsonSerialization['animalId'] as int,
      vaccination: jsonSerialization['vaccination'] as String,
      administeredAt: _is.DateTimeJsonExtension.fromJson(
        jsonSerialization['administeredAt'],
      ),
      nextDueAt: jsonSerialization['nextDueAt'] == null
          ? null
          : _is.DateTimeJsonExtension.fromJson(jsonSerialization['nextDueAt']),
      provider: jsonSerialization['provider'] as String?,
      notes: jsonSerialization['notes'] as String?,
    );
  }

  static final t = VaccinationRecordTable();

  static const db = VaccinationRecordRepository._();

  @override
  int? id;

  int animalId;

  String vaccination;

  DateTime administeredAt;

  DateTime? nextDueAt;

  String? provider;

  String? notes;

  @override
  _is.Table<int?> get table => t;

  /// Returns a shallow copy of this [VaccinationRecord]
  /// with some or all fields replaced by the given arguments.
  @_is.useResult
  VaccinationRecord copyWith({
    int? id,
    int? animalId,
    String? vaccination,
    DateTime? administeredAt,
    DateTime? nextDueAt,
    String? provider,
    String? notes,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'VaccinationRecord',
      if (id != null) 'id': id,
      'animalId': animalId,
      'vaccination': vaccination,
      'administeredAt': administeredAt.toJson(),
      if (nextDueAt != null) 'nextDueAt': nextDueAt?.toJson(),
      if (provider != null) 'provider': provider,
      if (notes != null) 'notes': notes,
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {
      '__className__': 'VaccinationRecord',
      if (id != null) 'id': id,
      'animalId': animalId,
      'vaccination': vaccination,
      'administeredAt': administeredAt.toJson(),
      if (nextDueAt != null) 'nextDueAt': nextDueAt?.toJson(),
      if (provider != null) 'provider': provider,
      if (notes != null) 'notes': notes,
    };
  }

  static VaccinationRecordInclude include() {
    return VaccinationRecordInclude._();
  }

  static VaccinationRecordIncludeList includeList({
    _is.WhereExpressionBuilder<VaccinationRecordTable>? where,
    int? limit,
    int? offset,
    _is.OrderByBuilder<VaccinationRecordTable>? orderBy,
    _is.OrderByListBuilder<VaccinationRecordTable>? orderByList,
    VaccinationRecordInclude? include,
  }) {
    return VaccinationRecordIncludeList._(
      where: where,
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(VaccinationRecord.t),
      orderByList: orderByList?.call(VaccinationRecord.t),
      include: include,
    );
  }

  @override
  String toString() {
    return _is.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _VaccinationRecordImpl extends VaccinationRecord {
  _VaccinationRecordImpl({
    int? id,
    required int animalId,
    required String vaccination,
    required DateTime administeredAt,
    DateTime? nextDueAt,
    String? provider,
    String? notes,
  }) : super._(
         id: id,
         animalId: animalId,
         vaccination: vaccination,
         administeredAt: administeredAt,
         nextDueAt: nextDueAt,
         provider: provider,
         notes: notes,
       );

  /// Returns a shallow copy of this [VaccinationRecord]
  /// with some or all fields replaced by the given arguments.
  @_is.useResult
  @override
  VaccinationRecord copyWith({
    Object? id = _Undefined,
    int? animalId,
    String? vaccination,
    DateTime? administeredAt,
    Object? nextDueAt = _Undefined,
    Object? provider = _Undefined,
    Object? notes = _Undefined,
  }) {
    return VaccinationRecord(
      id: id is int? ? id : this.id,
      animalId: animalId ?? this.animalId,
      vaccination: vaccination ?? this.vaccination,
      administeredAt: administeredAt ?? this.administeredAt,
      nextDueAt: nextDueAt is DateTime? ? nextDueAt : this.nextDueAt,
      provider: provider is String? ? provider : this.provider,
      notes: notes is String? ? notes : this.notes,
    );
  }
}

class VaccinationRecordUpdateTable
    extends _is.UpdateTable<VaccinationRecordTable> {
  VaccinationRecordUpdateTable(super.table);

  _is.ColumnValue<int, int> animalId(int value) => _is.ColumnValue(
    table.animalId,
    value,
  );

  _is.ColumnValue<String, String> vaccination(String value) => _is.ColumnValue(
    table.vaccination,
    value,
  );

  _is.ColumnValue<DateTime, DateTime> administeredAt(DateTime value) =>
      _is.ColumnValue(
        table.administeredAt,
        value,
      );

  _is.ColumnValue<DateTime, DateTime> nextDueAt(DateTime? value) =>
      _is.ColumnValue(
        table.nextDueAt,
        value,
      );

  _is.ColumnValue<String, String> provider(String? value) => _is.ColumnValue(
    table.provider,
    value,
  );

  _is.ColumnValue<String, String> notes(String? value) => _is.ColumnValue(
    table.notes,
    value,
  );
}

class VaccinationRecordTable extends _is.Table<int?> {
  VaccinationRecordTable({super.tableRelation})
    : super(tableName: 'vaccination_record') {
    updateTable = VaccinationRecordUpdateTable(this);
    animalId = _is.ColumnInt(
      'animalId',
      this,
    );
    vaccination = _is.ColumnString(
      'vaccination',
      this,
    );
    administeredAt = _is.ColumnDateTime(
      'administeredAt',
      this,
    );
    nextDueAt = _is.ColumnDateTime(
      'nextDueAt',
      this,
    );
    provider = _is.ColumnString(
      'provider',
      this,
    );
    notes = _is.ColumnString(
      'notes',
      this,
    );
  }

  late final VaccinationRecordUpdateTable updateTable;

  late final _is.ColumnInt animalId;

  late final _is.ColumnString vaccination;

  late final _is.ColumnDateTime administeredAt;

  late final _is.ColumnDateTime nextDueAt;

  late final _is.ColumnString provider;

  late final _is.ColumnString notes;

  @override
  List<_is.Column> get columns => [
    id,
    animalId,
    vaccination,
    administeredAt,
    nextDueAt,
    provider,
    notes,
  ];
}

class VaccinationRecordInclude extends _is.IncludeObject {
  VaccinationRecordInclude._();

  @override
  Map<String, _is.Include?> get includes => {};

  @override
  _is.Table<int?> get table => VaccinationRecord.t;
}

class VaccinationRecordIncludeList extends _is.IncludeList {
  VaccinationRecordIncludeList._({
    _is.WhereExpressionBuilder<VaccinationRecordTable>? where,
    super.limit,
    super.offset,
    super.orderBy,
    super.orderByList,
    super.include,
  }) {
    super.where = where?.call(VaccinationRecord.t);
  }

  @override
  Map<String, _is.Include?> get includes => include?.includes ?? {};

  @override
  _is.Table<int?> get table => VaccinationRecord.t;
}

class VaccinationRecordRepository {
  const VaccinationRecordRepository._();

  /// Returns a list of [VaccinationRecord]s matching the given query parameters.
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
  Future<List<VaccinationRecord>> find(
    _is.DatabaseSession session, {
    _is.WhereExpressionBuilder<VaccinationRecordTable>? where,
    int? limit,
    int? offset,
    _is.OrderByBuilder<VaccinationRecordTable>? orderBy,
    _is.OrderByListBuilder<VaccinationRecordTable>? orderByList,
    _is.Transaction? transaction,
    _is.LockMode? lockMode,
    _is.LockBehavior? lockBehavior,
  }) async {
    return session.db.find<VaccinationRecord>(
      where: where?.call(VaccinationRecord.t),
      orderBy: orderBy?.call(VaccinationRecord.t),
      orderByList: orderByList?.call(VaccinationRecord.t),
      limit: limit,
      offset: offset,
      transaction: transaction,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Returns the first matching [VaccinationRecord] matching the given query parameters.
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
  Future<VaccinationRecord?> findFirstRow(
    _is.DatabaseSession session, {
    _is.WhereExpressionBuilder<VaccinationRecordTable>? where,
    int? offset,
    _is.OrderByBuilder<VaccinationRecordTable>? orderBy,
    _is.OrderByListBuilder<VaccinationRecordTable>? orderByList,
    _is.Transaction? transaction,
    _is.LockMode? lockMode,
    _is.LockBehavior? lockBehavior,
  }) async {
    return session.db.findFirstRow<VaccinationRecord>(
      where: where?.call(VaccinationRecord.t),
      orderBy: orderBy?.call(VaccinationRecord.t),
      orderByList: orderByList?.call(VaccinationRecord.t),
      offset: offset,
      transaction: transaction,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Finds a single [VaccinationRecord] by its [id] or null if no such row exists.
  Future<VaccinationRecord?> findById(
    _is.DatabaseSession session,
    int id, {
    _is.Transaction? transaction,
    _is.LockMode? lockMode,
    _is.LockBehavior? lockBehavior,
  }) async {
    return session.db.findById<VaccinationRecord>(
      id,
      transaction: transaction,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Inserts all [VaccinationRecord]s in the list and returns the inserted rows.
  ///
  /// The returned [VaccinationRecord]s will have their `id` fields set.
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
  Future<List<VaccinationRecord>> insert(
    _is.DatabaseSession session,
    List<VaccinationRecord> rows, {
    _is.Transaction? transaction,
    bool ignoreConflicts = false,
    bool noReturn = false,
  }) async {
    return session.db.insert<VaccinationRecord>(
      rows,
      transaction: transaction,
      ignoreConflicts: ignoreConflicts,
      noReturn: noReturn,
    );
  }

  /// Inserts a single [VaccinationRecord] and returns the inserted row.
  ///
  /// The returned [VaccinationRecord] will have its `id` field set.
  Future<VaccinationRecord> insertRow(
    _is.DatabaseSession session,
    VaccinationRecord row, {
    _is.Transaction? transaction,
  }) async {
    return session.db.insertRow<VaccinationRecord>(
      row,
      transaction: transaction,
    );
  }

  /// Upserts all [VaccinationRecord]s in the list and returns the resulting rows.
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
  /// The returned [VaccinationRecord]s will have their `id` fields set.
  ///
  /// This is an atomic operation, meaning that if one of the rows fails,
  /// none of the rows will be affected.
  ///
  /// If [noReturn] is set to `true`, the resulting rows are not read back from
  /// the database and an empty list is returned. This avoids the overhead of
  /// transferring and deserializing the rows when the result is not needed.
  Future<List<VaccinationRecord>> upsert(
    _is.DatabaseSession session,
    List<VaccinationRecord> rows, {
    required _is.ColumnSelections<VaccinationRecordTable> conflictColumns,
    _is.ColumnSelections<VaccinationRecordTable>? updateColumns,
    _is.WhereExpressionBuilder<VaccinationRecordTable>? updateWhere,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.upsert<VaccinationRecord>(
      rows,
      conflictColumns: conflictColumns(VaccinationRecord.t),
      updateColumns: updateColumns?.call(VaccinationRecord.t),
      updateWhere: updateWhere?.call(VaccinationRecord.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Upserts a single [VaccinationRecord] and returns the resulting row.
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
  /// The returned [VaccinationRecord] will have its `id` field set.
  Future<VaccinationRecord?> upsertRow(
    _is.DatabaseSession session,
    VaccinationRecord row, {
    required _is.ColumnSelections<VaccinationRecordTable> conflictColumns,
    _is.ColumnSelections<VaccinationRecordTable>? updateColumns,
    _is.WhereExpressionBuilder<VaccinationRecordTable>? updateWhere,
    _is.Transaction? transaction,
  }) async {
    return session.db.upsertRow<VaccinationRecord>(
      row,
      conflictColumns: conflictColumns(VaccinationRecord.t),
      updateColumns: updateColumns?.call(VaccinationRecord.t),
      updateWhere: updateWhere?.call(VaccinationRecord.t),
      transaction: transaction,
    );
  }

  /// Updates all [VaccinationRecord]s in the list and returns the updated rows. If
  /// [columns] is provided, only those columns will be updated. Defaults to
  /// all columns.
  /// This is an atomic operation, meaning that if one of the rows fails to
  /// update, none of the rows will be updated.
  ///
  /// If [noReturn] is set to `true`, the updated rows are not read back from
  /// the database and an empty list is returned. This avoids the overhead of
  /// transferring and deserializing the rows when the result is not needed.
  Future<List<VaccinationRecord>> update(
    _is.DatabaseSession session,
    List<VaccinationRecord> rows, {
    _is.ColumnSelections<VaccinationRecordTable>? columns,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.update<VaccinationRecord>(
      rows,
      columns: columns?.call(VaccinationRecord.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Updates a single [VaccinationRecord]. The row needs to have its id set.
  /// Optionally, a list of [columns] can be provided to only update those
  /// columns. Defaults to all columns.
  Future<VaccinationRecord> updateRow(
    _is.DatabaseSession session,
    VaccinationRecord row, {
    _is.ColumnSelections<VaccinationRecordTable>? columns,
    _is.Transaction? transaction,
  }) async {
    return session.db.updateRow<VaccinationRecord>(
      row,
      columns: columns?.call(VaccinationRecord.t),
      transaction: transaction,
    );
  }

  /// Updates a single [VaccinationRecord] by its [id] with the specified [columnValues].
  /// Returns the updated row or null if no row with the given id exists.
  Future<VaccinationRecord?> updateById(
    _is.DatabaseSession session,
    int id, {
    required _is.ColumnValueListBuilder<VaccinationRecordUpdateTable>
    columnValues,
    _is.Transaction? transaction,
  }) async {
    return session.db.updateById<VaccinationRecord>(
      id,
      columnValues: columnValues(VaccinationRecord.t.updateTable),
      transaction: transaction,
    );
  }

  /// Updates all [VaccinationRecord]s matching the [where] expression with the specified [columnValues].
  /// Returns the list of updated rows.
  ///
  /// If [noReturn] is set to `true`, the updated rows are not read back from
  /// the database and an empty list is returned. This avoids the overhead of
  /// transferring and deserializing the rows when the result is not needed.
  Future<List<VaccinationRecord>> updateWhere(
    _is.DatabaseSession session, {
    required _is.ColumnValueListBuilder<VaccinationRecordUpdateTable>
    columnValues,
    required _is.WhereExpressionBuilder<VaccinationRecordTable> where,
    int? limit,
    int? offset,
    _is.OrderByBuilder<VaccinationRecordTable>? orderBy,
    _is.OrderByListBuilder<VaccinationRecordTable>? orderByList,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.updateWhere<VaccinationRecord>(
      columnValues: columnValues(VaccinationRecord.t.updateTable),
      where: where(VaccinationRecord.t),
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(VaccinationRecord.t),
      orderByList: orderByList?.call(VaccinationRecord.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Deletes all [VaccinationRecord]s in the list and returns the deleted rows.
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
  Future<List<VaccinationRecord>> delete(
    _is.DatabaseSession session,
    List<VaccinationRecord> rows, {
    _is.OrderByBuilder<VaccinationRecordTable>? orderBy,
    _is.OrderByListBuilder<VaccinationRecordTable>? orderByList,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.delete<VaccinationRecord>(
      rows,
      orderBy: orderBy?.call(VaccinationRecord.t),
      orderByList: orderByList?.call(VaccinationRecord.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Deletes a single [VaccinationRecord].
  Future<VaccinationRecord> deleteRow(
    _is.DatabaseSession session,
    VaccinationRecord row, {
    _is.Transaction? transaction,
  }) async {
    return session.db.deleteRow<VaccinationRecord>(
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
  Future<List<VaccinationRecord>> deleteWhere(
    _is.DatabaseSession session, {
    required _is.WhereExpressionBuilder<VaccinationRecordTable> where,
    _is.OrderByBuilder<VaccinationRecordTable>? orderBy,
    _is.OrderByListBuilder<VaccinationRecordTable>? orderByList,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.deleteWhere<VaccinationRecord>(
      where: where(VaccinationRecord.t),
      orderBy: orderBy?.call(VaccinationRecord.t),
      orderByList: orderByList?.call(VaccinationRecord.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Counts the number of rows matching the [where] expression. If omitted,
  /// will return the count of all rows in the table.
  Future<int> count(
    _is.DatabaseSession session, {
    _is.WhereExpressionBuilder<VaccinationRecordTable>? where,
    int? limit,
    _is.Transaction? transaction,
  }) async {
    return session.db.count<VaccinationRecord>(
      where: where?.call(VaccinationRecord.t),
      limit: limit,
      transaction: transaction,
    );
  }

  /// Acquires row-level locks on [VaccinationRecord] rows matching the [where] expression.
  Future<void> lockRows(
    _is.DatabaseSession session, {
    required _is.WhereExpressionBuilder<VaccinationRecordTable> where,
    required _is.LockMode lockMode,
    required _is.Transaction transaction,
    _is.LockBehavior lockBehavior = _is.LockBehavior.wait,
  }) async {
    return session.db.lockRows<VaccinationRecord>(
      where: where(VaccinationRecord.t),
      lockMode: lockMode,
      lockBehavior: lockBehavior,
      transaction: transaction,
    );
  }
}
