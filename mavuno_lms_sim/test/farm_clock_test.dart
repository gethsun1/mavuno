import 'package:mavuno_lms_sim/mavuno_lms_sim.dart';
import 'package:test/test.dart';

void main() {
  group('MonitoringWindow', () {
    test('three daylight windows make a day, then the next day starts', () {
      final labels = [
        for (var index = 0; index < 4; index++) MonitoringWindow(index).label,
      ];
      expect(labels, [
        'Day 1, 06:00–10:00',
        'Day 1, 10:00–14:00',
        'Day 1, 14:00–18:00',
        'Day 2, 06:00–10:00',
      ]);
    });

    test('never reaches the night', () {
      for (var index = 0; index < 30; index++) {
        final window = MonitoringWindow(index);
        expect(window.startHour, greaterThanOrEqualTo(6));
        expect(window.endHour, lessThanOrEqualTo(18));
      }
    });

    test('formats clock times inside the window', () {
      const window = MonitoringWindow(1);
      expect(window.timeAt(0), '10:00');
      expect(window.timeAt(95), '11:35');
      expect(window.timeAt(500), '13:59');
      expect(window.period, DayPeriod.midday);
    });

    test('time-of-day factors average to one across a day', () {
      final feeding = DayPeriod.values.fold<double>(0, (t, p) => t + p.feeding);
      final activity = DayPeriod.values.fold<double>(
        0,
        (t, p) => t + p.activity,
      );
      expect(feeding, closeTo(3, 1e-9));
      expect(activity, closeTo(3, 1e-9));
    });
  });
}
