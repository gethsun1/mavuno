/// A 4-hour block of daylight monitoring on the simulated farm clock.
///
/// The simulated day runs from 06:00 to 18:00 and is split into three
/// windows. Window 0 is Day 1 06:00–10:00, window 3 is Day 2 06:00–10:00.
class MonitoringWindow {
  const MonitoringWindow(this.index) : assert(index >= 0);

  static const windowsPerDay = 3;
  static const dayStartHour = 6;
  static const windowHours = 4;
  static const minutes = windowHours * 60;
  static const monitoredHoursPerDay = windowsPerDay * windowHours;

  /// Number of windows since Day 1 06:00.
  final int index;

  int get day => index ~/ windowsPerDay + 1;
  int get slot => index % windowsPerDay;
  int get startHour => dayStartHour + slot * windowHours;
  int get endHour => startHour + windowHours;

  DayPeriod get period => DayPeriod.values[slot];

  MonitoringWindow get next => MonitoringWindow(index + 1);

  String get timeRange => '${_hhmm(startHour * 60)}–${_hhmm(endHour * 60)}';

  /// For example `Day 2, 06:00–10:00`.
  String get label => 'Day $day, $timeRange';

  /// Clock time [minuteOffset] minutes after the window starts.
  String timeAt(int minuteOffset) =>
      _hhmm(startHour * 60 + minuteOffset.clamp(0, minutes - 1));

  Map<String, Object?> toJson() => {
    'index': index,
    'day': day,
    'timeRange': timeRange,
    'label': label,
    'period': period.label,
  };

  @override
  bool operator ==(Object other) =>
      other is MonitoringWindow && other.index == index;

  @override
  int get hashCode => index.hashCode;

  @override
  String toString() => label;

  static String _hhmm(int minuteOfDay) =>
      '${(minuteOfDay ~/ 60).toString().padLeft(2, '0')}:'
      '${(minuteOfDay % 60).toString().padLeft(2, '0')}';
}

/// Livestock graze hardest in the cool morning, rest through the midday heat
/// and pick up again in the afternoon. Factors average to 1 across a day.
enum DayPeriod {
  morning('Morning', feeding: 1.15, activity: 1.10),
  midday('Midday', feeding: 0.80, activity: 0.85),
  afternoon('Afternoon', feeding: 1.05, activity: 1.05);

  const DayPeriod(this.label, {required this.feeding, required this.activity});

  final String label;
  final double feeding;
  final double activity;
}
