import 'dart:convert';

import '../generated/protocol.dart';

/// Explicit, version-one Sentinel thresholds. Values are based on the farm's
/// structured records and are rules for attention, not diagnosis.
class SentinelRules {
  static const elevatedTemperatureCelsius = 39.5;
  static const reducedAppetiteMaximum = 4;
  static const reducedActivityMaximum = 4;
  static const milkDeclineFraction = 0.20;
  static const milkMetric = 'milk';
}

class SentinelResult {
  SentinelResult({
    required this.riskLevel,
    required this.signals,
    required this.recommendedAction,
    required this.baselineSummary,
    required this.sourceObservationId,
  });

  final RiskLevel riskLevel;
  final List<Map<String, Object>> signals;
  final String recommendedAction;
  final String baselineSummary;
  final int? sourceObservationId;

  String get serializedSignals => jsonEncode(signals);

  /// Existing schema requires a riskScore. This stores the transparent count
  /// used for classification, not a probability or medical score.
  double get signalCount => signals.length.toDouble();
}

class SentinelEngine {
  static AnimalObservation? _latestWith(
    List<AnimalObservation> observations,
    bool Function(AnimalObservation) hasValue,
  ) {
    for (final observation in observations) {
      if (hasValue(observation)) return observation;
    }
    return null;
  }

  static SentinelResult? evaluate({
    required List<AnimalObservation> observations,
    required List<ProductionRecord> production,
  }) {
    if (observations.isEmpty && production.isEmpty) return null;

    final orderedObservations = [...observations]
      ..sort((a, b) => b.recordedAt.compareTo(a.recordedAt));
    final latestObservation = orderedObservations.isEmpty
        ? null
        : orderedObservations.first;
    final temperatureObservation = _latestWith(
      orderedObservations,
      (o) => o.temperature != null,
    );
    final appetiteObservation = _latestWith(
      orderedObservations,
      (o) => o.appetiteScore != null,
    );
    final activityObservation = _latestWith(
      orderedObservations,
      (o) => o.activityScore != null,
    );
    final signals = <Map<String, Object>>[];

    if (temperatureObservation?.temperature case final temperature?
        when temperature >= SentinelRules.elevatedTemperatureCelsius) {
      signals.add({
        'code': 'elevated_temperature',
        'title': 'Elevated temperature',
        'severity': 'significant',
        'evidence': 'Latest recorded temperature is $temperature°C.',
        'measuredValue': temperature,
        'threshold': SentinelRules.elevatedTemperatureCelsius,
      });
    }
    if (appetiteObservation?.appetiteScore case final appetite?
        when appetite <= SentinelRules.reducedAppetiteMaximum) {
      signals.add({
        'code': 'reduced_appetite',
        'title': 'Reduced appetite',
        'severity': 'significant',
        'evidence': 'Latest appetite score is $appetite/10.',
        'measuredValue': appetite,
        'threshold': SentinelRules.reducedAppetiteMaximum,
      });
    }
    if (activityObservation?.activityScore case final activity?
        when activity <= SentinelRules.reducedActivityMaximum) {
      signals.add({
        'code': 'reduced_activity',
        'title': 'Reduced activity',
        'severity': 'significant',
        'evidence': 'Latest activity score is $activity/10.',
        'measuredValue': activity,
        'threshold': SentinelRules.reducedActivityMaximum,
      });
    }

    final milk =
        production
            .where(
              (r) => r.metricType.toLowerCase() == SentinelRules.milkMetric,
            )
            .toList()
          ..sort((a, b) => b.recordedAt.compareTo(a.recordedAt));
    final matchingMilk = milk.isEmpty
        ? <ProductionRecord>[]
        : milk
              .where(
                (r) => r.unit.toLowerCase() == milk.first.unit.toLowerCase(),
              )
              .toList();
    if (matchingMilk.length >= 2 && matchingMilk[1].value > 0) {
      final latest = matchingMilk[0];
      final previous = matchingMilk[1];
      final decline = (previous.value - latest.value) / previous.value;
      if (decline >= SentinelRules.milkDeclineFraction) {
        signals.add({
          'code': 'declining_milk_production',
          'title': 'Declining milk production',
          'severity': 'significant',
          'evidence':
              'Milk production changed from ${previous.value} ${previous.unit} to ${latest.value} ${latest.unit}.',
          'measuredValue': latest.value,
          'baseline': previous.value,
          'declineFraction': decline,
          'threshold': SentinelRules.milkDeclineFraction,
        });
      }
    }

    final riskLevel = switch (signals.length) {
      0 => RiskLevel.low,
      1 => RiskLevel.moderate,
      2 || 3 => RiskLevel.high,
      _ => RiskLevel.critical,
    };
    final action = switch (riskLevel) {
      RiskLevel.low =>
        'No abnormal pattern detected in available structured records. Continue routine observation.',
      RiskLevel.moderate =>
        'Monitor closely and record another observation later. This is a precautionary alert, not a diagnosis.',
      RiskLevel.high =>
        'Monitor the animal closely and record a follow-up observation. Consider contacting a livestock professional if abnormal signs persist.',
      RiskLevel.critical =>
        'Separate and monitor the animal where appropriate, contact a veterinarian or livestock professional, and record a follow-up observation.',
    };
    final baseline = <String>[
      if (latestObservation != null)
        'Observation ${latestObservation.id} at ${latestObservation.recordedAt.toUtc().toIso8601String()}',
      if (matchingMilk.isNotEmpty)
        'Milk records: ${matchingMilk.length} matching ${matchingMilk.first.unit} record(s)',
      if (matchingMilk.isEmpty) 'Milk trend unavailable: no milk history',
    ].join('; ');
    return SentinelResult(
      riskLevel: riskLevel,
      signals: signals,
      recommendedAction: action,
      baselineSummary: baseline,
      sourceObservationId: latestObservation?.id,
    );
  }
}
