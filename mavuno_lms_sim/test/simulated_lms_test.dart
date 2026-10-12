import 'package:mavuno_lms_sim/mavuno_lms_sim.dart';
import 'package:test/test.dart';

const herd = [
  HerdAnimal(id: 1, tag: 'COW-01', species: LmsSpecies.cattle, isFemale: true),
  HerdAnimal(id: 2, tag: 'COW-02', species: LmsSpecies.cattle, isFemale: true),
  HerdAnimal(id: 3, tag: 'COW-03', species: LmsSpecies.cattle, isFemale: false),
  HerdAnimal(id: 4, tag: 'SHEEP-01', species: LmsSpecies.sheep, isFemale: true),
  HerdAnimal(id: 5, tag: 'GOAT-01', species: LmsSpecies.goats, isFemale: true),
];

/// Forces every animal into [condition] so the automatic schedule cannot
/// interfere with the expectation.
SimulatedLms everyone(AnimalCondition condition, {int seed = 42}) =>
    SimulatedLms(
      seed: seed,
      conditionOverrides: {for (final animal in herd) animal.id: condition},
    );

void main() {
  group('SimulatedLms', () {
    test('reports one reading per animal, reproducibly', () {
      const window = MonitoringWindow(4);
      final first = SimulatedLms(seed: 7).simulate(herd, window);
      final again = SimulatedLms(seed: 7).simulate(herd, window);
      expect(first, hasLength(herd.length));
      expect(
        first.map((r) => r.toJson()).toList(),
        again.map((r) => r.toJson()).toList(),
      );
      final other = SimulatedLms(seed: 8).simulate(herd, window);
      expect(
        other.map((r) => r.toJson()).toList(),
        isNot(first.map((r) => r.toJson()).toList()),
      );
    });

    test('healthy animals never fall to a score Sentinel would flag', () {
      final lms = everyone(AnimalCondition.healthy);
      for (var index = 0; index < 90; index++) {
        for (final reading in lms.simulate(herd, MonitoringWindow(index))) {
          final report = reading.report;
          expect(report.appetiteScore, greaterThan(4), reason: '$index');
          expect(report.activityScore, greaterThan(4), reason: '$index');
          expect(
            report.events.map((e) => e.type),
            everyElement(LmsEventType.fight),
          );
        }
      }
    });

    test('time budget always fits inside the 4-hour window', () {
      for (final condition in AnimalCondition.values) {
        final lms = everyone(condition);
        for (var index = 0; index < 30; index++) {
          for (final reading in lms.simulate(herd, MonitoringWindow(index))) {
            final report = reading.report;
            expect(
              report.feedingMinutes +
                  report.activeMinutes +
                  report.lyingMinutes,
              lessThanOrEqualTo(MonitoringWindow.minutes),
            );
          }
        }
      }
    });

    test('an unwell animal eats and moves little, and lies apart', () {
      final readings = [
        for (var index = 0; index < 30; index++)
          ...everyone(
            AnimalCondition.unwell,
          ).simulate(herd, MonitoringWindow(index)),
      ];
      final reports = readings.map((r) => r.report).toList();
      final lowAppetite = reports.where((r) => r.appetiteScore <= 4).length;
      final lowActivity = reports.where((r) => r.activityScore <= 4).length;
      expect(lowAppetite / reports.length, greaterThan(0.85));
      expect(lowActivity / reports.length, greaterThan(0.85));
      final events = reports.expand((r) => r.events).map((e) => e.type).toSet();
      expect(
        events,
        containsAll([LmsEventType.isolation, LmsEventType.longLying]),
      );
      expect(events, isNot(contains(LmsEventType.fight)));
    });

    test('a lame animal limps and moves little but keeps eating', () async {
      final lms = everyone(AnimalCondition.lame);
      final all = [
        for (var index = 0; index < 30; index++)
          ...await lms.track(herd, MonitoringWindow(index)),
      ];
      expect(
        all.where((r) => r.activityScore <= 4).length / all.length,
        greaterThan(0.85),
      );
      expect(
        all.where((r) => r.appetiteScore > 4).length / all.length,
        greaterThan(0.85),
      );
      expect(
        all
            .expand((r) => r.events)
            .where((e) => e.type == LmsEventType.limping),
        isNotEmpty,
      );
    });

    test('heat shows as mounting and high activity, only in females', () {
      final lms = SimulatedLms(
        seed: 3,
        conditionOverrides: {1: AnimalCondition.inHeat},
      );
      final reports = [
        for (var index = 0; index < 12; index++)
          lms.simulate(herd, MonitoringWindow(index)).first.report,
      ];
      expect(reports.every((r) => r.activityScore >= 8), isTrue);
      expect(
        reports.expand((r) => r.events).map((e) => e.type),
        contains(LmsEventType.mounting),
      );

      const schedule = ConditionSchedule(11);
      const bull = HerdAnimal(
        id: 3,
        tag: 'COW-03',
        species: LmsSpecies.cattle,
        isFemale: false,
      );
      for (var day = 1; day < 400; day++) {
        expect(schedule.conditionOn(bull, day), isNot(AnimalCondition.inHeat));
      }
    });

    test('a fight is reported for both animals, within one species', () {
      final lms = everyone(AnimalCondition.healthy, seed: 5);
      var fights = 0;
      for (var index = 0; index < 60; index++) {
        final readings = lms.simulate(herd, MonitoringWindow(index));
        final fighting = {
          for (final r in readings)
            for (final e in r.report.events)
              if (e.type == LmsEventType.fight) r.report.animal: e,
        };
        if (fighting.isEmpty) continue;
        fights++;
        expect(fighting.length.isEven, isTrue);
        for (final MapEntry(key: animal, value: event) in fighting.entries) {
          final opponent = fighting.keys.firstWhere(
            (other) => other != animal && event.description.contains(other.tag),
          );
          expect(opponent.species, animal.species);
        }
      }
      expect(fights, greaterThan(0));
    });

    test(
      'raising a reference lowers the scores without changing behaviour',
      () {
        const window = MonitoringWindow(0);
        final normal = everyone(AnimalCondition.healthy).simulate(herd, window);
        final strict = SimulatedLms(
          seed: 42,
          conditionOverrides: {
            for (final animal in herd) animal.id: AnimalCondition.healthy,
          },
          references: ReferenceValues.fromJson({
            'cattle': {'feedingHoursPerDay': 10, 'activeHoursPerDay': 8},
          }),
        ).simulate(herd, window);
        expect(
          strict.first.report.feedingMinutes,
          normal.first.report.feedingMinutes,
        );
        expect(
          strict.first.report.appetiteScore,
          lessThan(normal.first.report.appetiteScore),
        );
      },
    );

    test('automatic schedule produces occasional, lasting episodes', () {
      const schedule = ConditionSchedule(2024);
      final days = [
        for (var day = 1; day <= 200; day++)
          schedule.conditionOn(herd.first, day),
      ];
      final unhealthyDays = days.where((c) => c != AnimalCondition.healthy);
      expect(unhealthyDays.length, inInclusiveRange(10, 80));
      expect(
        schedule.conditionOn(herd.first, 37),
        schedule.conditionOn(herd.first, 37),
      );
    });
  });
}
