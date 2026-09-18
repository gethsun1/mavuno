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

abstract class ProductionRecord
    implements _is.TableRow<int?>, _is.ProtocolSerialization {
  ProductionRecord._({
    this.id,
    required this.animalId,
    required this.recordedAt,
    required this.metricType,
    required this.value,
    required this.unit,
    this.notes,
  });

  factory ProductionRecord({
    int? id,
    required int animalId,
    required DateTime recordedAt,
    required String metricType,
    required double value,
    required String unit,
    String? notes,
  }) = _ProductionRecordImpl;

  factory ProductionRecord.fromJson(Map<String, dynamic> jsonSerialization) {
    return ProductionRecord(
      id: jsonSerialization['id'] as int?,
      animalId: jsonSerialization['animalId'] as int,
      recordedAt: _is.DateTimeJsonExtension.fromJson(
        jsonSerialization['recordedAt'],
      ),
      metricType: jsonSerialization['metricType'] as String,
      value: (jsonSerialization['value'] as num).toDouble(),
      unit: jsonSerialization['unit'] as String,
      notes: jsonSerialization['notes'] as String?,
    );
  }

  static final t = ProductionRecordTable();

  static const db = ProductionRecordRepository._();

  @override
  int? id;

  int animalId;

  DateTime recordedAt;

  String metricType;

  double value;

  String unit;

  String? notes;

  @override
  _is.Table<int?> get table => t;

  /// Returns a shallow copy of this [ProductionRecord]
  /// with some or all fields replaced by the given arguments.
  @_is.useResult
  ProductionRecord copyWith({
    int? id,
    int? animalId,
    DateTime? recordedAt,
    String? metricType,
    double? value,
    String? unit,
    String? notes,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'ProductionRecord',
      if (id != null) 'id': id,
      'animalId': animalId,
      'recordedAt': recordedAt.toJson(),
      'metricType': metricType,
      'value': value,
      'unit': unit,
      if (notes != null) 'notes': notes,
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {
      '__className__': 'ProductionRecord',
      if (id != null) 'id': id,
      'animalId': animalId,
      'recordedAt': recordedAt.toJson(),
      'metricType': metricType,
      'value': value,
      'unit': unit,
      if (notes != null) 'notes': notes,
    };
  }

  static ProductionRecordInclude include() {
    return ProductionRecordInclude._();
  }

  static ProductionRecordIncludeList includeList({
    _is.WhereExpressionBuilder<ProductionRecordTable>? where,
    int? limit,
    int? offset,
    _is.OrderByBuilder<ProductionRecordTable>? orderBy,
    _is.OrderByListBuilder<ProductionRecordTable>? orderByList,
    ProductionRecordInclude? include,
  }) {
    return ProductionRecordIncludeList._(
      where: where,
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(ProductionRecord.t),
      orderByList: orderByList?.call(ProductionRecord.t),
      include: include,
    );
  }

  @override
  String toString() {
    return _is.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _ProductionRecordImpl extends ProductionRecord {
  _ProductionRecordImpl({
    int? id,
    required int animalId,
    required DateTime recordedAt,
    required String metricType,
    required double value,
    required String unit,
    String? notes,
  }) : super._(
         id: id,
         animalId: animalId,
         recordedAt: recordedAt,
         metricType: metricType,
         value: value,
         unit: unit,
         notes: notes,
       );

  /// Returns a shallow copy of this [ProductionRecord]
  /// with some or all fields replaced by the given arguments.
  @_is.useResult
  @override
  ProductionRecord copyWith({
    Object? id = _Undefined,
    int? animalId,
    DateTime? recordedAt,
    String? metricType,
    double? value,
    String? unit,
    Object? notes = _Undefined,
  }) {
    return ProductionRecord(
      id: id is int? ? id : this.id,
      animalId: animalId ?? this.animalId,
      recordedAt: recordedAt ?? this.recordedAt,
      metricType: metricType ?? this.metricType,
      value: value ?? this.value,
      unit: unit ?? this.unit,
      notes: notes is String? ? notes : this.notes,
    );
  }
}

class ProductionRecordUpdateTable
    extends _is.UpdateTable<ProductionRecordTable> {
  ProductionRecordUpdateTable(super.table);

  _is.ColumnValue<int, int> animalId(int value) => _is.ColumnValue(
    table.animalId,
    value,
  );

  _is.ColumnValue<DateTime, DateTime> recordedAt(DateTime value) =>
      _is.ColumnValue(
        table.recordedAt,
        value,
      );

  _is.ColumnValue<String, String> metricType(String value) => _is.ColumnValue(
    table.metricType,
    value,
  );

  _is.ColumnValue<double, double> value(double value) => _is.ColumnValue(
    table.value,
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

class ProductionRecordTable extends _is.Table<int?> {
  ProductionRecordTable({super.tableRelation})
    : super(tableName: 'production_record') {
    updateTable = ProductionRecordUpdateTable(this);
    animalId = _is.ColumnInt(
      'animalId',
      this,
    );
    recordedAt = _is.ColumnDateTime(
      'recordedAt',
      this,
    );
    metricType = _is.ColumnString(
      'metricType',
      this,
    );
    value = _is.ColumnDouble(
      'value',
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

  late final ProductionRecordUpdateTable updateTable;

  late final _is.ColumnInt animalId;

  late final _is.ColumnDateTime recordedAt;

  late final _is.ColumnString metricType;

  late final _is.ColumnDouble value;

  late final _is.ColumnString unit;

  late final _is.ColumnString notes;

  @override
  List<_is.Column> get columns => [
    id,
    animalId,
    recordedAt,
    metricType,
    value,
    unit,
    notes,
  ];
}

class ProductionRecordInclude extends _is.IncludeObject {
  ProductionRecordInclude._();

  @override
  Map<String, _is.Include?> get includes => {};

  @override
  _is.Table<int?> get table => ProductionRecord.t;
}

class ProductionRecordIncludeList extends _is.IncludeList {
  ProductionRecordIncludeList._({
    _is.WhereExpressionBuilder<ProductionRecordTable>? where,
    super.limit,
    super.offset,
    super.orderBy,
    super.orderByList,
    super.include,
  }) {
    super.where = where?.call(ProductionRecord.t);
  }

  @override
  Map<String, _is.Include?> get includes => include?.includes ?? {};

  @override
  _is.Table<int?> get table => ProductionRecord.t;
}

class ProductionRecordRepository {
  const ProductionRecordRepository._();

  /// Returns a list of [ProductionRecord]s matching the given query parameters.
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
  Future<List<ProductionRecord>> find(
    _is.DatabaseSession session, {
    _is.WhereExpressionBuilder<ProductionRecordTable>? where,
    int? limit,
    int? offset,
    _is.OrderByBuilder<ProductionRecordTable>? orderBy,
    _is.OrderByListBuilder<ProductionRecordTable>? orderByList,
    _is.Transaction? transaction,
    _is.LockMode? lockMode,
    _is.LockBehavior? lockBehavior,
  }) async {
    return session.db.find<ProductionRecord>(
      where: where?.call(ProductionRecord.t),
      orderBy: orderBy?.call(ProductionRecord.t),
      orderByList: orderByList?.call(ProductionRecord.t),
      limit: limit,
      offset: offset,
      transaction: transaction,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Returns the first matching [ProductionRecord] matching the given query parameters.
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
  Future<ProductionRecord?> findFirstRow(
    _is.DatabaseSession session, {
    _is.WhereExpressionBuilder<ProductionRecordTable>? where,
    int? offset,
    _is.OrderByBuilder<ProductionRecordTable>? orderBy,
    _is.OrderByListBuilder<ProductionRecordTable>? orderByList,
    _is.Transaction? transaction,
    _is.LockMode? lockMode,
    _is.LockBehavior? lockBehavior,
  }) async {
    return session.db.findFirstRow<ProductionRecord>(
      where: where?.call(ProductionRecord.t),
      orderBy: orderBy?.call(ProductionRecord.t),
      orderByList: orderByList?.call(ProductionRecord.t),
      offset: offset,
      transaction: transaction,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Finds a single [ProductionRecord] by its [id] or null if no such row exists.
  Future<ProductionRecord?> findById(
    _is.DatabaseSession session,
    int id, {
    _is.Transaction? transaction,
    _is.LockMode? lockMode,
    _is.LockBehavior? lockBehavior,
  }) async {
    return session.db.findById<ProductionRecord>(
      id,
      transaction: transaction,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Inserts all [ProductionRecord]s in the list and returns the inserted rows.
  ///
  /// The returned [ProductionRecord]s will have their `id` fields set.
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
  Future<List<ProductionRecord>> insert(
    _is.DatabaseSession session,
    List<ProductionRecord> rows, {
    _is.Transaction? transaction,
    bool ignoreConflicts = false,
    bool noReturn = false,
  }) async {
    return session.db.insert<ProductionRecord>(
      rows,
      transaction: transaction,
      ignoreConflicts: ignoreConflicts,
      noReturn: noReturn,
    );
  }

  /// Inserts a single [ProductionRecord] and returns the inserted row.
  ///
  /// The returned [ProductionRecord] will have its `id` field set.
  Future<ProductionRecord> insertRow(
    _is.DatabaseSession session,
    ProductionRecord row, {
    _is.Transaction? transaction,
  }) async {
    return session.db.insertRow<ProductionRecord>(
      row,
      transaction: transaction,
    );
  }

  /// Upserts all [ProductionRecord]s in the list and returns the resulting rows.
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
  /// The returned [ProductionRecord]s will have their `id` fields set.
  ///
  /// This is an atomic operation, meaning that if one of the rows fails,
  /// none of the rows will be affected.
  ///
  /// If [noReturn] is set to `true`, the resulting rows are not read back from
  /// the database and an empty list is returned. This avoids the overhead of
  /// transferring and deserializing the rows when the result is not needed.
  Future<List<ProductionRecord>> upsert(
    _is.DatabaseSession session,
    List<ProductionRecord> rows, {
    required _is.ColumnSelections<ProductionRecordTable> conflictColumns,
    _is.ColumnSelections<ProductionRecordTable>? updateColumns,
    _is.WhereExpressionBuilder<ProductionRecordTable>? updateWhere,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.upsert<ProductionRecord>(
      rows,
      conflictColumns: conflictColumns(ProductionRecord.t),
      updateColumns: updateColumns?.call(ProductionRecord.t),
      updateWhere: updateWhere?.call(ProductionRecord.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Upserts a single [ProductionRecord] and returns the resulting row.
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
  /// The returned [ProductionRecord] will have its `id` field set.
  Future<ProductionRecord?> upsertRow(
    _is.DatabaseSession session,
    ProductionRecord row, {
    required _is.ColumnSelections<ProductionRecordTable> conflictColumns,
    _is.ColumnSelections<ProductionRecordTable>? updateColumns,
    _is.WhereExpressionBuilder<ProductionRecordTable>? updateWhere,
    _is.Transaction? transaction,
  }) async {
    return session.db.upsertRow<ProductionRecord>(
      row,
      conflictColumns: conflictColumns(ProductionRecord.t),
      updateColumns: updateColumns?.call(ProductionRecord.t),
      updateWhere: updateWhere?.call(ProductionRecord.t),
      transaction: transaction,
    );
  }

  /// Updates all [ProductionRecord]s in the list and returns the updated rows. If
  /// [columns] is provided, only those columns will be updated. Defaults to
  /// all columns.
  /// This is an atomic operation, meaning that if one of the rows fails to
  /// update, none of the rows will be updated.
  ///
  /// If [noReturn] is set to `true`, the updated rows are not read back from
  /// the database and an empty list is returned. This avoids the overhead of
  /// transferring and deserializing the rows when the result is not needed.
  Future<List<ProductionRecord>> update(
    _is.DatabaseSession session,
    List<ProductionRecord> rows, {
    _is.ColumnSelections<ProductionRecordTable>? columns,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.update<ProductionRecord>(
      rows,
      columns: columns?.call(ProductionRecord.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Updates a single [ProductionRecord]. The row needs to have its id set.
  /// Optionally, a list of [columns] can be provided to only update those
  /// columns. Defaults to all columns.
  Future<ProductionRecord> updateRow(
    _is.DatabaseSession session,
    ProductionRecord row, {
    _is.ColumnSelections<ProductionRecordTable>? columns,
    _is.Transaction? transaction,
  }) async {
    return session.db.updateRow<ProductionRecord>(
      row,
      columns: columns?.call(ProductionRecord.t),
      transaction: transaction,
    );
  }

  /// Updates a single [ProductionRecord] by its [id] with the specified [columnValues].
  /// Returns the updated row or null if no row with the given id exists.
  Future<ProductionRecord?> updateById(
    _is.DatabaseSession session,
    int id, {
    required _is.ColumnValueListBuilder<ProductionRecordUpdateTable>
    columnValues,
    _is.Transaction? transaction,
  }) async {
    return session.db.updateById<ProductionRecord>(
      id,
      columnValues: columnValues(ProductionRecord.t.updateTable),
      transaction: transaction,
    );
  }

  /// Updates all [ProductionRecord]s matching the [where] expression with the specified [columnValues].
  /// Returns the list of updated rows.
  ///
  /// If [noReturn] is set to `true`, the updated rows are not read back from
  /// the database and an empty list is returned. This avoids the overhead of
  /// transferring and deserializing the rows when the result is not needed.
  Future<List<ProductionRecord>> updateWhere(
    _is.DatabaseSession session, {
    required _is.ColumnValueListBuilder<ProductionRecordUpdateTable>
    columnValues,
    required _is.WhereExpressionBuilder<ProductionRecordTable> where,
    int? limit,
    int? offset,
    _is.OrderByBuilder<ProductionRecordTable>? orderBy,
    _is.OrderByListBuilder<ProductionRecordTable>? orderByList,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.updateWhere<ProductionRecord>(
      columnValues: columnValues(ProductionRecord.t.updateTable),
      where: where(ProductionRecord.t),
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(ProductionRecord.t),
      orderByList: orderByList?.call(ProductionRecord.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Deletes all [ProductionRecord]s in the list and returns the deleted rows.
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
  Future<List<ProductionRecord>> delete(
    _is.DatabaseSession session,
    List<ProductionRecord> rows, {
    _is.OrderByBuilder<ProductionRecordTable>? orderBy,
    _is.OrderByListBuilder<ProductionRecordTable>? orderByList,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.delete<ProductionRecord>(
      rows,
      orderBy: orderBy?.call(ProductionRecord.t),
      orderByList: orderByList?.call(ProductionRecord.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Deletes a single [ProductionRecord].
  Future<ProductionRecord> deleteRow(
    _is.DatabaseSession session,
    ProductionRecord row, {
    _is.Transaction? transaction,
  }) async {
    return session.db.deleteRow<ProductionRecord>(
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
  Future<List<ProductionRecord>> deleteWhere(
    _is.DatabaseSession session, {
    required _is.WhereExpressionBuilder<ProductionRecordTable> where,
    _is.OrderByBuilder<ProductionRecordTable>? orderBy,
    _is.OrderByListBuilder<ProductionRecordTable>? orderByList,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.deleteWhere<ProductionRecord>(
      where: where(ProductionRecord.t),
      orderBy: orderBy?.call(ProductionRecord.t),
      orderByList: orderByList?.call(ProductionRecord.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Counts the number of rows matching the [where] expression. If omitted,
  /// will return the count of all rows in the table.
  Future<int> count(
    _is.DatabaseSession session, {
    _is.WhereExpressionBuilder<ProductionRecordTable>? where,
    int? limit,
    _is.Transaction? transaction,
  }) async {
    return session.db.count<ProductionRecord>(
      where: where?.call(ProductionRecord.t),
      limit: limit,
      transaction: transaction,
    );
  }

  /// Acquires row-level locks on [ProductionRecord] rows matching the [where] expression.
  Future<void> lockRows(
    _is.DatabaseSession session, {
    required _is.WhereExpressionBuilder<ProductionRecordTable> where,
    required _is.LockMode lockMode,
    required _is.Transaction transaction,
    _is.LockBehavior lockBehavior = _is.LockBehavior.wait,
  }) async {
    return session.db.lockRows<ProductionRecord>(
      where: where(ProductionRecord.t),
      lockMode: lockMode,
      lockBehavior: lockBehavior,
      transaction: transaction,
    );
  }
}
