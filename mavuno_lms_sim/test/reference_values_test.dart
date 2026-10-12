import 'package:mavuno_lms_sim/mavuno_lms_sim.dart';
import 'package:test/test.dart';

void main() {
  group('ReferenceValues', () {
    test('a cow grazing 5 hours a day scores 10 per 100-minute window', () {
      final cattle = ReferenceValues.defaults[LmsSpecies.cattle];
      expect(cattle.feedingHoursPerDay, 5);
      expect(cattle.feedingMinutesPerWindow, 100);
      expect(scoreFor(100, cattle.feedingMinutesPerWindow), 10);
      expect(scoreFor(80, cattle.feedingMinutesPerWindow), 8);
      expect(scoreFor(44, cattle.feedingMinutesPerWindow), 4);
    });

    test('scores are clamped to the 0–10 range Mavuno accepts', () {
      expect(scoreFor(180, 100), 10);
      expect(scoreFor(0, 100), 0);
      expect(scoreFor(50, 0), 0);
    });

    test('round-trips through JSON and fills missing species', () {
      final values = ReferenceValues.fromJson({
        'cattle': {'feedingHoursPerDay': 6, 'activeHoursPerDay': 3.5},
      });
      expect(values[LmsSpecies.cattle].feedingHoursPerDay, 6);
      expect(values[LmsSpecies.cattle].activeMinutesPerWindow, 70);
      expect(
        values[LmsSpecies.sheep].feedingHoursPerDay,
        ReferenceValues.defaults[LmsSpecies.sheep].feedingHoursPerDay,
      );
      final copy = ReferenceValues.fromJson(values.toJson());
      expect(copy[LmsSpecies.cattle].activeHoursPerDay, 3.5);
    });

    test('rejects values outside the editable range', () {
      for (final hours in [0, 0.4, 10.5, double.nan]) {
        expect(
          () => ReferenceValues.fromJson({
            'goats': {'feedingHoursPerDay': hours, 'activeHoursPerDay': 4},
          }),
          throwsFormatException,
        );
      }
      expect(
        () => ReferenceValues.fromJson({
          'goats': {'feedingHoursPerDay': 'five', 'activeHoursPerDay': 4},
        }),
        throwsFormatException,
      );
    });
  });
}
