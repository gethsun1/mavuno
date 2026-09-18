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

abstract class Farm implements _is.TableRow<int?>, _is.ProtocolSerialization {
  Farm._({
    this.id,
    required this.ownerId,
    required this.name,
    this.location,
    this.farmType,
    this.description,
    required this.createdAt,
    required this.updatedAt,
  });

  factory Farm({
    int? id,
    required String ownerId,
    required String name,
    String? location,
    String? farmType,
    String? description,
    required DateTime createdAt,
    required DateTime updatedAt,
  }) = _FarmImpl;

  factory Farm.fromJson(Map<String, dynamic> jsonSerialization) {
    return Farm(
      id: jsonSerialization['id'] as int?,
      ownerId: jsonSerialization['ownerId'] as String,
      name: jsonSerialization['name'] as String,
      location: jsonSerialization['location'] as String?,
      farmType: jsonSerialization['farmType'] as String?,
      description: jsonSerialization['description'] as String?,
      createdAt: _is.DateTimeJsonExtension.fromJson(
        jsonSerialization['createdAt'],
      ),
      updatedAt: _is.DateTimeJsonExtension.fromJson(
        jsonSerialization['updatedAt'],
      ),
    );
  }

  static final t = FarmTable();

  static const db = FarmRepository._();

  @override
  int? id;

  String ownerId;

  String name;

  String? location;

  String? farmType;

  String? description;

  DateTime createdAt;

  DateTime updatedAt;

  @override
  _is.Table<int?> get table => t;

  /// Returns a shallow copy of this [Farm]
  /// with some or all fields replaced by the given arguments.
  @_is.useResult
  Farm copyWith({
    int? id,
    String? ownerId,
    String? name,
    String? location,
    String? farmType,
    String? description,
    DateTime? createdAt,
    DateTime? updatedAt,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'Farm',
      if (id != null) 'id': id,
      'ownerId': ownerId,
      'name': name,
      if (location != null) 'location': location,
      if (farmType != null) 'farmType': farmType,
      if (description != null) 'description': description,
      'createdAt': createdAt.toJson(),
      'updatedAt': updatedAt.toJson(),
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {
      '__className__': 'Farm',
      if (id != null) 'id': id,
      'ownerId': ownerId,
      'name': name,
      if (location != null) 'location': location,
      if (farmType != null) 'farmType': farmType,
      if (description != null) 'description': description,
      'createdAt': createdAt.toJson(),
      'updatedAt': updatedAt.toJson(),
    };
  }

  static FarmInclude include() {
    return FarmInclude._();
  }

  static FarmIncludeList includeList({
    _is.WhereExpressionBuilder<FarmTable>? where,
    int? limit,
    int? offset,
    _is.OrderByBuilder<FarmTable>? orderBy,
    _is.OrderByListBuilder<FarmTable>? orderByList,
    FarmInclude? include,
  }) {
    return FarmIncludeList._(
      where: where,
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(Farm.t),
      orderByList: orderByList?.call(Farm.t),
      include: include,
    );
  }

  @override
  String toString() {
    return _is.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _FarmImpl extends Farm {
  _FarmImpl({
    int? id,
    required String ownerId,
    required String name,
    String? location,
    String? farmType,
    String? description,
    required DateTime createdAt,
    required DateTime updatedAt,
  }) : super._(
         id: id,
         ownerId: ownerId,
         name: name,
         location: location,
         farmType: farmType,
         description: description,
         createdAt: createdAt,
         updatedAt: updatedAt,
       );

  /// Returns a shallow copy of this [Farm]
  /// with some or all fields replaced by the given arguments.
  @_is.useResult
  @override
  Farm copyWith({
    Object? id = _Undefined,
    String? ownerId,
    String? name,
    Object? location = _Undefined,
    Object? farmType = _Undefined,
    Object? description = _Undefined,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) {
    return Farm(
      id: id is int? ? id : this.id,
      ownerId: ownerId ?? this.ownerId,
      name: name ?? this.name,
      location: location is String? ? location : this.location,
      farmType: farmType is String? ? farmType : this.farmType,
      description: description is String? ? description : this.description,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }
}

class FarmUpdateTable extends _is.UpdateTable<FarmTable> {
  FarmUpdateTable(super.table);

  _is.ColumnValue<String, String> ownerId(String value) => _is.ColumnValue(
    table.ownerId,
    value,
  );

  _is.ColumnValue<String, String> name(String value) => _is.ColumnValue(
    table.name,
    value,
  );

  _is.ColumnValue<String, String> location(String? value) => _is.ColumnValue(
    table.location,
    value,
  );

  _is.ColumnValue<String, String> farmType(String? value) => _is.ColumnValue(
    table.farmType,
    value,
  );

  _is.ColumnValue<String, String> description(String? value) => _is.ColumnValue(
    table.description,
    value,
  );

  _is.ColumnValue<DateTime, DateTime> createdAt(DateTime value) =>
      _is.ColumnValue(
        table.createdAt,
        value,
      );

  _is.ColumnValue<DateTime, DateTime> updatedAt(DateTime value) =>
      _is.ColumnValue(
        table.updatedAt,
        value,
      );
}

class FarmTable extends _is.Table<int?> {
  FarmTable({super.tableRelation}) : super(tableName: 'farm') {
    updateTable = FarmUpdateTable(this);
    ownerId = _is.ColumnString(
      'ownerId',
      this,
    );
    name = _is.ColumnString(
      'name',
      this,
    );
    location = _is.ColumnString(
      'location',
      this,
    );
    farmType = _is.ColumnString(
      'farmType',
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
    updatedAt = _is.ColumnDateTime(
      'updatedAt',
      this,
    );
  }

  late final FarmUpdateTable updateTable;

  late final _is.ColumnString ownerId;

  late final _is.ColumnString name;

  late final _is.ColumnString location;

  late final _is.ColumnString farmType;

  late final _is.ColumnString description;

  late final _is.ColumnDateTime createdAt;

  late final _is.ColumnDateTime updatedAt;

  @override
  List<_is.Column> get columns => [
    id,
    ownerId,
    name,
    location,
    farmType,
    description,
    createdAt,
    updatedAt,
  ];
}

class FarmInclude extends _is.IncludeObject {
  FarmInclude._();

  @override
  Map<String, _is.Include?> get includes => {};

  @override
  _is.Table<int?> get table => Farm.t;
}

class FarmIncludeList extends _is.IncludeList {
  FarmIncludeList._({
    _is.WhereExpressionBuilder<FarmTable>? where,
    super.limit,
    super.offset,
    super.orderBy,
    super.orderByList,
    super.include,
  }) {
    super.where = where?.call(Farm.t);
  }

  @override
  Map<String, _is.Include?> get includes => include?.includes ?? {};

  @override
  _is.Table<int?> get table => Farm.t;
}

class FarmRepository {
  const FarmRepository._();

  /// Returns a list of [Farm]s matching the given query parameters.
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
  Future<List<Farm>> find(
    _is.DatabaseSession session, {
    _is.WhereExpressionBuilder<FarmTable>? where,
    int? limit,
    int? offset,
    _is.OrderByBuilder<FarmTable>? orderBy,
    _is.OrderByListBuilder<FarmTable>? orderByList,
    _is.Transaction? transaction,
    _is.LockMode? lockMode,
    _is.LockBehavior? lockBehavior,
  }) async {
    return session.db.find<Farm>(
      where: where?.call(Farm.t),
      orderBy: orderBy?.call(Farm.t),
      orderByList: orderByList?.call(Farm.t),
      limit: limit,
      offset: offset,
      transaction: transaction,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Returns the first matching [Farm] matching the given query parameters.
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
  Future<Farm?> findFirstRow(
    _is.DatabaseSession session, {
    _is.WhereExpressionBuilder<FarmTable>? where,
    int? offset,
    _is.OrderByBuilder<FarmTable>? orderBy,
    _is.OrderByListBuilder<FarmTable>? orderByList,
    _is.Transaction? transaction,
    _is.LockMode? lockMode,
    _is.LockBehavior? lockBehavior,
  }) async {
    return session.db.findFirstRow<Farm>(
      where: where?.call(Farm.t),
      orderBy: orderBy?.call(Farm.t),
      orderByList: orderByList?.call(Farm.t),
      offset: offset,
      transaction: transaction,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Finds a single [Farm] by its [id] or null if no such row exists.
  Future<Farm?> findById(
    _is.DatabaseSession session,
    int id, {
    _is.Transaction? transaction,
    _is.LockMode? lockMode,
    _is.LockBehavior? lockBehavior,
  }) async {
    return session.db.findById<Farm>(
      id,
      transaction: transaction,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Inserts all [Farm]s in the list and returns the inserted rows.
  ///
  /// The returned [Farm]s will have their `id` fields set.
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
  Future<List<Farm>> insert(
    _is.DatabaseSession session,
    List<Farm> rows, {
    _is.Transaction? transaction,
    bool ignoreConflicts = false,
    bool noReturn = false,
  }) async {
    return session.db.insert<Farm>(
      rows,
      transaction: transaction,
      ignoreConflicts: ignoreConflicts,
      noReturn: noReturn,
    );
  }

  /// Inserts a single [Farm] and returns the inserted row.
  ///
  /// The returned [Farm] will have its `id` field set.
  Future<Farm> insertRow(
    _is.DatabaseSession session,
    Farm row, {
    _is.Transaction? transaction,
  }) async {
    return session.db.insertRow<Farm>(
      row,
      transaction: transaction,
    );
  }

  /// Upserts all [Farm]s in the list and returns the resulting rows.
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
  /// The returned [Farm]s will have their `id` fields set.
  ///
  /// This is an atomic operation, meaning that if one of the rows fails,
  /// none of the rows will be affected.
  ///
  /// If [noReturn] is set to `true`, the resulting rows are not read back from
  /// the database and an empty list is returned. This avoids the overhead of
  /// transferring and deserializing the rows when the result is not needed.
  Future<List<Farm>> upsert(
    _is.DatabaseSession session,
    List<Farm> rows, {
    required _is.ColumnSelections<FarmTable> conflictColumns,
    _is.ColumnSelections<FarmTable>? updateColumns,
    _is.WhereExpressionBuilder<FarmTable>? updateWhere,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.upsert<Farm>(
      rows,
      conflictColumns: conflictColumns(Farm.t),
      updateColumns: updateColumns?.call(Farm.t),
      updateWhere: updateWhere?.call(Farm.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Upserts a single [Farm] and returns the resulting row.
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
  /// The returned [Farm] will have its `id` field set.
  Future<Farm?> upsertRow(
    _is.DatabaseSession session,
    Farm row, {
    required _is.ColumnSelections<FarmTable> conflictColumns,
    _is.ColumnSelections<FarmTable>? updateColumns,
    _is.WhereExpressionBuilder<FarmTable>? updateWhere,
    _is.Transaction? transaction,
  }) async {
    return session.db.upsertRow<Farm>(
      row,
      conflictColumns: conflictColumns(Farm.t),
      updateColumns: updateColumns?.call(Farm.t),
      updateWhere: updateWhere?.call(Farm.t),
      transaction: transaction,
    );
  }

  /// Updates all [Farm]s in the list and returns the updated rows. If
  /// [columns] is provided, only those columns will be updated. Defaults to
  /// all columns.
  /// This is an atomic operation, meaning that if one of the rows fails to
  /// update, none of the rows will be updated.
  ///
  /// If [noReturn] is set to `true`, the updated rows are not read back from
  /// the database and an empty list is returned. This avoids the overhead of
  /// transferring and deserializing the rows when the result is not needed.
  Future<List<Farm>> update(
    _is.DatabaseSession session,
    List<Farm> rows, {
    _is.ColumnSelections<FarmTable>? columns,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.update<Farm>(
      rows,
      columns: columns?.call(Farm.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Updates a single [Farm]. The row needs to have its id set.
  /// Optionally, a list of [columns] can be provided to only update those
  /// columns. Defaults to all columns.
  Future<Farm> updateRow(
    _is.DatabaseSession session,
    Farm row, {
    _is.ColumnSelections<FarmTable>? columns,
    _is.Transaction? transaction,
  }) async {
    return session.db.updateRow<Farm>(
      row,
      columns: columns?.call(Farm.t),
      transaction: transaction,
    );
  }

  /// Updates a single [Farm] by its [id] with the specified [columnValues].
  /// Returns the updated row or null if no row with the given id exists.
  Future<Farm?> updateById(
    _is.DatabaseSession session,
    int id, {
    required _is.ColumnValueListBuilder<FarmUpdateTable> columnValues,
    _is.Transaction? transaction,
  }) async {
    return session.db.updateById<Farm>(
      id,
      columnValues: columnValues(Farm.t.updateTable),
      transaction: transaction,
    );
  }

  /// Updates all [Farm]s matching the [where] expression with the specified [columnValues].
  /// Returns the list of updated rows.
  ///
  /// If [noReturn] is set to `true`, the updated rows are not read back from
  /// the database and an empty list is returned. This avoids the overhead of
  /// transferring and deserializing the rows when the result is not needed.
  Future<List<Farm>> updateWhere(
    _is.DatabaseSession session, {
    required _is.ColumnValueListBuilder<FarmUpdateTable> columnValues,
    required _is.WhereExpressionBuilder<FarmTable> where,
    int? limit,
    int? offset,
    _is.OrderByBuilder<FarmTable>? orderBy,
    _is.OrderByListBuilder<FarmTable>? orderByList,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.updateWhere<Farm>(
      columnValues: columnValues(Farm.t.updateTable),
      where: where(Farm.t),
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(Farm.t),
      orderByList: orderByList?.call(Farm.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Deletes all [Farm]s in the list and returns the deleted rows.
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
  Future<List<Farm>> delete(
    _is.DatabaseSession session,
    List<Farm> rows, {
    _is.OrderByBuilder<FarmTable>? orderBy,
    _is.OrderByListBuilder<FarmTable>? orderByList,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.delete<Farm>(
      rows,
      orderBy: orderBy?.call(Farm.t),
      orderByList: orderByList?.call(Farm.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Deletes a single [Farm].
  Future<Farm> deleteRow(
    _is.DatabaseSession session,
    Farm row, {
    _is.Transaction? transaction,
  }) async {
    return session.db.deleteRow<Farm>(
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
  Future<List<Farm>> deleteWhere(
    _is.DatabaseSession session, {
    required _is.WhereExpressionBuilder<FarmTable> where,
    _is.OrderByBuilder<FarmTable>? orderBy,
    _is.OrderByListBuilder<FarmTable>? orderByList,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.deleteWhere<Farm>(
      where: where(Farm.t),
      orderBy: orderBy?.call(Farm.t),
      orderByList: orderByList?.call(Farm.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Counts the number of rows matching the [where] expression. If omitted,
  /// will return the count of all rows in the table.
  Future<int> count(
    _is.DatabaseSession session, {
    _is.WhereExpressionBuilder<FarmTable>? where,
    int? limit,
    _is.Transaction? transaction,
  }) async {
    return session.db.count<Farm>(
      where: where?.call(Farm.t),
      limit: limit,
      transaction: transaction,
    );
  }

  /// Acquires row-level locks on [Farm] rows matching the [where] expression.
  Future<void> lockRows(
    _is.DatabaseSession session, {
    required _is.WhereExpressionBuilder<FarmTable> where,
    required _is.LockMode lockMode,
    required _is.Transaction transaction,
    _is.LockBehavior lockBehavior = _is.LockBehavior.wait,
  }) async {
    return session.db.lockRows<Farm>(
      where: where(Farm.t),
      lockMode: lockMode,
      lockBehavior: lockBehavior,
      transaction: transaction,
    );
  }
}
