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
import 'package:serverpod/serverpod.dart' as _is;

abstract class FarmIntelligenceChanged
    implements _is.SerializableModel, _is.ProtocolSerialization {
  FarmIntelligenceChanged._({required this.farmId});

  factory FarmIntelligenceChanged({required int farmId}) =
      _FarmIntelligenceChangedImpl;

  factory FarmIntelligenceChanged.fromJson(
    Map<String, dynamic> jsonSerialization,
  ) {
    return FarmIntelligenceChanged(farmId: jsonSerialization['farmId'] as int);
  }

  int farmId;

  /// Returns a shallow copy of this [FarmIntelligenceChanged]
  /// with some or all fields replaced by the given arguments.
  @_is.useResult
  FarmIntelligenceChanged copyWith({int? farmId});
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'FarmIntelligenceChanged',
      'farmId': farmId,
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {
      '__className__': 'FarmIntelligenceChanged',
      'farmId': farmId,
    };
  }

  @override
  String toString() {
    return _is.SerializationManager.encode(this);
  }
}

class _FarmIntelligenceChangedImpl extends FarmIntelligenceChanged {
  _FarmIntelligenceChangedImpl({required int farmId}) : super._(farmId: farmId);

  /// Returns a shallow copy of this [FarmIntelligenceChanged]
  /// with some or all fields replaced by the given arguments.
  @_is.useResult
  @override
  FarmIntelligenceChanged copyWith({int? farmId}) {
    return FarmIntelligenceChanged(farmId: farmId ?? this.farmId);
  }
}
