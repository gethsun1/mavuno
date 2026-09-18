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

abstract class ProductionRecord
    implements _isc.SerializableModel, _isc.ProtocolSerialization {
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
      recordedAt: _isc.DateTimeJsonExtension.fromJson(
        jsonSerialization['recordedAt'],
      ),
      metricType: jsonSerialization['metricType'] as String,
      value: (jsonSerialization['value'] as num).toDouble(),
      unit: jsonSerialization['unit'] as String,
      notes: jsonSerialization['notes'] as String?,
    );
  }

  /// The database id, set if the object has been inserted into the
  /// database or if it has been fetched from the database. Otherwise,
  /// the id will be null.
  int? id;

  int animalId;

  DateTime recordedAt;

  String metricType;

  double value;

  String unit;

  String? notes;

  /// Returns a shallow copy of this [ProductionRecord]
  /// with some or all fields replaced by the given arguments.
  @_isc.useResult
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

  @override
  String toString() {
    return _isc.SerializationManager.encode(this);
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
  @_isc.useResult
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
