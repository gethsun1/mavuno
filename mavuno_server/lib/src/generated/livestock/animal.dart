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
import '../livestock/animal_sex.dart' as _izhfx15f;
import '../livestock/animal_species.dart' as _isvmx3bd;
import '../livestock/animal_status.dart' as _i63lxxwv;

abstract class Animal implements _is.TableRow<int?>, _is.ProtocolSerialization {
  Animal._({
    this.id,
    required this.farmId,
    required this.tag,
    this.name,
    required this.species,
    this.breed,
    required this.sex,
    this.dateOfBirth,
    required this.status,
    this.notes,
    required this.createdAt,
    required this.updatedAt,
  });

  factory Animal({
    int? id,
    required int farmId,
    required String tag,
    String? name,
    required _isvmx3bd.AnimalSpecies species,
    String? breed,
    required _izhfx15f.AnimalSex sex,
    DateTime? dateOfBirth,
    required _i63lxxwv.AnimalStatus status,
    String? notes,
    required DateTime createdAt,
    required DateTime updatedAt,
  }) = _AnimalImpl;

  factory Animal.fromJson(Map<String, dynamic> jsonSerialization) {
    return Animal(
      id: jsonSerialization['id'] as int?,
      farmId: jsonSerialization['farmId'] as int,
      tag: jsonSerialization['tag'] as String,
      name: jsonSerialization['name'] as String?,
      species: _isvmx3bd.AnimalSpecies.fromJson(
        (jsonSerialization['species'] as String),
      ),
      breed: jsonSerialization['breed'] as String?,
      sex: _izhfx15f.AnimalSex.fromJson((jsonSerialization['sex'] as String)),
      dateOfBirth: jsonSerialization['dateOfBirth'] == null
          ? null
          : _is.DateTimeJsonExtension.fromJson(
              jsonSerialization['dateOfBirth'],
            ),
      status: _i63lxxwv.AnimalStatus.fromJson(
        (jsonSerialization['status'] as String),
      ),
      notes: jsonSerialization['notes'] as String?,
      createdAt: _is.DateTimeJsonExtension.fromJson(
        jsonSerialization['createdAt'],
      ),
      updatedAt: _is.DateTimeJsonExtension.fromJson(
        jsonSerialization['updatedAt'],
      ),
    );
  }

  static final t = AnimalTable();

  static const db = AnimalRepository._();

  @override
  int? id;

  int farmId;

  String tag;

  String? name;

  _isvmx3bd.AnimalSpecies species;

  String? breed;

  _izhfx15f.AnimalSex sex;

  DateTime? dateOfBirth;

  _i63lxxwv.AnimalStatus status;

  String? notes;

  DateTime createdAt;

  DateTime updatedAt;

  @override
  _is.Table<int?> get table => t;

  /// Returns a shallow copy of this [Animal]
  /// with some or all fields replaced by the given arguments.
  @_is.useResult
  Animal copyWith({
    int? id,
    int? farmId,
    String? tag,
    String? name,
    _isvmx3bd.AnimalSpecies? species,
    String? breed,
    _izhfx15f.AnimalSex? sex,
    DateTime? dateOfBirth,
    _i63lxxwv.AnimalStatus? status,
    String? notes,
    DateTime? createdAt,
    DateTime? updatedAt,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'Animal',
      if (id != null) 'id': id,
      'farmId': farmId,
      'tag': tag,
      if (name != null) 'name': name,
      'species': species.toJson(),
      if (breed != null) 'breed': breed,
      'sex': sex.toJson(),
      if (dateOfBirth != null) 'dateOfBirth': dateOfBirth?.toJson(),
      'status': status.toJson(),
      if (notes != null) 'notes': notes,
      'createdAt': createdAt.toJson(),
      'updatedAt': updatedAt.toJson(),
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {
      '__className__': 'Animal',
      if (id != null) 'id': id,
      'farmId': farmId,
      'tag': tag,
      if (name != null) 'name': name,
      'species': species.toJson(),
      if (breed != null) 'breed': breed,
      'sex': sex.toJson(),
      if (dateOfBirth != null) 'dateOfBirth': dateOfBirth?.toJson(),
      'status': status.toJson(),
      if (notes != null) 'notes': notes,
      'createdAt': createdAt.toJson(),
      'updatedAt': updatedAt.toJson(),
    };
  }

  static AnimalInclude include() {
    return AnimalInclude._();
  }

  static AnimalIncludeList includeList({
    _is.WhereExpressionBuilder<AnimalTable>? where,
    int? limit,
    int? offset,
    _is.OrderByBuilder<AnimalTable>? orderBy,
    _is.OrderByListBuilder<AnimalTable>? orderByList,
    AnimalInclude? include,
  }) {
    return AnimalIncludeList._(
      where: where,
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(Animal.t),
      orderByList: orderByList?.call(Animal.t),
      include: include,
    );
  }

  @override
  String toString() {
    return _is.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _AnimalImpl extends Animal {
  _AnimalImpl({
    int? id,
    required int farmId,
    required String tag,
    String? name,
    required _isvmx3bd.AnimalSpecies species,
    String? breed,
    required _izhfx15f.AnimalSex sex,
    DateTime? dateOfBirth,
    required _i63lxxwv.AnimalStatus status,
    String? notes,
    required DateTime createdAt,
    required DateTime updatedAt,
  }) : super._(
         id: id,
         farmId: farmId,
         tag: tag,
         name: name,
         species: species,
         breed: breed,
         sex: sex,
         dateOfBirth: dateOfBirth,
         status: status,
         notes: notes,
         createdAt: createdAt,
         updatedAt: updatedAt,
       );

  /// Returns a shallow copy of this [Animal]
  /// with some or all fields replaced by the given arguments.
  @_is.useResult
  @override
  Animal copyWith({
    Object? id = _Undefined,
    int? farmId,
    String? tag,
    Object? name = _Undefined,
    _isvmx3bd.AnimalSpecies? species,
    Object? breed = _Undefined,
    _izhfx15f.AnimalSex? sex,
    Object? dateOfBirth = _Undefined,
    _i63lxxwv.AnimalStatus? status,
    Object? notes = _Undefined,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) {
    return Animal(
      id: id is int? ? id : this.id,
      farmId: farmId ?? this.farmId,
      tag: tag ?? this.tag,
      name: name is String? ? name : this.name,
      species: species ?? this.species,
      breed: breed is String? ? breed : this.breed,
      sex: sex ?? this.sex,
      dateOfBirth: dateOfBirth is DateTime? ? dateOfBirth : this.dateOfBirth,
      status: status ?? this.status,
      notes: notes is String? ? notes : this.notes,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }
}

class AnimalUpdateTable extends _is.UpdateTable<AnimalTable> {
  AnimalUpdateTable(super.table);

  _is.ColumnValue<int, int> farmId(int value) => _is.ColumnValue(
    table.farmId,
    value,
  );

  _is.ColumnValue<String, String> tag(String value) => _is.ColumnValue(
    table.tag,
    value,
  );

  _is.ColumnValue<String, String> name(String? value) => _is.ColumnValue(
    table.name,
    value,
  );

  _is.ColumnValue<_isvmx3bd.AnimalSpecies, _isvmx3bd.AnimalSpecies> species(
    _isvmx3bd.AnimalSpecies value,
  ) => _is.ColumnValue(
    table.species,
    value,
  );

  _is.ColumnValue<String, String> breed(String? value) => _is.ColumnValue(
    table.breed,
    value,
  );

  _is.ColumnValue<_izhfx15f.AnimalSex, _izhfx15f.AnimalSex> sex(
    _izhfx15f.AnimalSex value,
  ) => _is.ColumnValue(
    table.sex,
    value,
  );

  _is.ColumnValue<DateTime, DateTime> dateOfBirth(DateTime? value) =>
      _is.ColumnValue(
        table.dateOfBirth,
        value,
      );

  _is.ColumnValue<_i63lxxwv.AnimalStatus, _i63lxxwv.AnimalStatus> status(
    _i63lxxwv.AnimalStatus value,
  ) => _is.ColumnValue(
    table.status,
    value,
  );

  _is.ColumnValue<String, String> notes(String? value) => _is.ColumnValue(
    table.notes,
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

class AnimalTable extends _is.Table<int?> {
  AnimalTable({super.tableRelation}) : super(tableName: 'animal') {
    updateTable = AnimalUpdateTable(this);
    farmId = _is.ColumnInt(
      'farmId',
      this,
    );
    tag = _is.ColumnString(
      'tag',
      this,
    );
    name = _is.ColumnString(
      'name',
      this,
    );
    species = _is.ColumnEnum(
      'species',
      this,
      _is.EnumSerialization.byName,
    );
    breed = _is.ColumnString(
      'breed',
      this,
    );
    sex = _is.ColumnEnum(
      'sex',
      this,
      _is.EnumSerialization.byName,
    );
    dateOfBirth = _is.ColumnDateTime(
      'dateOfBirth',
      this,
    );
    status = _is.ColumnEnum(
      'status',
      this,
      _is.EnumSerialization.byName,
    );
    notes = _is.ColumnString(
      'notes',
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

  late final AnimalUpdateTable updateTable;

  late final _is.ColumnInt farmId;

  late final _is.ColumnString tag;

  late final _is.ColumnString name;

  late final _is.ColumnEnum<_isvmx3bd.AnimalSpecies> species;

  late final _is.ColumnString breed;

  late final _is.ColumnEnum<_izhfx15f.AnimalSex> sex;

  late final _is.ColumnDateTime dateOfBirth;

  late final _is.ColumnEnum<_i63lxxwv.AnimalStatus> status;

  late final _is.ColumnString notes;

  late final _is.ColumnDateTime createdAt;

  late final _is.ColumnDateTime updatedAt;

  @override
  List<_is.Column> get columns => [
    id,
    farmId,
    tag,
    name,
    species,
    breed,
    sex,
    dateOfBirth,
    status,
    notes,
    createdAt,
    updatedAt,
  ];
}

class AnimalInclude extends _is.IncludeObject {
  AnimalInclude._();

  @override
  Map<String, _is.Include?> get includes => {};

  @override
  _is.Table<int?> get table => Animal.t;
}

class AnimalIncludeList extends _is.IncludeList {
  AnimalIncludeList._({
    _is.WhereExpressionBuilder<AnimalTable>? where,
    super.limit,
    super.offset,
    super.orderBy,
    super.orderByList,
    super.include,
  }) {
    super.where = where?.call(Animal.t);
  }

  @override
  Map<String, _is.Include?> get includes => include?.includes ?? {};

  @override
  _is.Table<int?> get table => Animal.t;
}

class AnimalRepository {
  const AnimalRepository._();

  /// Returns a list of [Animal]s matching the given query parameters.
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
  Future<List<Animal>> find(
    _is.DatabaseSession session, {
    _is.WhereExpressionBuilder<AnimalTable>? where,
    int? limit,
    int? offset,
    _is.OrderByBuilder<AnimalTable>? orderBy,
    _is.OrderByListBuilder<AnimalTable>? orderByList,
    _is.Transaction? transaction,
    _is.LockMode? lockMode,
    _is.LockBehavior? lockBehavior,
  }) async {
    return session.db.find<Animal>(
      where: where?.call(Animal.t),
      orderBy: orderBy?.call(Animal.t),
      orderByList: orderByList?.call(Animal.t),
      limit: limit,
      offset: offset,
      transaction: transaction,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Returns the first matching [Animal] matching the given query parameters.
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
  Future<Animal?> findFirstRow(
    _is.DatabaseSession session, {
    _is.WhereExpressionBuilder<AnimalTable>? where,
    int? offset,
    _is.OrderByBuilder<AnimalTable>? orderBy,
    _is.OrderByListBuilder<AnimalTable>? orderByList,
    _is.Transaction? transaction,
    _is.LockMode? lockMode,
    _is.LockBehavior? lockBehavior,
  }) async {
    return session.db.findFirstRow<Animal>(
      where: where?.call(Animal.t),
      orderBy: orderBy?.call(Animal.t),
      orderByList: orderByList?.call(Animal.t),
      offset: offset,
      transaction: transaction,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Finds a single [Animal] by its [id] or null if no such row exists.
  Future<Animal?> findById(
    _is.DatabaseSession session,
    int id, {
    _is.Transaction? transaction,
    _is.LockMode? lockMode,
    _is.LockBehavior? lockBehavior,
  }) async {
    return session.db.findById<Animal>(
      id,
      transaction: transaction,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Inserts all [Animal]s in the list and returns the inserted rows.
  ///
  /// The returned [Animal]s will have their `id` fields set.
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
  Future<List<Animal>> insert(
    _is.DatabaseSession session,
    List<Animal> rows, {
    _is.Transaction? transaction,
    bool ignoreConflicts = false,
    bool noReturn = false,
  }) async {
    return session.db.insert<Animal>(
      rows,
      transaction: transaction,
      ignoreConflicts: ignoreConflicts,
      noReturn: noReturn,
    );
  }

  /// Inserts a single [Animal] and returns the inserted row.
  ///
  /// The returned [Animal] will have its `id` field set.
  Future<Animal> insertRow(
    _is.DatabaseSession session,
    Animal row, {
    _is.Transaction? transaction,
  }) async {
    return session.db.insertRow<Animal>(
      row,
      transaction: transaction,
    );
  }

  /// Upserts all [Animal]s in the list and returns the resulting rows.
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
  /// The returned [Animal]s will have their `id` fields set.
  ///
  /// This is an atomic operation, meaning that if one of the rows fails,
  /// none of the rows will be affected.
  ///
  /// If [noReturn] is set to `true`, the resulting rows are not read back from
  /// the database and an empty list is returned. This avoids the overhead of
  /// transferring and deserializing the rows when the result is not needed.
  Future<List<Animal>> upsert(
    _is.DatabaseSession session,
    List<Animal> rows, {
    required _is.ColumnSelections<AnimalTable> conflictColumns,
    _is.ColumnSelections<AnimalTable>? updateColumns,
    _is.WhereExpressionBuilder<AnimalTable>? updateWhere,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.upsert<Animal>(
      rows,
      conflictColumns: conflictColumns(Animal.t),
      updateColumns: updateColumns?.call(Animal.t),
      updateWhere: updateWhere?.call(Animal.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Upserts a single [Animal] and returns the resulting row.
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
  /// The returned [Animal] will have its `id` field set.
  Future<Animal?> upsertRow(
    _is.DatabaseSession session,
    Animal row, {
    required _is.ColumnSelections<AnimalTable> conflictColumns,
    _is.ColumnSelections<AnimalTable>? updateColumns,
    _is.WhereExpressionBuilder<AnimalTable>? updateWhere,
    _is.Transaction? transaction,
  }) async {
    return session.db.upsertRow<Animal>(
      row,
      conflictColumns: conflictColumns(Animal.t),
      updateColumns: updateColumns?.call(Animal.t),
      updateWhere: updateWhere?.call(Animal.t),
      transaction: transaction,
    );
  }

  /// Updates all [Animal]s in the list and returns the updated rows. If
  /// [columns] is provided, only those columns will be updated. Defaults to
  /// all columns.
  /// This is an atomic operation, meaning that if one of the rows fails to
  /// update, none of the rows will be updated.
  ///
  /// If [noReturn] is set to `true`, the updated rows are not read back from
  /// the database and an empty list is returned. This avoids the overhead of
  /// transferring and deserializing the rows when the result is not needed.
  Future<List<Animal>> update(
    _is.DatabaseSession session,
    List<Animal> rows, {
    _is.ColumnSelections<AnimalTable>? columns,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.update<Animal>(
      rows,
      columns: columns?.call(Animal.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Updates a single [Animal]. The row needs to have its id set.
  /// Optionally, a list of [columns] can be provided to only update those
  /// columns. Defaults to all columns.
  Future<Animal> updateRow(
    _is.DatabaseSession session,
    Animal row, {
    _is.ColumnSelections<AnimalTable>? columns,
    _is.Transaction? transaction,
  }) async {
    return session.db.updateRow<Animal>(
      row,
      columns: columns?.call(Animal.t),
      transaction: transaction,
    );
  }

  /// Updates a single [Animal] by its [id] with the specified [columnValues].
  /// Returns the updated row or null if no row with the given id exists.
  Future<Animal?> updateById(
    _is.DatabaseSession session,
    int id, {
    required _is.ColumnValueListBuilder<AnimalUpdateTable> columnValues,
    _is.Transaction? transaction,
  }) async {
    return session.db.updateById<Animal>(
      id,
      columnValues: columnValues(Animal.t.updateTable),
      transaction: transaction,
    );
  }

  /// Updates all [Animal]s matching the [where] expression with the specified [columnValues].
  /// Returns the list of updated rows.
  ///
  /// If [noReturn] is set to `true`, the updated rows are not read back from
  /// the database and an empty list is returned. This avoids the overhead of
  /// transferring and deserializing the rows when the result is not needed.
  Future<List<Animal>> updateWhere(
    _is.DatabaseSession session, {
    required _is.ColumnValueListBuilder<AnimalUpdateTable> columnValues,
    required _is.WhereExpressionBuilder<AnimalTable> where,
    int? limit,
    int? offset,
    _is.OrderByBuilder<AnimalTable>? orderBy,
    _is.OrderByListBuilder<AnimalTable>? orderByList,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.updateWhere<Animal>(
      columnValues: columnValues(Animal.t.updateTable),
      where: where(Animal.t),
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(Animal.t),
      orderByList: orderByList?.call(Animal.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Deletes all [Animal]s in the list and returns the deleted rows.
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
  Future<List<Animal>> delete(
    _is.DatabaseSession session,
    List<Animal> rows, {
    _is.OrderByBuilder<AnimalTable>? orderBy,
    _is.OrderByListBuilder<AnimalTable>? orderByList,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.delete<Animal>(
      rows,
      orderBy: orderBy?.call(Animal.t),
      orderByList: orderByList?.call(Animal.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Deletes a single [Animal].
  Future<Animal> deleteRow(
    _is.DatabaseSession session,
    Animal row, {
    _is.Transaction? transaction,
  }) async {
    return session.db.deleteRow<Animal>(
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
  Future<List<Animal>> deleteWhere(
    _is.DatabaseSession session, {
    required _is.WhereExpressionBuilder<AnimalTable> where,
    _is.OrderByBuilder<AnimalTable>? orderBy,
    _is.OrderByListBuilder<AnimalTable>? orderByList,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.deleteWhere<Animal>(
      where: where(Animal.t),
      orderBy: orderBy?.call(Animal.t),
      orderByList: orderByList?.call(Animal.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Counts the number of rows matching the [where] expression. If omitted,
  /// will return the count of all rows in the table.
  Future<int> count(
    _is.DatabaseSession session, {
    _is.WhereExpressionBuilder<AnimalTable>? where,
    int? limit,
    _is.Transaction? transaction,
  }) async {
    return session.db.count<Animal>(
      where: where?.call(Animal.t),
      limit: limit,
      transaction: transaction,
    );
  }

  /// Acquires row-level locks on [Animal] rows matching the [where] expression.
  Future<void> lockRows(
    _is.DatabaseSession session, {
    required _is.WhereExpressionBuilder<AnimalTable> where,
    required _is.LockMode lockMode,
    required _is.Transaction transaction,
    _is.LockBehavior lockBehavior = _is.LockBehavior.wait,
  }) async {
    return session.db.lockRows<Animal>(
      where: where(Animal.t),
      lockMode: lockMode,
      lockBehavior: lockBehavior,
      transaction: transaction,
    );
  }
}
