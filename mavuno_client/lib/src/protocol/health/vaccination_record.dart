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

abstract class VaccinationRecord
    implements _isc.SerializableModel, _isc.ProtocolSerialization {
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
      administeredAt: _isc.DateTimeJsonExtension.fromJson(
        jsonSerialization['administeredAt'],
      ),
      nextDueAt: jsonSerialization['nextDueAt'] == null
          ? null
          : _isc.DateTimeJsonExtension.fromJson(jsonSerialization['nextDueAt']),
      provider: jsonSerialization['provider'] as String?,
      notes: jsonSerialization['notes'] as String?,
    );
  }

  /// The database id, set if the object has been inserted into the
  /// database or if it has been fetched from the database. Otherwise,
  /// the id will be null.
  int? id;

  int animalId;

  String vaccination;

  DateTime administeredAt;

  DateTime? nextDueAt;

  String? provider;

  String? notes;

  /// Returns a shallow copy of this [VaccinationRecord]
  /// with some or all fields replaced by the given arguments.
  @_isc.useResult
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

  @override
  String toString() {
    return _isc.SerializationManager.encode(this);
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
  @_isc.useResult
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
