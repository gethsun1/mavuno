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
import 'package:mavuno_server/src/generated/protocol.dart' as _is98wa9p;
import 'package:serverpod/serverpod.dart' as _is;

abstract class SentinelAiExplanation
    implements _is.SerializableModel, _is.ProtocolSerialization {
  SentinelAiExplanation._({
    required this.summary,
    required this.whyFlagged,
    required this.signals,
    required this.whatToWatch,
    required this.limitations,
  });

  factory SentinelAiExplanation({
    required String summary,
    required String whyFlagged,
    required List<String> signals,
    required String whatToWatch,
    required String limitations,
  }) = _SentinelAiExplanationImpl;

  factory SentinelAiExplanation.fromJson(
    Map<String, dynamic> jsonSerialization,
  ) {
    return SentinelAiExplanation(
      summary: jsonSerialization['summary'] as String,
      whyFlagged: jsonSerialization['whyFlagged'] as String,
      signals: _is98wa9p.Protocol().deserialize<List<String>>(
        jsonSerialization['signals'],
      ),
      whatToWatch: jsonSerialization['whatToWatch'] as String,
      limitations: jsonSerialization['limitations'] as String,
    );
  }

  String summary;

  String whyFlagged;

  List<String> signals;

  String whatToWatch;

  String limitations;

  /// Returns a shallow copy of this [SentinelAiExplanation]
  /// with some or all fields replaced by the given arguments.
  @_is.useResult
  SentinelAiExplanation copyWith({
    String? summary,
    String? whyFlagged,
    List<String>? signals,
    String? whatToWatch,
    String? limitations,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'SentinelAiExplanation',
      'summary': summary,
      'whyFlagged': whyFlagged,
      'signals': signals.toJson(),
      'whatToWatch': whatToWatch,
      'limitations': limitations,
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {
      '__className__': 'SentinelAiExplanation',
      'summary': summary,
      'whyFlagged': whyFlagged,
      'signals': signals.toJson(),
      'whatToWatch': whatToWatch,
      'limitations': limitations,
    };
  }

  @override
  String toString() {
    return _is.SerializationManager.encode(this);
  }
}

class _SentinelAiExplanationImpl extends SentinelAiExplanation {
  _SentinelAiExplanationImpl({
    required String summary,
    required String whyFlagged,
    required List<String> signals,
    required String whatToWatch,
    required String limitations,
  }) : super._(
         summary: summary,
         whyFlagged: whyFlagged,
         signals: signals,
         whatToWatch: whatToWatch,
         limitations: limitations,
       );

  /// Returns a shallow copy of this [SentinelAiExplanation]
  /// with some or all fields replaced by the given arguments.
  @_is.useResult
  @override
  SentinelAiExplanation copyWith({
    String? summary,
    String? whyFlagged,
    List<String>? signals,
    String? whatToWatch,
    String? limitations,
  }) {
    return SentinelAiExplanation(
      summary: summary ?? this.summary,
      whyFlagged: whyFlagged ?? this.whyFlagged,
      signals: signals ?? this.signals.map((e0) => e0).toList(),
      whatToWatch: whatToWatch ?? this.whatToWatch,
      limitations: limitations ?? this.limitations,
    );
  }
}
