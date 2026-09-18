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

abstract class AnimalObservation
    implements _is.TableRow<int?>, _is.ProtocolSerialization {
  AnimalObservation._({
    this.id,
    required this.animalId,
    required this.recordedAt,
    this.temperature,
    this.activityScore,
    this.appetiteScore,
    this.feedIntake,
    this.productionValue,
    this.productionUnit,
    this.visibleSymptoms,
    this.notes,
    required this.recordedBy,
  });

  factory AnimalObservation({
    int? id,
    required int animalId,
    required DateTime recordedAt,
    double? temperature,
    int? activityScore,
    int? appetiteScore,
    double? feedIntake,
    double? productionValue,
    String? productionUnit,
    String? visibleSymptoms,
    String? notes,
    required String recordedBy,
  }) = _AnimalObservationImpl;

  factory AnimalObservation.fromJson(Map<String, dynamic> jsonSerialization) {
    return AnimalObservation(
      id: jsonSerialization['id'] as int?,
      animalId: jsonSerialization['animalId'] as int,
      recordedAt: _is.DateTimeJsonExtension.fromJson(
        jsonSerialization['recordedAt'],
      ),
      temperature: (jsonSerialization['temperature'] as num?)?.toDouble(),
      activityScore: jsonSerialization['activityScore'] as int?,
      appetiteScore: jsonSerialization['appetiteScore'] as int?,
      feedIntake: (jsonSerialization['feedIntake'] as num?)?.toDouble(),
      productionValue: (jsonSerialization['productionValue'] as num?)
          ?.toDouble(),
      productionUnit: jsonSerialization['productionUnit'] as String?,
      visibleSymptoms: jsonSerialization['visibleSymptoms'] as String?,
      notes: jsonSerialization['notes'] as String?,
      recordedBy: jsonSerialization['recordedBy'] as String,
    );
  }

  static final t = AnimalObservationTable();

  static const db = AnimalObservationRepository._();

  @override
  int? id;

  int animalId;

  DateTime recordedAt;

  double? temperature;

  int? activityScore;

  int? appetiteScore;

  double? feedIntake;

  double? productionValue;

  String? productionUnit;

  String? visibleSymptoms;

  String? notes;

  String recordedBy;

  @override
  _is.Table<int?> get table => t;

  /// Returns a shallow copy of this [AnimalObservation]
  /// with some or all fields replaced by the given arguments.
  @_is.useResult
  AnimalObservation copyWith({
    int? id,
    int? animalId,
    DateTime? recordedAt,
    double? temperature,
    int? activityScore,
    int? appetiteScore,
    double? feedIntake,
    double? productionValue,
    String? productionUnit,
    String? visibleSymptoms,
    String? notes,
    String? recordedBy,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'AnimalObservation',
      if (id != null) 'id': id,
      'animalId': animalId,
      'recordedAt': recordedAt.toJson(),
      if (temperature != null) 'temperature': temperature,
      if (activityScore != null) 'activityScore': activityScore,
      if (appetiteScore != null) 'appetiteScore': appetiteScore,
      if (feedIntake != null) 'feedIntake': feedIntake,
      if (productionValue != null) 'productionValue': productionValue,
      if (productionUnit != null) 'productionUnit': productionUnit,
      if (visibleSymptoms != null) 'visibleSymptoms': visibleSymptoms,
      if (notes != null) 'notes': notes,
      'recordedBy': recordedBy,
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {
      '__className__': 'AnimalObservation',
      if (id != null) 'id': id,
      'animalId': animalId,
      'recordedAt': recordedAt.toJson(),
      if (temperature != null) 'temperature': temperature,
      if (activityScore != null) 'activityScore': activityScore,
      if (appetiteScore != null) 'appetiteScore': appetiteScore,
      if (feedIntake != null) 'feedIntake': feedIntake,
      if (productionValue != null) 'productionValue': productionValue,
      if (productionUnit != null) 'productionUnit': productionUnit,
      if (visibleSymptoms != null) 'visibleSymptoms': visibleSymptoms,
      if (notes != null) 'notes': notes,
      'recordedBy': recordedBy,
    };
  }

  static AnimalObservationInclude include() {
    return AnimalObservationInclude._();
  }

  static AnimalObservationIncludeList includeList({
    _is.WhereExpressionBuilder<AnimalObservationTable>? where,
    int? limit,
    int? offset,
    _is.OrderByBuilder<AnimalObservationTable>? orderBy,
    _is.OrderByListBuilder<AnimalObservationTable>? orderByList,
    AnimalObservationInclude? include,
  }) {
    return AnimalObservationIncludeList._(
      where: where,
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(AnimalObservation.t),
      orderByList: orderByList?.call(AnimalObservation.t),
      include: include,
    );
  }

  @override
  String toString() {
    return _is.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _AnimalObservationImpl extends AnimalObservation {
  _AnimalObservationImpl({
    int? id,
    required int animalId,
    required DateTime recordedAt,
    double? temperature,
    int? activityScore,
    int? appetiteScore,
    double? feedIntake,
    double? productionValue,
    String? productionUnit,
    String? visibleSymptoms,
    String? notes,
    required String recordedBy,
  }) : super._(
         id: id,
         animalId: animalId,
         recordedAt: recordedAt,
         temperature: temperature,
         activityScore: activityScore,
         appetiteScore: appetiteScore,
         feedIntake: feedIntake,
         productionValue: productionValue,
         productionUnit: productionUnit,
         visibleSymptoms: visibleSymptoms,
         notes: notes,
         recordedBy: recordedBy,
       );

  /// Returns a shallow copy of this [AnimalObservation]
  /// with some or all fields replaced by the given arguments.
  @_is.useResult
  @override
  AnimalObservation copyWith({
    Object? id = _Undefined,
    int? animalId,
    DateTime? recordedAt,
    Object? temperature = _Undefined,
    Object? activityScore = _Undefined,
    Object? appetiteScore = _Undefined,
    Object? feedIntake = _Undefined,
    Object? productionValue = _Undefined,
    Object? productionUnit = _Undefined,
    Object? visibleSymptoms = _Undefined,
    Object? notes = _Undefined,
    String? recordedBy,
  }) {
    return AnimalObservation(
      id: id is int? ? id : this.id,
      animalId: animalId ?? this.animalId,
      recordedAt: recordedAt ?? this.recordedAt,
      temperature: temperature is double? ? temperature : this.temperature,
      activityScore: activityScore is int? ? activityScore : this.activityScore,
      appetiteScore: appetiteScore is int? ? appetiteScore : this.appetiteScore,
      feedIntake: feedIntake is double? ? feedIntake : this.feedIntake,
      productionValue: productionValue is double?
          ? productionValue
          : this.productionValue,
      productionUnit: productionUnit is String?
          ? productionUnit
          : this.productionUnit,
      visibleSymptoms: visibleSymptoms is String?
          ? visibleSymptoms
          : this.visibleSymptoms,
      notes: notes is String? ? notes : this.notes,
      recordedBy: recordedBy ?? this.recordedBy,
    );
  }
}

class AnimalObservationUpdateTable
    extends _is.UpdateTable<AnimalObservationTable> {
  AnimalObservationUpdateTable(super.table);

  _is.ColumnValue<int, int> animalId(int value) => _is.ColumnValue(
    table.animalId,
    value,
  );

  _is.ColumnValue<DateTime, DateTime> recordedAt(DateTime value) =>
      _is.ColumnValue(
        table.recordedAt,
        value,
      );

  _is.ColumnValue<double, double> temperature(double? value) => _is.ColumnValue(
    table.temperature,
    value,
  );

  _is.ColumnValue<int, int> activityScore(int? value) => _is.ColumnValue(
    table.activityScore,
    value,
  );

  _is.ColumnValue<int, int> appetiteScore(int? value) => _is.ColumnValue(
    table.appetiteScore,
    value,
  );

  _is.ColumnValue<double, double> feedIntake(double? value) => _is.ColumnValue(
    table.feedIntake,
    value,
  );

  _is.ColumnValue<double, double> productionValue(double? value) =>
      _is.ColumnValue(
        table.productionValue,
        value,
      );

  _is.ColumnValue<String, String> productionUnit(String? value) =>
      _is.ColumnValue(
        table.productionUnit,
        value,
      );

  _is.ColumnValue<String, String> visibleSymptoms(String? value) =>
      _is.ColumnValue(
        table.visibleSymptoms,
        value,
      );

  _is.ColumnValue<String, String> notes(String? value) => _is.ColumnValue(
    table.notes,
    value,
  );

  _is.ColumnValue<String, String> recordedBy(String value) => _is.ColumnValue(
    table.recordedBy,
    value,
  );
}

class AnimalObservationTable extends _is.Table<int?> {
  AnimalObservationTable({super.tableRelation})
    : super(tableName: 'animal_observation') {
    updateTable = AnimalObservationUpdateTable(this);
    animalId = _is.ColumnInt(
      'animalId',
      this,
    );
    recordedAt = _is.ColumnDateTime(
      'recordedAt',
      this,
    );
    temperature = _is.ColumnDouble(
      'temperature',
      this,
    );
    activityScore = _is.ColumnInt(
      'activityScore',
      this,
    );
    appetiteScore = _is.ColumnInt(
      'appetiteScore',
      this,
    );
    feedIntake = _is.ColumnDouble(
      'feedIntake',
      this,
    );
    productionValue = _is.ColumnDouble(
      'productionValue',
      this,
    );
    productionUnit = _is.ColumnString(
      'productionUnit',
      this,
    );
    visibleSymptoms = _is.ColumnString(
      'visibleSymptoms',
      this,
    );
    notes = _is.ColumnString(
      'notes',
      this,
    );
    recordedBy = _is.ColumnString(
      'recordedBy',
      this,
    );
  }

  late final AnimalObservationUpdateTable updateTable;

  late final _is.ColumnInt animalId;

  late final _is.ColumnDateTime recordedAt;

  late final _is.ColumnDouble temperature;

  late final _is.ColumnInt activityScore;

  late final _is.ColumnInt appetiteScore;

  late final _is.ColumnDouble feedIntake;

  late final _is.ColumnDouble productionValue;

  late final _is.ColumnString productionUnit;

  late final _is.ColumnString visibleSymptoms;

  late final _is.ColumnString notes;

  late final _is.ColumnString recordedBy;

  @override
  List<_is.Column> get columns => [
    id,
    animalId,
    recordedAt,
    temperature,
    activityScore,
    appetiteScore,
    feedIntake,
    productionValue,
    productionUnit,
    visibleSymptoms,
    notes,
    recordedBy,
  ];
}

class AnimalObservationInclude extends _is.IncludeObject {
  AnimalObservationInclude._();

  @override
  Map<String, _is.Include?> get includes => {};

  @override
  _is.Table<int?> get table => AnimalObservation.t;
}

class AnimalObservationIncludeList extends _is.IncludeList {
  AnimalObservationIncludeList._({
    _is.WhereExpressionBuilder<AnimalObservationTable>? where,
    super.limit,
    super.offset,
    super.orderBy,
    super.orderByList,
    super.include,
  }) {
    super.where = where?.call(AnimalObservation.t);
  }

  @override
  Map<String, _is.Include?> get includes => include?.includes ?? {};

  @override
  _is.Table<int?> get table => AnimalObservation.t;
}

class AnimalObservationRepository {
  const AnimalObservationRepository._();

  /// Returns a list of [AnimalObservation]s matching the given query parameters.
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
  Future<List<AnimalObservation>> find(
    _is.DatabaseSession session, {
    _is.WhereExpressionBuilder<AnimalObservationTable>? where,
    int? limit,
    int? offset,
    _is.OrderByBuilder<AnimalObservationTable>? orderBy,
    _is.OrderByListBuilder<AnimalObservationTable>? orderByList,
    _is.Transaction? transaction,
    _is.LockMode? lockMode,
    _is.LockBehavior? lockBehavior,
  }) async {
    return session.db.find<AnimalObservation>(
      where: where?.call(AnimalObservation.t),
      orderBy: orderBy?.call(AnimalObservation.t),
      orderByList: orderByList?.call(AnimalObservation.t),
      limit: limit,
      offset: offset,
      transaction: transaction,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Returns the first matching [AnimalObservation] matching the given query parameters.
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
  Future<AnimalObservation?> findFirstRow(
    _is.DatabaseSession session, {
    _is.WhereExpressionBuilder<AnimalObservationTable>? where,
    int? offset,
    _is.OrderByBuilder<AnimalObservationTable>? orderBy,
    _is.OrderByListBuilder<AnimalObservationTable>? orderByList,
    _is.Transaction? transaction,
    _is.LockMode? lockMode,
    _is.LockBehavior? lockBehavior,
  }) async {
    return session.db.findFirstRow<AnimalObservation>(
      where: where?.call(AnimalObservation.t),
      orderBy: orderBy?.call(AnimalObservation.t),
      orderByList: orderByList?.call(AnimalObservation.t),
      offset: offset,
      transaction: transaction,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Finds a single [AnimalObservation] by its [id] or null if no such row exists.
  Future<AnimalObservation?> findById(
    _is.DatabaseSession session,
    int id, {
    _is.Transaction? transaction,
    _is.LockMode? lockMode,
    _is.LockBehavior? lockBehavior,
  }) async {
    return session.db.findById<AnimalObservation>(
      id,
      transaction: transaction,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Inserts all [AnimalObservation]s in the list and returns the inserted rows.
  ///
  /// The returned [AnimalObservation]s will have their `id` fields set.
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
  Future<List<AnimalObservation>> insert(
    _is.DatabaseSession session,
    List<AnimalObservation> rows, {
    _is.Transaction? transaction,
    bool ignoreConflicts = false,
    bool noReturn = false,
  }) async {
    return session.db.insert<AnimalObservation>(
      rows,
      transaction: transaction,
      ignoreConflicts: ignoreConflicts,
      noReturn: noReturn,
    );
  }

  /// Inserts a single [AnimalObservation] and returns the inserted row.
  ///
  /// The returned [AnimalObservation] will have its `id` field set.
  Future<AnimalObservation> insertRow(
    _is.DatabaseSession session,
    AnimalObservation row, {
    _is.Transaction? transaction,
  }) async {
    return session.db.insertRow<AnimalObservation>(
      row,
      transaction: transaction,
    );
  }

  /// Upserts all [AnimalObservation]s in the list and returns the resulting rows.
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
  /// The returned [AnimalObservation]s will have their `id` fields set.
  ///
  /// This is an atomic operation, meaning that if one of the rows fails,
  /// none of the rows will be affected.
  ///
  /// If [noReturn] is set to `true`, the resulting rows are not read back from
  /// the database and an empty list is returned. This avoids the overhead of
  /// transferring and deserializing the rows when the result is not needed.
  Future<List<AnimalObservation>> upsert(
    _is.DatabaseSession session,
    List<AnimalObservation> rows, {
    required _is.ColumnSelections<AnimalObservationTable> conflictColumns,
    _is.ColumnSelections<AnimalObservationTable>? updateColumns,
    _is.WhereExpressionBuilder<AnimalObservationTable>? updateWhere,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.upsert<AnimalObservation>(
      rows,
      conflictColumns: conflictColumns(AnimalObservation.t),
      updateColumns: updateColumns?.call(AnimalObservation.t),
      updateWhere: updateWhere?.call(AnimalObservation.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Upserts a single [AnimalObservation] and returns the resulting row.
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
  /// The returned [AnimalObservation] will have its `id` field set.
  Future<AnimalObservation?> upsertRow(
    _is.DatabaseSession session,
    AnimalObservation row, {
    required _is.ColumnSelections<AnimalObservationTable> conflictColumns,
    _is.ColumnSelections<AnimalObservationTable>? updateColumns,
    _is.WhereExpressionBuilder<AnimalObservationTable>? updateWhere,
    _is.Transaction? transaction,
  }) async {
    return session.db.upsertRow<AnimalObservation>(
      row,
      conflictColumns: conflictColumns(AnimalObservation.t),
      updateColumns: updateColumns?.call(AnimalObservation.t),
      updateWhere: updateWhere?.call(AnimalObservation.t),
      transaction: transaction,
    );
  }

  /// Updates all [AnimalObservation]s in the list and returns the updated rows. If
  /// [columns] is provided, only those columns will be updated. Defaults to
  /// all columns.
  /// This is an atomic operation, meaning that if one of the rows fails to
  /// update, none of the rows will be updated.
  ///
  /// If [noReturn] is set to `true`, the updated rows are not read back from
  /// the database and an empty list is returned. This avoids the overhead of
  /// transferring and deserializing the rows when the result is not needed.
  Future<List<AnimalObservation>> update(
    _is.DatabaseSession session,
    List<AnimalObservation> rows, {
    _is.ColumnSelections<AnimalObservationTable>? columns,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.update<AnimalObservation>(
      rows,
      columns: columns?.call(AnimalObservation.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Updates a single [AnimalObservation]. The row needs to have its id set.
  /// Optionally, a list of [columns] can be provided to only update those
  /// columns. Defaults to all columns.
  Future<AnimalObservation> updateRow(
    _is.DatabaseSession session,
    AnimalObservation row, {
    _is.ColumnSelections<AnimalObservationTable>? columns,
    _is.Transaction? transaction,
  }) async {
    return session.db.updateRow<AnimalObservation>(
      row,
      columns: columns?.call(AnimalObservation.t),
      transaction: transaction,
    );
  }

  /// Updates a single [AnimalObservation] by its [id] with the specified [columnValues].
  /// Returns the updated row or null if no row with the given id exists.
  Future<AnimalObservation?> updateById(
    _is.DatabaseSession session,
    int id, {
    required _is.ColumnValueListBuilder<AnimalObservationUpdateTable>
    columnValues,
    _is.Transaction? transaction,
  }) async {
    return session.db.updateById<AnimalObservation>(
      id,
      columnValues: columnValues(AnimalObservation.t.updateTable),
      transaction: transaction,
    );
  }

  /// Updates all [AnimalObservation]s matching the [where] expression with the specified [columnValues].
  /// Returns the list of updated rows.
  ///
  /// If [noReturn] is set to `true`, the updated rows are not read back from
  /// the database and an empty list is returned. This avoids the overhead of
  /// transferring and deserializing the rows when the result is not needed.
  Future<List<AnimalObservation>> updateWhere(
    _is.DatabaseSession session, {
    required _is.ColumnValueListBuilder<AnimalObservationUpdateTable>
    columnValues,
    required _is.WhereExpressionBuilder<AnimalObservationTable> where,
    int? limit,
    int? offset,
    _is.OrderByBuilder<AnimalObservationTable>? orderBy,
    _is.OrderByListBuilder<AnimalObservationTable>? orderByList,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.updateWhere<AnimalObservation>(
      columnValues: columnValues(AnimalObservation.t.updateTable),
      where: where(AnimalObservation.t),
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(AnimalObservation.t),
      orderByList: orderByList?.call(AnimalObservation.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Deletes all [AnimalObservation]s in the list and returns the deleted rows.
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
  Future<List<AnimalObservation>> delete(
    _is.DatabaseSession session,
    List<AnimalObservation> rows, {
    _is.OrderByBuilder<AnimalObservationTable>? orderBy,
    _is.OrderByListBuilder<AnimalObservationTable>? orderByList,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.delete<AnimalObservation>(
      rows,
      orderBy: orderBy?.call(AnimalObservation.t),
      orderByList: orderByList?.call(AnimalObservation.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Deletes a single [AnimalObservation].
  Future<AnimalObservation> deleteRow(
    _is.DatabaseSession session,
    AnimalObservation row, {
    _is.Transaction? transaction,
  }) async {
    return session.db.deleteRow<AnimalObservation>(
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
  Future<List<AnimalObservation>> deleteWhere(
    _is.DatabaseSession session, {
    required _is.WhereExpressionBuilder<AnimalObservationTable> where,
    _is.OrderByBuilder<AnimalObservationTable>? orderBy,
    _is.OrderByListBuilder<AnimalObservationTable>? orderByList,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.deleteWhere<AnimalObservation>(
      where: where(AnimalObservation.t),
      orderBy: orderBy?.call(AnimalObservation.t),
      orderByList: orderByList?.call(AnimalObservation.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Counts the number of rows matching the [where] expression. If omitted,
  /// will return the count of all rows in the table.
  Future<int> count(
    _is.DatabaseSession session, {
    _is.WhereExpressionBuilder<AnimalObservationTable>? where,
    int? limit,
    _is.Transaction? transaction,
  }) async {
    return session.db.count<AnimalObservation>(
      where: where?.call(AnimalObservation.t),
      limit: limit,
      transaction: transaction,
    );
  }

  /// Acquires row-level locks on [AnimalObservation] rows matching the [where] expression.
  Future<void> lockRows(
    _is.DatabaseSession session, {
    required _is.WhereExpressionBuilder<AnimalObservationTable> where,
    required _is.LockMode lockMode,
    required _is.Transaction transaction,
    _is.LockBehavior lockBehavior = _is.LockBehavior.wait,
  }) async {
    return session.db.lockRows<AnimalObservation>(
      where: where(AnimalObservation.t),
      lockMode: lockMode,
      lockBehavior: lockBehavior,
      transaction: transaction,
    );
  }
}
