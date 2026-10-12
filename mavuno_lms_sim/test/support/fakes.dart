import 'package:mavuno_lms_sim/mavuno_lms_sim.dart';

class FakeGateway implements MavunoGateway {
  FakeGateway({this.herd = const [], this.failTags = const {}});

  List<HerdAnimal> herd;
  final Set<String> failTags;
  final published = <(LmsReport, DateTime)>[];
  bool unreachable = false;

  @override
  String get account => 'farmer@example.com';

  @override
  Future<HerdSnapshot> loadHerd() async {
    if (unreachable) throw StateError('Mavuno is down for the test.');
    return HerdSnapshot(
      farm: const FarmSummary(id: 1, name: 'LMS Test Farm'),
      monitored: herd,
      notMonitored: const [
        'HEN-01: cameras cannot tell individual birds apart',
      ],
    );
  }

  @override
  Future<void> publish(LmsReport report, {required DateTime recordedAt}) async {
    if (failTags.contains(report.animal.tag)) {
      throw Exception('Mavuno rejected ${report.animal.tag}.');
    }
    published.add((report, recordedAt));
  }
}

class MemoryStore implements SimulatorStore {
  SimulatorSettings? saved;

  @override
  SimulatorSettings load() =>
      saved ??
      const SimulatorSettings(
        seed: 99,
        nextWindow: MonitoringWindow(0),
        dryRun: false,
        references: ReferenceValues.defaults,
        conditionOverrides: {},
      );

  @override
  Future<void> save(SimulatorSettings settings) async => saved = settings;
}

const cows = [
  HerdAnimal(id: 1, tag: 'COW-01', species: LmsSpecies.cattle, isFemale: true),
  HerdAnimal(id: 2, tag: 'COW-02', species: LmsSpecies.cattle, isFemale: true),
];
