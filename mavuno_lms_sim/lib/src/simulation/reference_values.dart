import '../lms/farm_clock.dart';
import '../lms/lms_report.dart';

/// Daily behaviour that scores 10 for a species. Values are per monitored
/// 12-hour day and prorated to each 4-hour window.
class SpeciesReference {
  const SpeciesReference({
    required this.feedingHoursPerDay,
    required this.activeHoursPerDay,
  });

  static const minHours = 0.5;
  static const maxHours = 10.0;

  final double feedingHoursPerDay;
  final double activeHoursPerDay;

  double get feedingMinutesPerWindow => _perWindow(feedingHoursPerDay);
  double get activeMinutesPerWindow => _perWindow(activeHoursPerDay);

  static double _perWindow(double hoursPerDay) =>
      hoursPerDay *
      60 *
      MonitoringWindow.windowHours /
      MonitoringWindow.monitoredHoursPerDay;

  factory SpeciesReference.fromJson(Map<String, Object?> json) =>
      SpeciesReference(
        feedingHoursPerDay: _hours(json['feedingHoursPerDay'], 'Feeding'),
        activeHoursPerDay: _hours(json['activeHoursPerDay'], 'Active'),
      );

  Map<String, Object?> toJson() => {
    'feedingHoursPerDay': feedingHoursPerDay,
    'activeHoursPerDay': activeHoursPerDay,
    'feedingMinutesPerWindow': feedingMinutesPerWindow.round(),
    'activeMinutesPerWindow': activeMinutesPerWindow.round(),
  };

  static double _hours(Object? value, String label) {
    if (value is! num || !value.isFinite) {
      throw FormatException('$label hours must be a number.');
    }
    if (value < minHours || value > maxHours) {
      throw FormatException(
        '$label hours must be between $minHours and $maxHours per day.',
      );
    }
    return value.toDouble();
  }
}

/// Editable scoring references, one per species.
class ReferenceValues {
  const ReferenceValues(this.bySpecies);

  /// Arbitrary starting values: a cow grazing 5 hours a day scores 10.
  static const defaults = ReferenceValues({
    LmsSpecies.cattle: SpeciesReference(
      feedingHoursPerDay: 5,
      activeHoursPerDay: 4,
    ),
    LmsSpecies.sheep: SpeciesReference(
      feedingHoursPerDay: 6,
      activeHoursPerDay: 5,
    ),
    LmsSpecies.goats: SpeciesReference(
      feedingHoursPerDay: 5,
      activeHoursPerDay: 5,
    ),
  });

  final Map<LmsSpecies, SpeciesReference> bySpecies;

  SpeciesReference operator [](LmsSpecies species) =>
      bySpecies[species] ?? defaults.bySpecies[species]!;

  /// Reads every species, falling back to the defaults for missing ones.
  factory ReferenceValues.fromJson(Map<String, Object?> json) =>
      ReferenceValues({
        for (final species in LmsSpecies.values)
          species: switch (json[species.name]) {
            final Map<String, Object?> value => SpeciesReference.fromJson(
              value,
            ),
            _ => defaults[species],
          },
      });

  Map<String, Object?> toJson() => {
    for (final species in LmsSpecies.values)
      species.name: this[species].toJson(),
  };
}

/// Converts observed minutes into the 0–10 score Mavuno stores.
int scoreFor(num observedMinutes, num referenceMinutes) {
  if (referenceMinutes <= 0) return 0;
  return (10 * observedMinutes / referenceMinutes).round().clamp(0, 10);
}
