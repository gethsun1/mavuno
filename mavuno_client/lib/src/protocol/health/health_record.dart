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

abstract class HealthRecord
    implements _isc.SerializableModel, _isc.ProtocolSerialization {
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
      recordedAt: _isc.DateTimeJsonExtension.fromJson(
        jsonSerialization['recordedAt'],
      ),
      recordType: jsonSerialization['recordType'] as String,
      description: jsonSerialization['description'] as String,
      professionalName: jsonSerialization['professionalName'] as String?,
      notes: jsonSerialization['notes'] as String?,
    );
  }

  /// The database id, set if the object has been inserted into the
  /// database or if it has been fetched from the database. Otherwise,
  /// the id will be null.
  int? id;

  int animalId;

  DateTime recordedAt;

  String recordType;

  String description;

  String? professionalName;

  String? notes;

  /// Returns a shallow copy of this [HealthRecord]
  /// with some or all fields replaced by the given arguments.
  @_isc.useResult
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

  @override
  String toString() {
    return _isc.SerializationManager.encode(this);
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
  @_isc.useResult
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
