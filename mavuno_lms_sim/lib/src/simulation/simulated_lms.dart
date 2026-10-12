import 'dart:math';

import '../lms/farm_clock.dart';
import '../lms/lms_report.dart';
import 'animal_condition.dart';
import 'reference_values.dart';

/// A report together with the hidden truth that produced it. Only the
/// simulator page sees the condition; Mavuno only receives the report.
class SimulatedReading {
  const SimulatedReading({
    required this.report,
    required this.condition,
    required this.conditionOverridden,
  });

  final LmsReport report;
  final AnimalCondition condition;
  final bool conditionOverridden;

  Map<String, Object?> toJson() => {
    ...report.toJson(),
    'condition': condition.name,
    'conditionLabel': condition.label,
    'conditionOverridden': conditionOverridden,
  };
}

/// Simulates three farm cameras, a behaviour engine and anomaly detection.
///
/// Behaviour follows each species' typical day ([ReferenceValues.defaults]),
/// shaped by time of day, each animal's temperament, its hidden condition and
/// a little noise. Scores measure that behaviour against the editable
/// [references], so raising a reference makes the herd score lower.
///
/// Everything is derived from [seed], the window and the animal, so
/// re-running a window reproduces the same reports.
class SimulatedLms implements LivestockMonitoringSystem {
  SimulatedLms({
    required this.seed,
    this.references = ReferenceValues.defaults,
    this.conditionOverrides = const {},
  }) : schedule = ConditionSchedule(seed);

  static const _longLyingMinutes = MonitoringWindow.minutes * 0.6;
  static const _maxBusyMinutes = 200.0;

  final int seed;
  final ReferenceValues references;

  /// Conditions forced from the simulator page, by animal id.
  final Map<int, AnimalCondition> conditionOverrides;
  final ConditionSchedule schedule;

  @override
  Future<List<LmsReport>> track(
    List<HerdAnimal> herd,
    MonitoringWindow window,
  ) async => simulate(herd, window).map((reading) => reading.report).toList();

  AnimalCondition conditionOf(HerdAnimal animal, int day) =>
      conditionOverrides[animal.id] ?? schedule.conditionOn(animal, day);

  List<SimulatedReading> simulate(
    List<HerdAnimal> herd,
    MonitoringWindow window,
  ) {
    final conditions = {
      for (final animal in herd) animal.id: conditionOf(animal, window.day),
    };
    final fights = _fights(herd, conditions, window);
    return [
      for (final animal in herd)
        _simulateAnimal(
          animal,
          window,
          conditions[animal.id]!,
          fights[animal.id] ?? const [],
        ),
    ];
  }

  SimulatedReading _simulateAnimal(
    HerdAnimal animal,
    MonitoringWindow window,
    AnimalCondition condition,
    List<LmsEvent> fights,
  ) {
    final random = Random(mixSeed(seed, [window.index, animal.id, 1]));
    final temperament = Random(mixSeed(seed, [animal.id, 2]));
    final feedingTemperament = _between(temperament, 0.93, 1.07);
    final activeTemperament = _between(temperament, 0.90, 1.10);
    final typical = ReferenceValues.defaults[animal.species];
    final effect = _ConditionEffect.of(condition);
    final period = window.period;

    var feeding =
        typical.feedingMinutesPerWindow *
        period.feeding *
        feedingTemperament *
        _between(random, effect.feeding.$1, effect.feeding.$2) *
        _between(random, 0.92, 1.08);
    var active =
        typical.activeMinutesPerWindow *
        period.activity *
        activeTemperament *
        _between(random, effect.activity.$1, effect.activity.$2) *
        _between(random, 0.92, 1.08);
    // Leave time for resting, drinking and standing within the window.
    if (feeding + active > _maxBusyMinutes) {
      final scale = _maxBusyMinutes / (feeding + active);
      feeding *= scale;
      active *= scale;
    }
    final lying =
        (MonitoringWindow.minutes - feeding - active) *
        _between(random, effect.lyingShare.$1, effect.lyingShare.$2);

    final reference = references[animal.species];
    final events = [
      ...fights,
      ..._conditionEvents(
        random,
        animal,
        window,
        condition,
        feeding: feeding,
        typicalFeeding: typical.feedingMinutesPerWindow * period.feeding,
      ),
      if (lying >= _longLyingMinutes)
        LmsEvent(
          type: LmsEventType.longLying,
          time: window.timeAt(5 + random.nextInt(40)),
          camera: Camera.barn,
          confidence: _confidence(random),
          description:
              'Lay down for ${formatMinutes(lying.round())} of the 4 hours',
        ),
    ]..sort((a, b) => a.time.compareTo(b.time));

    return SimulatedReading(
      report: LmsReport(
        animal: animal,
        window: window,
        feedingMinutes: feeding.round(),
        activeMinutes: active.round(),
        lyingMinutes: lying.round(),
        appetiteScore: scoreFor(feeding, reference.feedingMinutesPerWindow),
        activityScore: scoreFor(active, reference.activeMinutesPerWindow),
        events: events,
      ),
      condition: condition,
      conditionOverridden: conditionOverrides.containsKey(animal.id),
    );
  }

  List<LmsEvent> _conditionEvents(
    Random random,
    HerdAnimal animal,
    MonitoringWindow window,
    AnimalCondition condition, {
    required double feeding,
    required double typicalFeeding,
  }) {
    final events = <LmsEvent>[];
    switch (condition) {
      case AnimalCondition.healthy:
        break;
      case AnimalCondition.unwell:
        if (random.nextDouble() < 0.75) {
          events.add(_isolation(random, window, 60 + random.nextInt(90)));
        }
        if (window.period != DayPeriod.midday &&
            feeding < typicalFeeding * 0.45) {
          final feedTime = window.timeAt(60);
          events.add(
            LmsEvent(
              type: LmsEventType.missedFeeding,
              time: feedTime,
              camera: Camera.feedingArea,
              confidence: _confidence(random),
              description: 'Did not come to the trough for the $feedTime feed',
            ),
          );
        }
      case AnimalCondition.lame:
        if (random.nextDouble() < 0.9) {
          final gait = 3 + random.nextInt(2);
          events.add(
            LmsEvent(
              type: LmsEventType.limping,
              time: window.timeAt(10 + random.nextInt(200)),
              camera: random.nextBool() ? Camera.paddock : Camera.barn,
              confidence: _confidence(random),
              description: 'Walked with a limp (gait score $gait/5)',
            ),
          );
        }
        if (random.nextDouble() < 0.25) {
          events.add(_isolation(random, window, 30 + random.nextInt(45)));
        }
      case AnimalCondition.inHeat:
        if (random.nextDouble() < 0.85) {
          final mounts = 2 + random.nextInt(5);
          events.add(
            LmsEvent(
              type: LmsEventType.mounting,
              time: window.timeAt(10 + random.nextInt(200)),
              camera: Camera.paddock,
              confidence: _confidence(random),
              description:
                  'Mounting activity seen ($mounts mounts), a possible sign of heat',
            ),
          );
        }
    }
    return events;
  }

  LmsEvent _isolation(Random random, MonitoringWindow window, int minutes) =>
      LmsEvent(
        type: LmsEventType.isolation,
        time: window.timeAt(10 + random.nextInt(MonitoringWindow.minutes - 20)),
        camera: Camera.paddock,
        confidence: _confidence(random),
        description: 'Stayed apart from the herd for ${formatMinutes(minutes)}',
      );

  /// Fights happen within a species, most often over the feed trough. Unwell
  /// animals keep to themselves and are left out.
  Map<int, List<LmsEvent>> _fights(
    List<HerdAnimal> herd,
    Map<int, AnimalCondition> conditions,
    MonitoringWindow window,
  ) {
    final random = Random(mixSeed(seed, [window.index, 3]));
    final fights = <int, List<LmsEvent>>{};
    for (final species in LmsSpecies.values) {
      final group = herd.where((animal) => animal.species == species).toList();
      final roll = random.nextDouble();
      final eligible = group
          .where((animal) => conditions[animal.id] != AnimalCondition.unwell)
          .toList();
      if (eligible.length < 2) continue;
      final heat = group.any(
        (animal) => conditions[animal.id] == AnimalCondition.inHeat,
      );
      if (roll >= (heat ? 0.30 : 0.15)) continue;

      final first = eligible.removeAt(random.nextInt(eligible.length));
      final second = eligible[random.nextInt(eligible.length)];
      final camera = random.nextDouble() < 0.6
          ? Camera.feedingArea
          : Camera.paddock;
      final time = window.timeAt(10 + random.nextInt(220));
      final minutes = 1 + random.nextInt(4);
      final confidence = _confidence(random);
      final where = camera == Camera.feedingArea
          ? 'at the trough'
          : 'in the paddock';
      for (final (animal, opponent) in [(first, second), (second, first)]) {
        (fights[animal.id] ??= []).add(
          LmsEvent(
            type: LmsEventType.fight,
            time: time,
            camera: camera,
            confidence: confidence,
            description:
                'Had a fight with ${opponent.tag} $where ($minutes min)',
          ),
        );
      }
    }
    return fights;
  }

  static double _between(Random random, double low, double high) =>
      low + random.nextDouble() * (high - low);

  static double _confidence(Random random) =>
      (_between(random, 0.80, 0.97) * 100).round() / 100;
}

/// How a hidden condition bends an animal's time budget. Ranges are applied
/// as multipliers on its typical feeding and active minutes; [lyingShare] is
/// how much of the remaining time it spends lying down.
class _ConditionEffect {
  const _ConditionEffect({
    required this.feeding,
    required this.activity,
    required this.lyingShare,
  });

  final (double, double) feeding;
  final (double, double) activity;
  final (double, double) lyingShare;

  static _ConditionEffect of(AnimalCondition condition) => switch (condition) {
    AnimalCondition.healthy => const _ConditionEffect(
      feeding: (1, 1),
      activity: (1, 1),
      lyingShare: (0.55, 0.75),
    ),
    AnimalCondition.unwell => const _ConditionEffect(
      feeding: (0.22, 0.38),
      activity: (0.25, 0.40),
      lyingShare: (0.85, 0.95),
    ),
    AnimalCondition.lame => const _ConditionEffect(
      feeding: (0.75, 0.90),
      activity: (0.25, 0.40),
      lyingShare: (0.80, 0.92),
    ),
    AnimalCondition.inHeat => const _ConditionEffect(
      feeding: (0.60, 0.75),
      activity: (1.60, 1.90),
      lyingShare: (0.30, 0.45),
    ),
  };
}

/// `45 min`, `2 h` or `1 h 25 min`.
String formatMinutes(int minutes) {
  final hours = minutes ~/ 60;
  final rest = minutes % 60;
  if (hours == 0) return '$rest min';
  if (rest == 0) return '$hours h';
  return '$hours h $rest min';
}
