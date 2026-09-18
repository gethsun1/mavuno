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

abstract class Farm
    implements _isc.SerializableModel, _isc.ProtocolSerialization {
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

  String ownerId;

  String name;

  String? location;

  String? farmType;

  String? description;

  DateTime createdAt;

  DateTime updatedAt;

  /// Returns a shallow copy of this [Farm]
  /// with some or all fields replaced by the given arguments.
  @_isc.useResult
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

  @override
  String toString() {
    return _isc.SerializationManager.encode(this);
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
  @_isc.useResult
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
