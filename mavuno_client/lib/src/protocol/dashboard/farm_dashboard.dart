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
import 'package:mavuno_client/src/protocol/protocol.dart' as _iixzwlrd;
import 'package:serverpod_client/serverpod_client.dart' as _isc;
import '../alerts/farm_alert.dart' as _iku9ut5y;
import '../livestock/animal.dart' as _ixeshrfw;
import '../observations/animal_observation.dart' as _ildts8y1;
import '../production/production_record.dart' as _it3cgqya;
import '../sentinel/sentinel_assessment.dart' as _id7hkuu1;
import '../tasks/farm_task.dart' as _imtutlrd;

abstract class FarmDashboardSnapshot
    implements _isc.SerializableModel, _isc.ProtocolSerialization {
  FarmDashboardSnapshot._({
    required this.animals,
    required this.assessments,
    required this.alerts,
    required this.tasks,
    required this.observations,
    required this.production,
  });

  factory FarmDashboardSnapshot({
    required List<_ixeshrfw.Animal> animals,
    required List<_id7hkuu1.SentinelAssessment> assessments,
    required List<_iku9ut5y.FarmAlert> alerts,
    required List<_imtutlrd.FarmTask> tasks,
    required List<_ildts8y1.AnimalObservation> observations,
    required List<_it3cgqya.ProductionRecord> production,
  }) = _FarmDashboardSnapshotImpl;

  factory FarmDashboardSnapshot.fromJson(
    Map<String, dynamic> jsonSerialization,
  ) {
    return FarmDashboardSnapshot(
      animals: _iixzwlrd.Protocol().deserialize<List<_ixeshrfw.Animal>>(
        jsonSerialization['animals'],
      ),
      assessments: _iixzwlrd.Protocol()
          .deserialize<List<_id7hkuu1.SentinelAssessment>>(
            jsonSerialization['assessments'],
          ),
      alerts: _iixzwlrd.Protocol().deserialize<List<_iku9ut5y.FarmAlert>>(
        jsonSerialization['alerts'],
      ),
      tasks: _iixzwlrd.Protocol().deserialize<List<_imtutlrd.FarmTask>>(
        jsonSerialization['tasks'],
      ),
      observations: _iixzwlrd.Protocol()
          .deserialize<List<_ildts8y1.AnimalObservation>>(
            jsonSerialization['observations'],
          ),
      production: _iixzwlrd.Protocol()
          .deserialize<List<_it3cgqya.ProductionRecord>>(
            jsonSerialization['production'],
          ),
    );
  }

  List<_ixeshrfw.Animal> animals;

  List<_id7hkuu1.SentinelAssessment> assessments;

  List<_iku9ut5y.FarmAlert> alerts;

  List<_imtutlrd.FarmTask> tasks;

  List<_ildts8y1.AnimalObservation> observations;

  List<_it3cgqya.ProductionRecord> production;

  /// Returns a shallow copy of this [FarmDashboardSnapshot]
  /// with some or all fields replaced by the given arguments.
  @_isc.useResult
  FarmDashboardSnapshot copyWith({
    List<_ixeshrfw.Animal>? animals,
    List<_id7hkuu1.SentinelAssessment>? assessments,
    List<_iku9ut5y.FarmAlert>? alerts,
    List<_imtutlrd.FarmTask>? tasks,
    List<_ildts8y1.AnimalObservation>? observations,
    List<_it3cgqya.ProductionRecord>? production,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'FarmDashboardSnapshot',
      'animals': animals.toJson(valueToJson: (v) => v.toJson()),
      'assessments': assessments.toJson(valueToJson: (v) => v.toJson()),
      'alerts': alerts.toJson(valueToJson: (v) => v.toJson()),
      'tasks': tasks.toJson(valueToJson: (v) => v.toJson()),
      'observations': observations.toJson(valueToJson: (v) => v.toJson()),
      'production': production.toJson(valueToJson: (v) => v.toJson()),
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {
      '__className__': 'FarmDashboardSnapshot',
      'animals': animals.toJson(valueToJson: (v) => v.toJsonForProtocol()),
      'assessments': assessments.toJson(
        valueToJson: (v) => v.toJsonForProtocol(),
      ),
      'alerts': alerts.toJson(valueToJson: (v) => v.toJsonForProtocol()),
      'tasks': tasks.toJson(valueToJson: (v) => v.toJsonForProtocol()),
      'observations': observations.toJson(
        valueToJson: (v) => v.toJsonForProtocol(),
      ),
      'production': production.toJson(
        valueToJson: (v) => v.toJsonForProtocol(),
      ),
    };
  }

  @override
  String toString() {
    return _isc.SerializationManager.encode(this);
  }
}

class _FarmDashboardSnapshotImpl extends FarmDashboardSnapshot {
  _FarmDashboardSnapshotImpl({
    required List<_ixeshrfw.Animal> animals,
    required List<_id7hkuu1.SentinelAssessment> assessments,
    required List<_iku9ut5y.FarmAlert> alerts,
    required List<_imtutlrd.FarmTask> tasks,
    required List<_ildts8y1.AnimalObservation> observations,
    required List<_it3cgqya.ProductionRecord> production,
  }) : super._(
         animals: animals,
         assessments: assessments,
         alerts: alerts,
         tasks: tasks,
         observations: observations,
         production: production,
       );

  /// Returns a shallow copy of this [FarmDashboardSnapshot]
  /// with some or all fields replaced by the given arguments.
  @_isc.useResult
  @override
  FarmDashboardSnapshot copyWith({
    List<_ixeshrfw.Animal>? animals,
    List<_id7hkuu1.SentinelAssessment>? assessments,
    List<_iku9ut5y.FarmAlert>? alerts,
    List<_imtutlrd.FarmTask>? tasks,
    List<_ildts8y1.AnimalObservation>? observations,
    List<_it3cgqya.ProductionRecord>? production,
  }) {
    return FarmDashboardSnapshot(
      animals: animals ?? this.animals.map((e0) => e0.copyWith()).toList(),
      assessments:
          assessments ?? this.assessments.map((e0) => e0.copyWith()).toList(),
      alerts: alerts ?? this.alerts.map((e0) => e0.copyWith()).toList(),
      tasks: tasks ?? this.tasks.map((e0) => e0.copyWith()).toList(),
      observations:
          observations ?? this.observations.map((e0) => e0.copyWith()).toList(),
      production:
          production ?? this.production.map((e0) => e0.copyWith()).toList(),
    );
  }
}
