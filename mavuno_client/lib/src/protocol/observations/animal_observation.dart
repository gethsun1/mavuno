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

abstract class AnimalObservation
    implements _isc.SerializableModel, _isc.ProtocolSerialization {
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
      recordedAt: _isc.DateTimeJsonExtension.fromJson(
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

  /// The database id, set if the object has been inserted into the
  /// database or if it has been fetched from the database. Otherwise,
  /// the id will be null.
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

  /// Returns a shallow copy of this [AnimalObservation]
  /// with some or all fields replaced by the given arguments.
  @_isc.useResult
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

  @override
  String toString() {
    return _isc.SerializationManager.encode(this);
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
  @_isc.useResult
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
