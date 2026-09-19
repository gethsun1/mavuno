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

abstract class DemoSeedResult
    implements _isc.SerializableModel, _isc.ProtocolSerialization {
  DemoSeedResult._({
    required this.message,
    required this.farmId,
    required this.animalsSeeded,
    required this.observationsSeeded,
    required this.skipped,
  });

  factory DemoSeedResult({
    required String message,
    required int farmId,
    required int animalsSeeded,
    required int observationsSeeded,
    required bool skipped,
  }) = _DemoSeedResultImpl;

  factory DemoSeedResult.fromJson(Map<String, dynamic> jsonSerialization) {
    return DemoSeedResult(
      message: jsonSerialization['message'] as String,
      farmId: jsonSerialization['farmId'] as int,
      animalsSeeded: jsonSerialization['animalsSeeded'] as int,
      observationsSeeded: jsonSerialization['observationsSeeded'] as int,
      skipped: _isc.BoolJsonExtension.fromJson(jsonSerialization['skipped']),
    );
  }

  String message;

  int farmId;

  int animalsSeeded;

  int observationsSeeded;

  bool skipped;

  /// Returns a shallow copy of this [DemoSeedResult]
  /// with some or all fields replaced by the given arguments.
  @_isc.useResult
  DemoSeedResult copyWith({
    String? message,
    int? farmId,
    int? animalsSeeded,
    int? observationsSeeded,
    bool? skipped,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'DemoSeedResult',
      'message': message,
      'farmId': farmId,
      'animalsSeeded': animalsSeeded,
      'observationsSeeded': observationsSeeded,
      'skipped': skipped,
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {
      '__className__': 'DemoSeedResult',
      'message': message,
      'farmId': farmId,
      'animalsSeeded': animalsSeeded,
      'observationsSeeded': observationsSeeded,
      'skipped': skipped,
    };
  }

  @override
  String toString() {
    return _isc.SerializationManager.encode(this);
  }
}

class _DemoSeedResultImpl extends DemoSeedResult {
  _DemoSeedResultImpl({
    required String message,
    required int farmId,
    required int animalsSeeded,
    required int observationsSeeded,
    required bool skipped,
  }) : super._(
         message: message,
         farmId: farmId,
         animalsSeeded: animalsSeeded,
         observationsSeeded: observationsSeeded,
         skipped: skipped,
       );

  /// Returns a shallow copy of this [DemoSeedResult]
  /// with some or all fields replaced by the given arguments.
  @_isc.useResult
  @override
  DemoSeedResult copyWith({
    String? message,
    int? farmId,
    int? animalsSeeded,
    int? observationsSeeded,
    bool? skipped,
  }) {
    return DemoSeedResult(
      message: message ?? this.message,
      farmId: farmId ?? this.farmId,
      animalsSeeded: animalsSeeded ?? this.animalsSeeded,
      observationsSeeded: observationsSeeded ?? this.observationsSeeded,
      skipped: skipped ?? this.skipped,
    );
  }
}
