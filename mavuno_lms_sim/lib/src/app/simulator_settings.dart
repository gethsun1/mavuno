import 'dart:convert';
import 'dart:io';
import 'dart:math';

import '../lms/farm_clock.dart';
import '../simulation/animal_condition.dart';
import '../simulation/reference_values.dart';

/// Everything the simulator remembers between runs.
class SimulatorSettings {
  const SimulatorSettings({
    required this.seed,
    required this.nextWindow,
    required this.dryRun,
    required this.references,
    required this.conditionOverrides,
  });

  factory SimulatorSettings.initial({Random? random}) => SimulatorSettings(
    seed: (random ?? Random()).nextInt(1 << 31),
    nextWindow: const MonitoringWindow(0),
    dryRun: false,
    references: ReferenceValues.defaults,
    conditionOverrides: const {},
  );

  final int seed;
  final MonitoringWindow nextWindow;
  final bool dryRun;
  final ReferenceValues references;
  final Map<int, AnimalCondition> conditionOverrides;

  SimulatorSettings copyWith({
    MonitoringWindow? nextWindow,
    bool? dryRun,
    ReferenceValues? references,
    Map<int, AnimalCondition>? conditionOverrides,
  }) => SimulatorSettings(
    seed: seed,
    nextWindow: nextWindow ?? this.nextWindow,
    dryRun: dryRun ?? this.dryRun,
    references: references ?? this.references,
    conditionOverrides: conditionOverrides ?? this.conditionOverrides,
  );

  factory SimulatorSettings.fromJson(Map<String, Object?> json) =>
      SimulatorSettings(
        seed: json['seed'] as int,
        nextWindow: MonitoringWindow(json['nextWindow'] as int),
        dryRun: json['dryRun'] as bool? ?? false,
        references: ReferenceValues.fromJson(
          (json['references'] as Map<String, Object?>?) ?? const {},
        ),
        conditionOverrides: {
          for (final MapEntry(:key, :value)
              in ((json['conditionOverrides'] as Map<String, Object?>?) ??
                      const {})
                  .entries)
            int.parse(key): ?AnimalCondition.tryParse(value as String),
        },
      );

  Map<String, Object?> toJson() => {
    'seed': seed,
    'nextWindow': nextWindow.index,
    'dryRun': dryRun,
    'references': {
      for (final MapEntry(:key, :value) in references.bySpecies.entries)
        key.name: {
          'feedingHoursPerDay': value.feedingHoursPerDay,
          'activeHoursPerDay': value.activeHoursPerDay,
        },
    },
    'conditionOverrides': {
      for (final MapEntry(:key, :value) in conditionOverrides.entries)
        '$key': value.name,
    },
  };
}

abstract interface class SimulatorStore {
  SimulatorSettings load();

  Future<void> save(SimulatorSettings settings);
}

/// Keeps settings in a local JSON file, `.lms/state.json` by default.
class FileSimulatorStore implements SimulatorStore {
  FileSimulatorStore(this.file);

  final File file;

  @override
  SimulatorSettings load() {
    if (!file.existsSync()) return SimulatorSettings.initial();
    try {
      return SimulatorSettings.fromJson(
        jsonDecode(file.readAsStringSync()) as Map<String, Object?>,
      );
    } on Object {
      // A damaged state file should not stop the simulator; start afresh.
      return SimulatorSettings.initial();
    }
  }

  @override
  Future<void> save(SimulatorSettings settings) async {
    await file.parent.create(recursive: true);
    await file.writeAsString(
      const JsonEncoder.withIndent('  ').convert(settings.toJson()),
    );
  }
}
