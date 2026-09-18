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
import '../sentinel/risk_level.dart' as _itvrxtju;

abstract class SentinelAssessment
    implements _isc.SerializableModel, _isc.ProtocolSerialization {
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
      assessedAt: _isc.DateTimeJsonExtension.fromJson(
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

  /// The database id, set if the object has been inserted into the
  /// database or if it has been fetched from the database. Otherwise,
  /// the id will be null.
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

  /// Returns a shallow copy of this [SentinelAssessment]
  /// with some or all fields replaced by the given arguments.
  @_isc.useResult
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

  @override
  String toString() {
    return _isc.SerializationManager.encode(this);
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
  @_isc.useResult
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
