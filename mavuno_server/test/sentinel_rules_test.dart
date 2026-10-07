import 'package:mavuno_server/src/generated/protocol.dart';
import 'package:mavuno_server/src/sentinel/sentinel_rules.dart';
import 'package:test/test.dart';

AnimalObservation observation({
  int id = 1,
  double? temperature,
  int? appetite,
  int? activity,
}) => AnimalObservation(
  id: id,
  animalId: 7,
  recordedAt: DateTime.utc(2026, 1, id),
  temperature: temperature,
  appetiteScore: appetite,
  activityScore: activity,
  recordedBy: 'farmer',
);

ProductionRecord milk(int day, double value) => ProductionRecord(
  animalId: 7,
  recordedAt: DateTime.utc(2026, 1, day),
  metricType: 'milk',
  value: value,
  unit: 'L',
);

void main() {
  group('SentinelEngine', () {
    test('does not assess when there is no source data', () {
      expect(SentinelEngine.evaluate(observations: [], production: []), isNull);
    });

    test('normal structured observation is low', () {
      final result = SentinelEngine.evaluate(
        observations: [
          observation(temperature: 38.5, appetite: 8, activity: 8),
        ],
        production: [],
      )!;
      expect(result.riskLevel, RiskLevel.low);
      expect(result.signals, isEmpty);
    });

    test('detects individual elevated temperature, appetite and activity', () {
      expect(
        SentinelEngine.evaluate(
          observations: [observation(temperature: 39.5)],
          production: [],
        )!.signals.single['code'],
        'elevated_temperature',
      );
      expect(
        SentinelEngine.evaluate(
          observations: [observation(appetite: 4)],
          production: [],
        )!.signals.single['code'],
        'reduced_appetite',
      );
      expect(
        SentinelEngine.evaluate(
          observations: [observation(activity: 4)],
          production: [],
        )!.signals.single['code'],
        'reduced_activity',
      );
    });

    test('classifies multiple signals as high and keeps evidence', () {
      final result = SentinelEngine.evaluate(
        observations: [
          observation(temperature: 40.1, appetite: 2, activity: 3),
        ],
        production: [],
      )!;
      expect(result.riskLevel, RiskLevel.high);
      expect(result.signals, hasLength(3));
      expect(result.serializedSignals, contains('40.1'));
      expect(result.serializedSignals, contains('2/10'));
    });

    test('missing milk history has no declining milk signal', () {
      final result = SentinelEngine.evaluate(
        observations: [observation()],
        production: [],
      )!;
      expect(result.signals, isEmpty);
      expect(result.baselineSummary, contains('no milk history'));
    });

    test('detects decline only with two matching milk records', () {
      final result = SentinelEngine.evaluate(
        observations: [],
        production: [milk(2, 8), milk(1, 10)],
      )!;
      expect(result.signals.single['code'], 'declining_milk_production');
      expect(result.riskLevel, RiskLevel.moderate);
    });
  });
}
