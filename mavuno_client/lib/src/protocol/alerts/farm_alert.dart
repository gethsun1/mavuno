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
import '../alerts/alert_severity.dart' as _ifq13nbh;
import '../alerts/alert_type.dart' as _i9unj23o;

abstract class FarmAlert
    implements _isc.SerializableModel, _isc.ProtocolSerialization {
  FarmAlert._({
    this.id,
    required this.farmId,
    this.animalId,
    required this.severity,
    required this.alertType,
    required this.title,
    required this.description,
    required this.createdAt,
    this.acknowledgedAt,
    this.resolvedAt,
  });

  factory FarmAlert({
    int? id,
    required int farmId,
    int? animalId,
    required _ifq13nbh.AlertSeverity severity,
    required _i9unj23o.AlertType alertType,
    required String title,
    required String description,
    required DateTime createdAt,
    DateTime? acknowledgedAt,
    DateTime? resolvedAt,
  }) = _FarmAlertImpl;

  factory FarmAlert.fromJson(Map<String, dynamic> jsonSerialization) {
    return FarmAlert(
      id: jsonSerialization['id'] as int?,
      farmId: jsonSerialization['farmId'] as int,
      animalId: jsonSerialization['animalId'] as int?,
      severity: _ifq13nbh.AlertSeverity.fromJson(
        (jsonSerialization['severity'] as String),
      ),
      alertType: _i9unj23o.AlertType.fromJson(
        (jsonSerialization['alertType'] as String),
      ),
      title: jsonSerialization['title'] as String,
      description: jsonSerialization['description'] as String,
      createdAt: _isc.DateTimeJsonExtension.fromJson(
        jsonSerialization['createdAt'],
      ),
      acknowledgedAt: jsonSerialization['acknowledgedAt'] == null
          ? null
          : _isc.DateTimeJsonExtension.fromJson(
              jsonSerialization['acknowledgedAt'],
            ),
      resolvedAt: jsonSerialization['resolvedAt'] == null
          ? null
          : _isc.DateTimeJsonExtension.fromJson(
              jsonSerialization['resolvedAt'],
            ),
    );
  }

  /// The database id, set if the object has been inserted into the
  /// database or if it has been fetched from the database. Otherwise,
  /// the id will be null.
  int? id;

  int farmId;

  int? animalId;

  _ifq13nbh.AlertSeverity severity;

  _i9unj23o.AlertType alertType;

  String title;

  String description;

  DateTime createdAt;

  DateTime? acknowledgedAt;

  DateTime? resolvedAt;

  /// Returns a shallow copy of this [FarmAlert]
  /// with some or all fields replaced by the given arguments.
  @_isc.useResult
  FarmAlert copyWith({
    int? id,
    int? farmId,
    int? animalId,
    _ifq13nbh.AlertSeverity? severity,
    _i9unj23o.AlertType? alertType,
    String? title,
    String? description,
    DateTime? createdAt,
    DateTime? acknowledgedAt,
    DateTime? resolvedAt,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'FarmAlert',
      if (id != null) 'id': id,
      'farmId': farmId,
      if (animalId != null) 'animalId': animalId,
      'severity': severity.toJson(),
      'alertType': alertType.toJson(),
      'title': title,
      'description': description,
      'createdAt': createdAt.toJson(),
      if (acknowledgedAt != null) 'acknowledgedAt': acknowledgedAt?.toJson(),
      if (resolvedAt != null) 'resolvedAt': resolvedAt?.toJson(),
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {
      '__className__': 'FarmAlert',
      if (id != null) 'id': id,
      'farmId': farmId,
      if (animalId != null) 'animalId': animalId,
      'severity': severity.toJson(),
      'alertType': alertType.toJson(),
      'title': title,
      'description': description,
      'createdAt': createdAt.toJson(),
      if (acknowledgedAt != null) 'acknowledgedAt': acknowledgedAt?.toJson(),
      if (resolvedAt != null) 'resolvedAt': resolvedAt?.toJson(),
    };
  }

  @override
  String toString() {
    return _isc.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _FarmAlertImpl extends FarmAlert {
  _FarmAlertImpl({
    int? id,
    required int farmId,
    int? animalId,
    required _ifq13nbh.AlertSeverity severity,
    required _i9unj23o.AlertType alertType,
    required String title,
    required String description,
    required DateTime createdAt,
    DateTime? acknowledgedAt,
    DateTime? resolvedAt,
  }) : super._(
         id: id,
         farmId: farmId,
         animalId: animalId,
         severity: severity,
         alertType: alertType,
         title: title,
         description: description,
         createdAt: createdAt,
         acknowledgedAt: acknowledgedAt,
         resolvedAt: resolvedAt,
       );

  /// Returns a shallow copy of this [FarmAlert]
  /// with some or all fields replaced by the given arguments.
  @_isc.useResult
  @override
  FarmAlert copyWith({
    Object? id = _Undefined,
    int? farmId,
    Object? animalId = _Undefined,
    _ifq13nbh.AlertSeverity? severity,
    _i9unj23o.AlertType? alertType,
    String? title,
    String? description,
    DateTime? createdAt,
    Object? acknowledgedAt = _Undefined,
    Object? resolvedAt = _Undefined,
  }) {
    return FarmAlert(
      id: id is int? ? id : this.id,
      farmId: farmId ?? this.farmId,
      animalId: animalId is int? ? animalId : this.animalId,
      severity: severity ?? this.severity,
      alertType: alertType ?? this.alertType,
      title: title ?? this.title,
      description: description ?? this.description,
      createdAt: createdAt ?? this.createdAt,
      acknowledgedAt: acknowledgedAt is DateTime?
          ? acknowledgedAt
          : this.acknowledgedAt,
      resolvedAt: resolvedAt is DateTime? ? resolvedAt : this.resolvedAt,
    );
  }
}
