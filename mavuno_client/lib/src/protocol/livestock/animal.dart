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
import 'package:serverpod_client/serverpod_client.dart' as _isc;
import '../livestock/animal_sex.dart' as _izhfx15f;
import '../livestock/animal_species.dart' as _isvmx3bd;
import '../livestock/animal_status.dart' as _i63lxxwv;

abstract class Animal
    implements _isc.SerializableModel, _isc.ProtocolSerialization {
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
          : _isc.DateTimeJsonExtension.fromJson(
              jsonSerialization['dateOfBirth'],
            ),
      status: _i63lxxwv.AnimalStatus.fromJson(
        (jsonSerialization['status'] as String),
      ),
      notes: jsonSerialization['notes'] as String?,
      createdAt: _isc.DateTimeJsonExtension.fromJson(
        jsonSerialization['createdAt'],
      ),
      updatedAt: _isc.DateTimeJsonExtension.fromJson(
        jsonSerialization['updatedAt'],
      ),
    );
  }

  /// The database id, set if the object has been inserted into the
  /// database or if it has been fetched from the database. Otherwise,
  /// the id will be null.
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

  /// Returns a shallow copy of this [Animal]
  /// with some or all fields replaced by the given arguments.
  @_isc.useResult
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

  @override
  String toString() {
    return _isc.SerializationManager.encode(this);
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
  @_isc.useResult
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
