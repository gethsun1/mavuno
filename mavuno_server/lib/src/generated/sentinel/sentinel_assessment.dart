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
import '../sentinel/risk_level.dart' as _itvrxtju;

abstract class SentinelAssessment
    implements _is.TableRow<int?>, _is.ProtocolSerialization {
  SentinelAssessment._({
    this.id,
    required this.farmId,
    required this.animalId,
    required this.assessedAt,
    required this.riskScore,
    required this.riskLevel,
    required this.detectedSignals,
    required this.baselineSummary,
    required this.explanation,
    required this.recommendedAction,
    this.sourceObservationId,
  });

  factory SentinelAssessment({
    int? id,
    required int farmId,
    required int animalId,
    required DateTime assessedAt,
    required double riskScore,
    required _itvrxtju.RiskLevel riskLevel,
    required String detectedSignals,
    required String baselineSummary,
    required String explanation,
    required String recommendedAction,
    int? sourceObservationId,
  }) = _SentinelAssessmentImpl;

  factory SentinelAssessment.fromJson(Map<String, dynamic> jsonSerialization) {
    return SentinelAssessment(
      id: jsonSerialization['id'] as int?,
      farmId: jsonSerialization['farmId'] as int,
      animalId: jsonSerialization['animalId'] as int,
      assessedAt: _is.DateTimeJsonExtension.fromJson(
        jsonSerialization['assessedAt'],
      ),
      riskScore: (jsonSerialization['riskScore'] as num).toDouble(),
      riskLevel: _itvrxtju.RiskLevel.fromJson(
        (jsonSerialization['riskLevel'] as String),
      ),
      detectedSignals: jsonSerialization['detectedSignals'] as String,
      baselineSummary: jsonSerialization['baselineSummary'] as String,
      explanation: jsonSerialization['explanation'] as String,
      recommendedAction: jsonSerialization['recommendedAction'] as String,
      sourceObservationId: jsonSerialization['sourceObservationId'] as int?,
    );
  }

  static final t = SentinelAssessmentTable();

  static const db = SentinelAssessmentRepository._();

  @override
  int? id;

  int farmId;

  int animalId;

  DateTime assessedAt;

  double riskScore;

  _itvrxtju.RiskLevel riskLevel;

  String detectedSignals;

  String baselineSummary;

  String explanation;

  String recommendedAction;

  int? sourceObservationId;

  @override
  _is.Table<int?> get table => t;

  /// Returns a shallow copy of this [SentinelAssessment]
  /// with some or all fields replaced by the given arguments.
  @_is.useResult
  SentinelAssessment copyWith({
    int? id,
    int? farmId,
    int? animalId,
    DateTime? assessedAt,
    double? riskScore,
    _itvrxtju.RiskLevel? riskLevel,
    String? detectedSignals,
    String? baselineSummary,
    String? explanation,
    String? recommendedAction,
    int? sourceObservationId,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'SentinelAssessment',
      if (id != null) 'id': id,
      'farmId': farmId,
      'animalId': animalId,
      'assessedAt': assessedAt.toJson(),
      'riskScore': riskScore,
      'riskLevel': riskLevel.toJson(),
      'detectedSignals': detectedSignals,
      'baselineSummary': baselineSummary,
      'explanation': explanation,
      'recommendedAction': recommendedAction,
      if (sourceObservationId != null)
        'sourceObservationId': sourceObservationId,
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {
      '__className__': 'SentinelAssessment',
      if (id != null) 'id': id,
      'farmId': farmId,
      'animalId': animalId,
      'assessedAt': assessedAt.toJson(),
      'riskScore': riskScore,
      'riskLevel': riskLevel.toJson(),
      'detectedSignals': detectedSignals,
      'baselineSummary': baselineSummary,
      'explanation': explanation,
      'recommendedAction': recommendedAction,
      if (sourceObservationId != null)
        'sourceObservationId': sourceObservationId,
    };
  }

  static SentinelAssessmentInclude include() {
    return SentinelAssessmentInclude._();
  }

  static SentinelAssessmentIncludeList includeList({
    _is.WhereExpressionBuilder<SentinelAssessmentTable>? where,
    int? limit,
    int? offset,
    _is.OrderByBuilder<SentinelAssessmentTable>? orderBy,
    _is.OrderByListBuilder<SentinelAssessmentTable>? orderByList,
    SentinelAssessmentInclude? include,
  }) {
    return SentinelAssessmentIncludeList._(
      where: where,
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(SentinelAssessment.t),
      orderByList: orderByList?.call(SentinelAssessment.t),
      include: include,
    );
  }

  @override
  String toString() {
    return _is.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _SentinelAssessmentImpl extends SentinelAssessment {
  _SentinelAssessmentImpl({
    int? id,
    required int farmId,
    required int animalId,
    required DateTime assessedAt,
    required double riskScore,
    required _itvrxtju.RiskLevel riskLevel,
    required String detectedSignals,
    required String baselineSummary,
    required String explanation,
    required String recommendedAction,
    int? sourceObservationId,
  }) : super._(
         id: id,
         farmId: farmId,
         animalId: animalId,
         assessedAt: assessedAt,
         riskScore: riskScore,
         riskLevel: riskLevel,
         detectedSignals: detectedSignals,
         baselineSummary: baselineSummary,
         explanation: explanation,
         recommendedAction: recommendedAction,
         sourceObservationId: sourceObservationId,
       );

  /// Returns a shallow copy of this [SentinelAssessment]
  /// with some or all fields replaced by the given arguments.
  @_is.useResult
  @override
  SentinelAssessment copyWith({
    Object? id = _Undefined,
    int? farmId,
    int? animalId,
    DateTime? assessedAt,
    double? riskScore,
    _itvrxtju.RiskLevel? riskLevel,
    String? detectedSignals,
    String? baselineSummary,
    String? explanation,
    String? recommendedAction,
    Object? sourceObservationId = _Undefined,
  }) {
    return SentinelAssessment(
      id: id is int? ? id : this.id,
      farmId: farmId ?? this.farmId,
      animalId: animalId ?? this.animalId,
      assessedAt: assessedAt ?? this.assessedAt,
      riskScore: riskScore ?? this.riskScore,
      riskLevel: riskLevel ?? this.riskLevel,
      detectedSignals: detectedSignals ?? this.detectedSignals,
      baselineSummary: baselineSummary ?? this.baselineSummary,
      explanation: explanation ?? this.explanation,
      recommendedAction: recommendedAction ?? this.recommendedAction,
      sourceObservationId: sourceObservationId is int?
          ? sourceObservationId
          : this.sourceObservationId,
    );
  }
}

class SentinelAssessmentUpdateTable
    extends _is.UpdateTable<SentinelAssessmentTable> {
  SentinelAssessmentUpdateTable(super.table);

  _is.ColumnValue<int, int> farmId(int value) => _is.ColumnValue(
    table.farmId,
    value,
  );

  _is.ColumnValue<int, int> animalId(int value) => _is.ColumnValue(
    table.animalId,
    value,
  );

  _is.ColumnValue<DateTime, DateTime> assessedAt(DateTime value) =>
      _is.ColumnValue(
        table.assessedAt,
        value,
      );

  _is.ColumnValue<double, double> riskScore(double value) => _is.ColumnValue(
    table.riskScore,
    value,
  );

  _is.ColumnValue<_itvrxtju.RiskLevel, _itvrxtju.RiskLevel> riskLevel(
    _itvrxtju.RiskLevel value,
  ) => _is.ColumnValue(
    table.riskLevel,
    value,
  );

  _is.ColumnValue<String, String> detectedSignals(String value) =>
      _is.ColumnValue(
        table.detectedSignals,
        value,
      );

  _is.ColumnValue<String, String> baselineSummary(String value) =>
      _is.ColumnValue(
        table.baselineSummary,
        value,
      );

  _is.ColumnValue<String, String> explanation(String value) => _is.ColumnValue(
    table.explanation,
    value,
  );

  _is.ColumnValue<String, String> recommendedAction(String value) =>
      _is.ColumnValue(
        table.recommendedAction,
        value,
      );

  _is.ColumnValue<int, int> sourceObservationId(int? value) => _is.ColumnValue(
    table.sourceObservationId,
    value,
  );
}

class SentinelAssessmentTable extends _is.Table<int?> {
  SentinelAssessmentTable({super.tableRelation})
    : super(tableName: 'sentinel_assessment') {
    updateTable = SentinelAssessmentUpdateTable(this);
    farmId = _is.ColumnInt(
      'farmId',
      this,
    );
    animalId = _is.ColumnInt(
      'animalId',
      this,
    );
    assessedAt = _is.ColumnDateTime(
      'assessedAt',
      this,
    );
    riskScore = _is.ColumnDouble(
      'riskScore',
      this,
    );
    riskLevel = _is.ColumnEnum(
      'riskLevel',
      this,
      _is.EnumSerialization.byName,
    );
    detectedSignals = _is.ColumnString(
      'detectedSignals',
      this,
    );
    baselineSummary = _is.ColumnString(
      'baselineSummary',
      this,
    );
    explanation = _is.ColumnString(
      'explanation',
      this,
    );
    recommendedAction = _is.ColumnString(
      'recommendedAction',
      this,
    );
    sourceObservationId = _is.ColumnInt(
      'sourceObservationId',
      this,
    );
  }

  late final SentinelAssessmentUpdateTable updateTable;

  late final _is.ColumnInt farmId;

  late final _is.ColumnInt animalId;

  late final _is.ColumnDateTime assessedAt;

  late final _is.ColumnDouble riskScore;

  late final _is.ColumnEnum<_itvrxtju.RiskLevel> riskLevel;

  late final _is.ColumnString detectedSignals;

  late final _is.ColumnString baselineSummary;

  late final _is.ColumnString explanation;

  late final _is.ColumnString recommendedAction;

  late final _is.ColumnInt sourceObservationId;

  @override
  List<_is.Column> get columns => [
    id,
    farmId,
    animalId,
    assessedAt,
    riskScore,
    riskLevel,
    detectedSignals,
    baselineSummary,
    explanation,
    recommendedAction,
    sourceObservationId,
  ];
}

class SentinelAssessmentInclude extends _is.IncludeObject {
  SentinelAssessmentInclude._();

  @override
  Map<String, _is.Include?> get includes => {};

  @override
  _is.Table<int?> get table => SentinelAssessment.t;
}

class SentinelAssessmentIncludeList extends _is.IncludeList {
  SentinelAssessmentIncludeList._({
    _is.WhereExpressionBuilder<SentinelAssessmentTable>? where,
    super.limit,
    super.offset,
    super.orderBy,
    super.orderByList,
    super.include,
  }) {
    super.where = where?.call(SentinelAssessment.t);
  }

  @override
  Map<String, _is.Include?> get includes => include?.includes ?? {};

  @override
  _is.Table<int?> get table => SentinelAssessment.t;
}

class SentinelAssessmentRepository {
  const SentinelAssessmentRepository._();

  /// Returns a list of [SentinelAssessment]s matching the given query parameters.
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
  Future<List<SentinelAssessment>> find(
    _is.DatabaseSession session, {
    _is.WhereExpressionBuilder<SentinelAssessmentTable>? where,
    int? limit,
    int? offset,
    _is.OrderByBuilder<SentinelAssessmentTable>? orderBy,
    _is.OrderByListBuilder<SentinelAssessmentTable>? orderByList,
    _is.Transaction? transaction,
    _is.LockMode? lockMode,
    _is.LockBehavior? lockBehavior,
  }) async {
    return session.db.find<SentinelAssessment>(
      where: where?.call(SentinelAssessment.t),
      orderBy: orderBy?.call(SentinelAssessment.t),
      orderByList: orderByList?.call(SentinelAssessment.t),
      limit: limit,
      offset: offset,
      transaction: transaction,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Returns the first matching [SentinelAssessment] matching the given query parameters.
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
  Future<SentinelAssessment?> findFirstRow(
    _is.DatabaseSession session, {
    _is.WhereExpressionBuilder<SentinelAssessmentTable>? where,
    int? offset,
    _is.OrderByBuilder<SentinelAssessmentTable>? orderBy,
    _is.OrderByListBuilder<SentinelAssessmentTable>? orderByList,
    _is.Transaction? transaction,
    _is.LockMode? lockMode,
    _is.LockBehavior? lockBehavior,
  }) async {
    return session.db.findFirstRow<SentinelAssessment>(
      where: where?.call(SentinelAssessment.t),
      orderBy: orderBy?.call(SentinelAssessment.t),
      orderByList: orderByList?.call(SentinelAssessment.t),
      offset: offset,
      transaction: transaction,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Finds a single [SentinelAssessment] by its [id] or null if no such row exists.
  Future<SentinelAssessment?> findById(
    _is.DatabaseSession session,
    int id, {
    _is.Transaction? transaction,
    _is.LockMode? lockMode,
    _is.LockBehavior? lockBehavior,
  }) async {
    return session.db.findById<SentinelAssessment>(
      id,
      transaction: transaction,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Inserts all [SentinelAssessment]s in the list and returns the inserted rows.
  ///
  /// The returned [SentinelAssessment]s will have their `id` fields set.
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
  Future<List<SentinelAssessment>> insert(
    _is.DatabaseSession session,
    List<SentinelAssessment> rows, {
    _is.Transaction? transaction,
    bool ignoreConflicts = false,
    bool noReturn = false,
  }) async {
    return session.db.insert<SentinelAssessment>(
      rows,
      transaction: transaction,
      ignoreConflicts: ignoreConflicts,
      noReturn: noReturn,
    );
  }

  /// Inserts a single [SentinelAssessment] and returns the inserted row.
  ///
  /// The returned [SentinelAssessment] will have its `id` field set.
  Future<SentinelAssessment> insertRow(
    _is.DatabaseSession session,
    SentinelAssessment row, {
    _is.Transaction? transaction,
  }) async {
    return session.db.insertRow<SentinelAssessment>(
      row,
      transaction: transaction,
    );
  }

  /// Upserts all [SentinelAssessment]s in the list and returns the resulting rows.
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
  /// The returned [SentinelAssessment]s will have their `id` fields set.
  ///
  /// This is an atomic operation, meaning that if one of the rows fails,
  /// none of the rows will be affected.
  ///
  /// If [noReturn] is set to `true`, the resulting rows are not read back from
  /// the database and an empty list is returned. This avoids the overhead of
  /// transferring and deserializing the rows when the result is not needed.
  Future<List<SentinelAssessment>> upsert(
    _is.DatabaseSession session,
    List<SentinelAssessment> rows, {
    required _is.ColumnSelections<SentinelAssessmentTable> conflictColumns,
    _is.ColumnSelections<SentinelAssessmentTable>? updateColumns,
    _is.WhereExpressionBuilder<SentinelAssessmentTable>? updateWhere,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.upsert<SentinelAssessment>(
      rows,
      conflictColumns: conflictColumns(SentinelAssessment.t),
      updateColumns: updateColumns?.call(SentinelAssessment.t),
      updateWhere: updateWhere?.call(SentinelAssessment.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Upserts a single [SentinelAssessment] and returns the resulting row.
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
  /// The returned [SentinelAssessment] will have its `id` field set.
  Future<SentinelAssessment?> upsertRow(
    _is.DatabaseSession session,
    SentinelAssessment row, {
    required _is.ColumnSelections<SentinelAssessmentTable> conflictColumns,
    _is.ColumnSelections<SentinelAssessmentTable>? updateColumns,
    _is.WhereExpressionBuilder<SentinelAssessmentTable>? updateWhere,
    _is.Transaction? transaction,
  }) async {
    return session.db.upsertRow<SentinelAssessment>(
      row,
      conflictColumns: conflictColumns(SentinelAssessment.t),
      updateColumns: updateColumns?.call(SentinelAssessment.t),
      updateWhere: updateWhere?.call(SentinelAssessment.t),
      transaction: transaction,
    );
  }

  /// Updates all [SentinelAssessment]s in the list and returns the updated rows. If
  /// [columns] is provided, only those columns will be updated. Defaults to
  /// all columns.
  /// This is an atomic operation, meaning that if one of the rows fails to
  /// update, none of the rows will be updated.
  ///
  /// If [noReturn] is set to `true`, the updated rows are not read back from
  /// the database and an empty list is returned. This avoids the overhead of
  /// transferring and deserializing the rows when the result is not needed.
  Future<List<SentinelAssessment>> update(
    _is.DatabaseSession session,
    List<SentinelAssessment> rows, {
    _is.ColumnSelections<SentinelAssessmentTable>? columns,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.update<SentinelAssessment>(
      rows,
      columns: columns?.call(SentinelAssessment.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Updates a single [SentinelAssessment]. The row needs to have its id set.
  /// Optionally, a list of [columns] can be provided to only update those
  /// columns. Defaults to all columns.
  Future<SentinelAssessment> updateRow(
    _is.DatabaseSession session,
    SentinelAssessment row, {
    _is.ColumnSelections<SentinelAssessmentTable>? columns,
    _is.Transaction? transaction,
  }) async {
    return session.db.updateRow<SentinelAssessment>(
      row,
      columns: columns?.call(SentinelAssessment.t),
      transaction: transaction,
    );
  }

  /// Updates a single [SentinelAssessment] by its [id] with the specified [columnValues].
  /// Returns the updated row or null if no row with the given id exists.
  Future<SentinelAssessment?> updateById(
    _is.DatabaseSession session,
    int id, {
    required _is.ColumnValueListBuilder<SentinelAssessmentUpdateTable>
    columnValues,
    _is.Transaction? transaction,
  }) async {
    return session.db.updateById<SentinelAssessment>(
      id,
      columnValues: columnValues(SentinelAssessment.t.updateTable),
      transaction: transaction,
    );
  }

  /// Updates all [SentinelAssessment]s matching the [where] expression with the specified [columnValues].
  /// Returns the list of updated rows.
  ///
  /// If [noReturn] is set to `true`, the updated rows are not read back from
  /// the database and an empty list is returned. This avoids the overhead of
  /// transferring and deserializing the rows when the result is not needed.
  Future<List<SentinelAssessment>> updateWhere(
    _is.DatabaseSession session, {
    required _is.ColumnValueListBuilder<SentinelAssessmentUpdateTable>
    columnValues,
    required _is.WhereExpressionBuilder<SentinelAssessmentTable> where,
    int? limit,
    int? offset,
    _is.OrderByBuilder<SentinelAssessmentTable>? orderBy,
    _is.OrderByListBuilder<SentinelAssessmentTable>? orderByList,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.updateWhere<SentinelAssessment>(
      columnValues: columnValues(SentinelAssessment.t.updateTable),
      where: where(SentinelAssessment.t),
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(SentinelAssessment.t),
      orderByList: orderByList?.call(SentinelAssessment.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Deletes all [SentinelAssessment]s in the list and returns the deleted rows.
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
  Future<List<SentinelAssessment>> delete(
    _is.DatabaseSession session,
    List<SentinelAssessment> rows, {
    _is.OrderByBuilder<SentinelAssessmentTable>? orderBy,
    _is.OrderByListBuilder<SentinelAssessmentTable>? orderByList,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.delete<SentinelAssessment>(
      rows,
      orderBy: orderBy?.call(SentinelAssessment.t),
      orderByList: orderByList?.call(SentinelAssessment.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Deletes a single [SentinelAssessment].
  Future<SentinelAssessment> deleteRow(
    _is.DatabaseSession session,
    SentinelAssessment row, {
    _is.Transaction? transaction,
  }) async {
    return session.db.deleteRow<SentinelAssessment>(
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
  Future<List<SentinelAssessment>> deleteWhere(
    _is.DatabaseSession session, {
    required _is.WhereExpressionBuilder<SentinelAssessmentTable> where,
    _is.OrderByBuilder<SentinelAssessmentTable>? orderBy,
    _is.OrderByListBuilder<SentinelAssessmentTable>? orderByList,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.deleteWhere<SentinelAssessment>(
      where: where(SentinelAssessment.t),
      orderBy: orderBy?.call(SentinelAssessment.t),
      orderByList: orderByList?.call(SentinelAssessment.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Counts the number of rows matching the [where] expression. If omitted,
  /// will return the count of all rows in the table.
  Future<int> count(
    _is.DatabaseSession session, {
    _is.WhereExpressionBuilder<SentinelAssessmentTable>? where,
    int? limit,
    _is.Transaction? transaction,
  }) async {
    return session.db.count<SentinelAssessment>(
      where: where?.call(SentinelAssessment.t),
      limit: limit,
      transaction: transaction,
    );
  }

  /// Acquires row-level locks on [SentinelAssessment] rows matching the [where] expression.
  Future<void> lockRows(
    _is.DatabaseSession session, {
    required _is.WhereExpressionBuilder<SentinelAssessmentTable> where,
    required _is.LockMode lockMode,
    required _is.Transaction transaction,
    _is.LockBehavior lockBehavior = _is.LockBehavior.wait,
  }) async {
    return session.db.lockRows<SentinelAssessment>(
      where: where(SentinelAssessment.t),
      lockMode: lockMode,
      lockBehavior: lockBehavior,
      transaction: transaction,
    );
  }
}
