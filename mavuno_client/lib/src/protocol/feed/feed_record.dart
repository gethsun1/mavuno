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

abstract class FeedRecord
    implements _isc.SerializableModel, _isc.ProtocolSerialization {
  FeedRecord._({
    this.id,
    required this.farmId,
    this.animalId,
    required this.recordedAt,
    required this.feedType,
    required this.quantity,
    required this.unit,
    this.notes,
  });

  factory FeedRecord({
    int? id,
    required int farmId,
    int? animalId,
    required DateTime recordedAt,
    required String feedType,
    required double quantity,
    required String unit,
    String? notes,
  }) = _FeedRecordImpl;

  factory FeedRecord.fromJson(Map<String, dynamic> jsonSerialization) {
    return FeedRecord(
      id: jsonSerialization['id'] as int?,
      farmId: jsonSerialization['farmId'] as int,
      animalId: jsonSerialization['animalId'] as int?,
      recordedAt: _isc.DateTimeJsonExtension.fromJson(
        jsonSerialization['recordedAt'],
      ),
      feedType: jsonSerialization['feedType'] as String,
      quantity: (jsonSerialization['quantity'] as num).toDouble(),
      unit: jsonSerialization['unit'] as String,
      notes: jsonSerialization['notes'] as String?,
    );
  }

  /// The database id, set if the object has been inserted into the
  /// database or if it has been fetched from the database. Otherwise,
  /// the id will be null.
  int? id;

  int farmId;

  int? animalId;

  DateTime recordedAt;

  String feedType;

  double quantity;

  String unit;

  String? notes;

  /// Returns a shallow copy of this [FeedRecord]
  /// with some or all fields replaced by the given arguments.
  @_isc.useResult
  FeedRecord copyWith({
    int? id,
    int? farmId,
    int? animalId,
    DateTime? recordedAt,
    String? feedType,
    double? quantity,
    String? unit,
    String? notes,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'FeedRecord',
      if (id != null) 'id': id,
      'farmId': farmId,
      if (animalId != null) 'animalId': animalId,
      'recordedAt': recordedAt.toJson(),
      'feedType': feedType,
      'quantity': quantity,
      'unit': unit,
      if (notes != null) 'notes': notes,
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {
      '__className__': 'FeedRecord',
      if (id != null) 'id': id,
      'farmId': farmId,
      if (animalId != null) 'animalId': animalId,
      'recordedAt': recordedAt.toJson(),
      'feedType': feedType,
      'quantity': quantity,
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

class _FeedRecordImpl extends FeedRecord {
  _FeedRecordImpl({
    int? id,
    required int farmId,
    int? animalId,
    required DateTime recordedAt,
    required String feedType,
    required double quantity,
    required String unit,
    String? notes,
  }) : super._(
         id: id,
         farmId: farmId,
         animalId: animalId,
         recordedAt: recordedAt,
         feedType: feedType,
         quantity: quantity,
         unit: unit,
         notes: notes,
       );

  /// Returns a shallow copy of this [FeedRecord]
  /// with some or all fields replaced by the given arguments.
  @_isc.useResult
  @override
  FeedRecord copyWith({
    Object? id = _Undefined,
    int? farmId,
    Object? animalId = _Undefined,
    DateTime? recordedAt,
    String? feedType,
    double? quantity,
    String? unit,
    Object? notes = _Undefined,
  }) {
    return FeedRecord(
      id: id is int? ? id : this.id,
      farmId: farmId ?? this.farmId,
      animalId: animalId is int? ? animalId : this.animalId,
      recordedAt: recordedAt ?? this.recordedAt,
      feedType: feedType ?? this.feedType,
      quantity: quantity ?? this.quantity,
      unit: unit ?? this.unit,
      notes: notes is String? ? notes : this.notes,
    );
  }
}
