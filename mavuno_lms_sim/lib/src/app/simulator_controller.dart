import '../lms/farm_clock.dart';
import '../lms/lms_report.dart';
import '../mavuno/mavuno_gateway.dart';
import '../mavuno/observation_notes.dart';
import '../simulation/animal_condition.dart';
import '../simulation/reference_values.dart';
import '../simulation/simulated_lms.dart';
import 'simulator_settings.dart';

/// The outcome of one click of "Generate report".
class SimulationRun {
  const SimulationRun({
    required this.window,
    required this.dryRun,
    required this.recordedAt,
    required this.readings,
    required this.posted,
    required this.failures,
  });

  final MonitoringWindow window;
  final bool dryRun;
  final DateTime recordedAt;
  final List<SimulatedReading> readings;

  /// Observations Mavuno accepted. Always 0 for a dry run.
  final int posted;
  final List<String> failures;

  Map<String, Object?> toJson() => {
    'window': window.toJson(),
    'dryRun': dryRun,
    'recordedAt': recordedAt.toIso8601String(),
    'posted': posted,
    'failures': failures,
    'cameras': _cameraActivity(),
    'readings': [
      for (final reading in readings)
        {...reading.toJson(), 'notes': observationNotesFor(reading.report)},
    ],
  };

  /// What each camera saw: feeding happens under Cam 1, moving about in the
  /// paddock under Cam 2 and lying down in the barn under Cam 3.
  List<Map<String, Object?>> _cameraActivity() => [
    for (final camera in Camera.values)
      {
        ...camera.toJson(),
        'animalMinutes': readings.fold<int>(
          0,
          (total, reading) => total + _minutesFor(camera, reading.report),
        ),
        'animalsSeen': readings
            .where((reading) => _minutesFor(camera, reading.report) > 0)
            .length,
        'events': [
          for (final reading in readings)
            for (final event in reading.report.events)
              if (event.camera == camera)
                {
                  'time': event.time,
                  'tag': reading.report.animal.tag,
                  'typeLabel': event.type.label,
                },
        ]..sort((a, b) => (a['time'] as String).compareTo(b['time'] as String)),
      },
  ];

  static int _minutesFor(Camera camera, LmsReport report) => switch (camera) {
    Camera.feedingArea => report.feedingMinutes,
    Camera.paddock => report.activeMinutes,
    Camera.barn => report.lyingMinutes,
  };
}

class SimulatorBusyException implements Exception {
  const SimulatorBusyException();

  @override
  String toString() => 'A report is already being generated.';
}

/// Runs the simulated LMS against Mavuno and keeps the page's state.
class SimulatorController {
  SimulatorController({
    required this._gateway,
    required SimulatorStore store,
    DateTime Function()? now,
  }) : _store = store,
       _now = now ?? DateTime.now,
       _settings = store.load();

  static const _maxRuns = 20;
  static const _herdCacheDuration = Duration(seconds: 15);

  final MavunoGateway _gateway;
  final SimulatorStore _store;
  final DateTime Function() _now;
  final _runs = <SimulationRun>[];

  SimulatorSettings _settings;
  HerdSnapshot? _herd;
  DateTime? _herdLoadedAt;
  String? _herdError;
  bool _busy = false;

  SimulatorSettings get settings => _settings;
  List<SimulationRun> get runs => List.unmodifiable(_runs);

  /// Reloads the herd from Mavuno, at most every few seconds unless [force].
  Future<void> refreshHerd({bool force = false}) async {
    final loadedAt = _herdLoadedAt;
    if (!force &&
        loadedAt != null &&
        _now().difference(loadedAt) < _herdCacheDuration) {
      return;
    }
    try {
      _herd = await _gateway.loadHerd();
      _herdError = null;
    } on Object catch (error) {
      _herdError = describeError(error);
      if (force) rethrow;
    } finally {
      _herdLoadedAt = _now();
    }
  }

  /// Tracks the herd through the next window. A dry run previews the window
  /// without posting or moving the farm clock; otherwise one observation per
  /// animal is posted and the clock moves on 4 hours.
  Future<SimulationRun> generate() async {
    if (_busy) throw const SimulatorBusyException();
    _busy = true;
    try {
      await refreshHerd(force: true);
      final herd = _herd!.monitored;
      if (herd.isEmpty) {
        throw StateError(
          'No animals to monitor. Add active cattle, sheep or goats in Mavuno.',
        );
      }
      final settings = _settings;
      final readings = SimulatedLms(
        seed: settings.seed,
        references: settings.references,
        conditionOverrides: settings.conditionOverrides,
      ).simulate(herd, settings.nextWindow);
      final recordedAt = _now();

      var posted = 0;
      final failures = <String>[];
      if (!settings.dryRun) {
        for (final reading in readings) {
          try {
            await _gateway.publish(reading.report, recordedAt: recordedAt);
            posted++;
          } on Object catch (error) {
            failures.add(
              '${reading.report.animal.tag}: ${describeError(error)}',
            );
          }
        }
        if (posted > 0) {
          await _update(
            settings.copyWith(nextWindow: settings.nextWindow.next),
          );
        }
      }

      final run = SimulationRun(
        window: settings.nextWindow,
        dryRun: settings.dryRun,
        recordedAt: recordedAt,
        readings: readings,
        posted: posted,
        failures: failures,
      );
      _runs.insert(0, run);
      if (_runs.length > _maxRuns) _runs.removeLast();
      return run;
    } finally {
      _busy = false;
    }
  }

  Future<void> setDryRun(bool dryRun) =>
      _update(_settings.copyWith(dryRun: dryRun));

  Future<void> setReferences(ReferenceValues references) =>
      _update(_settings.copyWith(references: references));

  /// Forces [condition] on an animal, or returns it to the automatic
  /// schedule when [condition] is null.
  Future<void> setCondition(int animalId, AnimalCondition? condition) {
    final overrides = {..._settings.conditionOverrides};
    if (condition == null) {
      overrides.remove(animalId);
    } else {
      overrides[animalId] = condition;
    }
    return _update(_settings.copyWith(conditionOverrides: overrides));
  }

  /// Starts again from Day 1, 06:00. Mavuno records are not touched.
  Future<void> resetClock() =>
      _update(_settings.copyWith(nextWindow: const MonitoringWindow(0)));

  /// Everything the simulator page shows.
  Map<String, Object?> toJson() {
    final settings = _settings;
    final herd = _herd;
    final schedule = ConditionSchedule(settings.seed);
    final latest = _runs.isEmpty ? null : _runs.first;
    return {
      'account': _gateway.account,
      'busy': _busy,
      'farm': herd?.farm.toJson(),
      'herdError': _herdError,
      'nextWindow': settings.nextWindow.toJson(),
      'dryRun': settings.dryRun,
      'references': settings.references.toJson(),
      'referenceLimits': {
        'min': SpeciesReference.minHours,
        'max': SpeciesReference.maxHours,
      },
      'herd': [
        for (final animal in herd?.monitored ?? const <HerdAnimal>[])
          {
            ...animal.toJson(),
            'conditionSetting':
                settings.conditionOverrides[animal.id]?.name ?? 'auto',
            'autoCondition': schedule
                .conditionOn(animal, settings.nextWindow.day)
                .label,
          },
      ],
      'notMonitored': herd?.notMonitored ?? const <String>[],
      'conditions': [
        for (final condition in AnimalCondition.values)
          {'id': condition.name, 'label': condition.label},
      ],
      'cameras': [for (final camera in Camera.values) camera.toJson()],
      'latestRun': latest?.toJson(),
      'runs': [for (final run in _runs) run.toJson()],
    };
  }

  Future<void> _update(SimulatorSettings settings) async {
    _settings = settings;
    await _store.save(settings);
  }
}

/// A short, readable message for errors shown on the page.
String describeError(Object error) {
  final text = error.toString();
  for (final prefix in ['Bad state: ', 'Exception: ', 'FormatException: ']) {
    if (text.startsWith(prefix)) return text.substring(prefix.length);
  }
  if (text.contains('SocketException') ||
      text.contains('Connection refused') ||
      text.contains('ClientException')) {
    return 'Mavuno is not reachable. Is `serverpod start` running?';
  }
  return text;
}
