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

abstract class FeedRecord
    implements _is.TableRow<int?>, _is.ProtocolSerialization {
  FeedRecord._({
    this.id,
    required this.farmId,
    this.animalId,
    required this.recordedAt,
    required this.feedType,
    required this.quantity,
    required this.unit,
    this.notes,
  });

  factory FeedRecord({
    int? id,
    required int farmId,
    int? animalId,
    required DateTime recordedAt,
    required String feedType,
    required double quantity,
    required String unit,
    String? notes,
  }) = _FeedRecordImpl;

  factory FeedRecord.fromJson(Map<String, dynamic> jsonSerialization) {
    return FeedRecord(
      id: jsonSerialization['id'] as int?,
      farmId: jsonSerialization['farmId'] as int,
      animalId: jsonSerialization['animalId'] as int?,
      recordedAt: _is.DateTimeJsonExtension.fromJson(
        jsonSerialization['recordedAt'],
      ),
      feedType: jsonSerialization['feedType'] as String,
      quantity: (jsonSerialization['quantity'] as num).toDouble(),
      unit: jsonSerialization['unit'] as String,
      notes: jsonSerialization['notes'] as String?,
    );
  }

  static final t = FeedRecordTable();

  static const db = FeedRecordRepository._();

  @override
  int? id;

  int farmId;

  int? animalId;

  DateTime recordedAt;

  String feedType;

  double quantity;

  String unit;

  String? notes;

  @override
  _is.Table<int?> get table => t;

  /// Returns a shallow copy of this [FeedRecord]
  /// with some or all fields replaced by the given arguments.
  @_is.useResult
  FeedRecord copyWith({
    int? id,
    int? farmId,
    int? animalId,
    DateTime? recordedAt,
    String? feedType,
    double? quantity,
    String? unit,
    String? notes,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'FeedRecord',
      if (id != null) 'id': id,
      'farmId': farmId,
      if (animalId != null) 'animalId': animalId,
      'recordedAt': recordedAt.toJson(),
      'feedType': feedType,
      'quantity': quantity,
      'unit': unit,
      if (notes != null) 'notes': notes,
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {
      '__className__': 'FeedRecord',
      if (id != null) 'id': id,
      'farmId': farmId,
      if (animalId != null) 'animalId': animalId,
      'recordedAt': recordedAt.toJson(),
      'feedType': feedType,
      'quantity': quantity,
      'unit': unit,
      if (notes != null) 'notes': notes,
    };
  }

  static FeedRecordInclude include() {
    return FeedRecordInclude._();
  }

  static FeedRecordIncludeList includeList({
    _is.WhereExpressionBuilder<FeedRecordTable>? where,
    int? limit,
    int? offset,
    _is.OrderByBuilder<FeedRecordTable>? orderBy,
    _is.OrderByListBuilder<FeedRecordTable>? orderByList,
    FeedRecordInclude? include,
  }) {
    return FeedRecordIncludeList._(
      where: where,
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(FeedRecord.t),
      orderByList: orderByList?.call(FeedRecord.t),
      include: include,
    );
  }

  @override
  String toString() {
    return _is.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _FeedRecordImpl extends FeedRecord {
  _FeedRecordImpl({
    int? id,
    required int farmId,
    int? animalId,
    required DateTime recordedAt,
    required String feedType,
    required double quantity,
    required String unit,
    String? notes,
  }) : super._(
         id: id,
         farmId: farmId,
         animalId: animalId,
         recordedAt: recordedAt,
         feedType: feedType,
         quantity: quantity,
         unit: unit,
         notes: notes,
       );

  /// Returns a shallow copy of this [FeedRecord]
  /// with some or all fields replaced by the given arguments.
  @_is.useResult
  @override
  FeedRecord copyWith({
    Object? id = _Undefined,
    int? farmId,
    Object? animalId = _Undefined,
    DateTime? recordedAt,
    String? feedType,
    double? quantity,
    String? unit,
    Object? notes = _Undefined,
  }) {
    return FeedRecord(
      id: id is int? ? id : this.id,
      farmId: farmId ?? this.farmId,
      animalId: animalId is int? ? animalId : this.animalId,
      recordedAt: recordedAt ?? this.recordedAt,
      feedType: feedType ?? this.feedType,
      quantity: quantity ?? this.quantity,
      unit: unit ?? this.unit,
      notes: notes is String? ? notes : this.notes,
    );
  }
}

class FeedRecordUpdateTable extends _is.UpdateTable<FeedRecordTable> {
  FeedRecordUpdateTable(super.table);

  _is.ColumnValue<int, int> farmId(int value) => _is.ColumnValue(
    table.farmId,
    value,
  );

  _is.ColumnValue<int, int> animalId(int? value) => _is.ColumnValue(
    table.animalId,
    value,
  );

  _is.ColumnValue<DateTime, DateTime> recordedAt(DateTime value) =>
      _is.ColumnValue(
        table.recordedAt,
        value,
      );

  _is.ColumnValue<String, String> feedType(String value) => _is.ColumnValue(
    table.feedType,
    value,
  );

  _is.ColumnValue<double, double> quantity(double value) => _is.ColumnValue(
    table.quantity,
    value,
  );

  _is.ColumnValue<String, String> unit(String value) => _is.ColumnValue(
    table.unit,
    value,
  );

  _is.ColumnValue<String, String> notes(String? value) => _is.ColumnValue(
    table.notes,
    value,
  );
}

class FeedRecordTable extends _is.Table<int?> {
  FeedRecordTable({super.tableRelation}) : super(tableName: 'feed_record') {
    updateTable = FeedRecordUpdateTable(this);
    farmId = _is.ColumnInt(
      'farmId',
      this,
    );
    animalId = _is.ColumnInt(
      'animalId',
      this,
    );
    recordedAt = _is.ColumnDateTime(
      'recordedAt',
      this,
    );
    feedType = _is.ColumnString(
      'feedType',
      this,
    );
    quantity = _is.ColumnDouble(
      'quantity',
      this,
    );
    unit = _is.ColumnString(
      'unit',
      this,
    );
    notes = _is.ColumnString(
      'notes',
      this,
    );
  }

  late final FeedRecordUpdateTable updateTable;

  late final _is.ColumnInt farmId;

  late final _is.ColumnInt animalId;

  late final _is.ColumnDateTime recordedAt;

  late final _is.ColumnString feedType;

  late final _is.ColumnDouble quantity;

  late final _is.ColumnString unit;

  late final _is.ColumnString notes;

  @override
  List<_is.Column> get columns => [
    id,
    farmId,
    animalId,
    recordedAt,
    feedType,
    quantity,
    unit,
    notes,
  ];
}

class FeedRecordInclude extends _is.IncludeObject {
  FeedRecordInclude._();

  @override
  Map<String, _is.Include?> get includes => {};

  @override
  _is.Table<int?> get table => FeedRecord.t;
}

class FeedRecordIncludeList extends _is.IncludeList {
  FeedRecordIncludeList._({
    _is.WhereExpressionBuilder<FeedRecordTable>? where,
    super.limit,
    super.offset,
    super.orderBy,
    super.orderByList,
    super.include,
  }) {
    super.where = where?.call(FeedRecord.t);
  }

  @override
  Map<String, _is.Include?> get includes => include?.includes ?? {};

  @override
  _is.Table<int?> get table => FeedRecord.t;
}

class FeedRecordRepository {
  const FeedRecordRepository._();

  /// Returns a list of [FeedRecord]s matching the given query parameters.
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
  Future<List<FeedRecord>> find(
    _is.DatabaseSession session, {
    _is.WhereExpressionBuilder<FeedRecordTable>? where,
    int? limit,
    int? offset,
    _is.OrderByBuilder<FeedRecordTable>? orderBy,
    _is.OrderByListBuilder<FeedRecordTable>? orderByList,
    _is.Transaction? transaction,
    _is.LockMode? lockMode,
    _is.LockBehavior? lockBehavior,
  }) async {
    return session.db.find<FeedRecord>(
      where: where?.call(FeedRecord.t),
      orderBy: orderBy?.call(FeedRecord.t),
      orderByList: orderByList?.call(FeedRecord.t),
      limit: limit,
      offset: offset,
      transaction: transaction,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Returns the first matching [FeedRecord] matching the given query parameters.
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
  Future<FeedRecord?> findFirstRow(
    _is.DatabaseSession session, {
    _is.WhereExpressionBuilder<FeedRecordTable>? where,
    int? offset,
    _is.OrderByBuilder<FeedRecordTable>? orderBy,
    _is.OrderByListBuilder<FeedRecordTable>? orderByList,
    _is.Transaction? transaction,
    _is.LockMode? lockMode,
    _is.LockBehavior? lockBehavior,
  }) async {
    return session.db.findFirstRow<FeedRecord>(
      where: where?.call(FeedRecord.t),
      orderBy: orderBy?.call(FeedRecord.t),
      orderByList: orderByList?.call(FeedRecord.t),
      offset: offset,
      transaction: transaction,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Finds a single [FeedRecord] by its [id] or null if no such row exists.
  Future<FeedRecord?> findById(
    _is.DatabaseSession session,
    int id, {
    _is.Transaction? transaction,
    _is.LockMode? lockMode,
    _is.LockBehavior? lockBehavior,
  }) async {
    return session.db.findById<FeedRecord>(
      id,
      transaction: transaction,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Inserts all [FeedRecord]s in the list and returns the inserted rows.
  ///
  /// The returned [FeedRecord]s will have their `id` fields set.
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
  Future<List<FeedRecord>> insert(
    _is.DatabaseSession session,
    List<FeedRecord> rows, {
    _is.Transaction? transaction,
    bool ignoreConflicts = false,
    bool noReturn = false,
  }) async {
    return session.db.insert<FeedRecord>(
      rows,
      transaction: transaction,
      ignoreConflicts: ignoreConflicts,
      noReturn: noReturn,
    );
  }

  /// Inserts a single [FeedRecord] and returns the inserted row.
  ///
  /// The returned [FeedRecord] will have its `id` field set.
  Future<FeedRecord> insertRow(
    _is.DatabaseSession session,
    FeedRecord row, {
    _is.Transaction? transaction,
  }) async {
    return session.db.insertRow<FeedRecord>(
      row,
      transaction: transaction,
    );
  }

  /// Upserts all [FeedRecord]s in the list and returns the resulting rows.
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
  /// The returned [FeedRecord]s will have their `id` fields set.
  ///
  /// This is an atomic operation, meaning that if one of the rows fails,
  /// none of the rows will be affected.
  ///
  /// If [noReturn] is set to `true`, the resulting rows are not read back from
  /// the database and an empty list is returned. This avoids the overhead of
  /// transferring and deserializing the rows when the result is not needed.
  Future<List<FeedRecord>> upsert(
    _is.DatabaseSession session,
    List<FeedRecord> rows, {
    required _is.ColumnSelections<FeedRecordTable> conflictColumns,
    _is.ColumnSelections<FeedRecordTable>? updateColumns,
    _is.WhereExpressionBuilder<FeedRecordTable>? updateWhere,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.upsert<FeedRecord>(
      rows,
      conflictColumns: conflictColumns(FeedRecord.t),
      updateColumns: updateColumns?.call(FeedRecord.t),
      updateWhere: updateWhere?.call(FeedRecord.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Upserts a single [FeedRecord] and returns the resulting row.
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
  /// The returned [FeedRecord] will have its `id` field set.
  Future<FeedRecord?> upsertRow(
    _is.DatabaseSession session,
    FeedRecord row, {
    required _is.ColumnSelections<FeedRecordTable> conflictColumns,
    _is.ColumnSelections<FeedRecordTable>? updateColumns,
    _is.WhereExpressionBuilder<FeedRecordTable>? updateWhere,
    _is.Transaction? transaction,
  }) async {
    return session.db.upsertRow<FeedRecord>(
      row,
      conflictColumns: conflictColumns(FeedRecord.t),
      updateColumns: updateColumns?.call(FeedRecord.t),
      updateWhere: updateWhere?.call(FeedRecord.t),
      transaction: transaction,
    );
  }

  /// Updates all [FeedRecord]s in the list and returns the updated rows. If
  /// [columns] is provided, only those columns will be updated. Defaults to
  /// all columns.
  /// This is an atomic operation, meaning that if one of the rows fails to
  /// update, none of the rows will be updated.
  ///
  /// If [noReturn] is set to `true`, the updated rows are not read back from
  /// the database and an empty list is returned. This avoids the overhead of
  /// transferring and deserializing the rows when the result is not needed.
  Future<List<FeedRecord>> update(
    _is.DatabaseSession session,
    List<FeedRecord> rows, {
    _is.ColumnSelections<FeedRecordTable>? columns,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.update<FeedRecord>(
      rows,
      columns: columns?.call(FeedRecord.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Updates a single [FeedRecord]. The row needs to have its id set.
  /// Optionally, a list of [columns] can be provided to only update those
  /// columns. Defaults to all columns.
  Future<FeedRecord> updateRow(
    _is.DatabaseSession session,
    FeedRecord row, {
    _is.ColumnSelections<FeedRecordTable>? columns,
    _is.Transaction? transaction,
  }) async {
    return session.db.updateRow<FeedRecord>(
      row,
      columns: columns?.call(FeedRecord.t),
      transaction: transaction,
    );
  }

  /// Updates a single [FeedRecord] by its [id] with the specified [columnValues].
  /// Returns the updated row or null if no row with the given id exists.
  Future<FeedRecord?> updateById(
    _is.DatabaseSession session,
    int id, {
    required _is.ColumnValueListBuilder<FeedRecordUpdateTable> columnValues,
    _is.Transaction? transaction,
  }) async {
    return session.db.updateById<FeedRecord>(
      id,
      columnValues: columnValues(FeedRecord.t.updateTable),
      transaction: transaction,
    );
  }

  /// Updates all [FeedRecord]s matching the [where] expression with the specified [columnValues].
  /// Returns the list of updated rows.
  ///
  /// If [noReturn] is set to `true`, the updated rows are not read back from
  /// the database and an empty list is returned. This avoids the overhead of
  /// transferring and deserializing the rows when the result is not needed.
  Future<List<FeedRecord>> updateWhere(
    _is.DatabaseSession session, {
    required _is.ColumnValueListBuilder<FeedRecordUpdateTable> columnValues,
    required _is.WhereExpressionBuilder<FeedRecordTable> where,
    int? limit,
    int? offset,
    _is.OrderByBuilder<FeedRecordTable>? orderBy,
    _is.OrderByListBuilder<FeedRecordTable>? orderByList,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.updateWhere<FeedRecord>(
      columnValues: columnValues(FeedRecord.t.updateTable),
      where: where(FeedRecord.t),
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(FeedRecord.t),
      orderByList: orderByList?.call(FeedRecord.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Deletes all [FeedRecord]s in the list and returns the deleted rows.
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
  Future<List<FeedRecord>> delete(
    _is.DatabaseSession session,
    List<FeedRecord> rows, {
    _is.OrderByBuilder<FeedRecordTable>? orderBy,
    _is.OrderByListBuilder<FeedRecordTable>? orderByList,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.delete<FeedRecord>(
      rows,
      orderBy: orderBy?.call(FeedRecord.t),
      orderByList: orderByList?.call(FeedRecord.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Deletes a single [FeedRecord].
  Future<FeedRecord> deleteRow(
    _is.DatabaseSession session,
    FeedRecord row, {
    _is.Transaction? transaction,
  }) async {
    return session.db.deleteRow<FeedRecord>(
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
  Future<List<FeedRecord>> deleteWhere(
    _is.DatabaseSession session, {
    required _is.WhereExpressionBuilder<FeedRecordTable> where,
    _is.OrderByBuilder<FeedRecordTable>? orderBy,
    _is.OrderByListBuilder<FeedRecordTable>? orderByList,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.deleteWhere<FeedRecord>(
      where: where(FeedRecord.t),
      orderBy: orderBy?.call(FeedRecord.t),
      orderByList: orderByList?.call(FeedRecord.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Counts the number of rows matching the [where] expression. If omitted,
  /// will return the count of all rows in the table.
  Future<int> count(
    _is.DatabaseSession session, {
    _is.WhereExpressionBuilder<FeedRecordTable>? where,
    int? limit,
    _is.Transaction? transaction,
  }) async {
    return session.db.count<FeedRecord>(
      where: where?.call(FeedRecord.t),
      limit: limit,
      transaction: transaction,
    );
  }

  /// Acquires row-level locks on [FeedRecord] rows matching the [where] expression.
  Future<void> lockRows(
    _is.DatabaseSession session, {
    required _is.WhereExpressionBuilder<FeedRecordTable> where,
    required _is.LockMode lockMode,
    required _is.Transaction transaction,
    _is.LockBehavior lockBehavior = _is.LockBehavior.wait,
  }) async {
    return session.db.lockRows<FeedRecord>(
      where: where(FeedRecord.t),
      lockMode: lockMode,
      lockBehavior: lockBehavior,
      transaction: transaction,
    );
  }
}
