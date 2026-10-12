import 'package:mavuno_client/mavuno_client.dart';
import 'package:serverpod_auth_core_client/serverpod_auth_core_client.dart'
    show
        AuthSuccess,
        ClientAuthSessionManager,
        ClientAuthSessionManagerExtension,
        ClientAuthSuccessStorage;

import '../lms/lms_report.dart';
import 'observation_notes.dart';
import 'simulator_config.dart';

class FarmSummary {
  const FarmSummary({required this.id, required this.name});

  final int id;
  final String name;

  Map<String, Object?> toJson() => {'id': id, 'name': name};
}

/// The farm's animals, split into those the cameras follow and the rest.
class HerdSnapshot {
  const HerdSnapshot({
    required this.farm,
    required this.monitored,
    required this.notMonitored,
  });

  final FarmSummary farm;
  final List<HerdAnimal> monitored;

  /// Readable reasons, for example `HEN-01: poultry are not tracked`.
  final List<String> notMonitored;
}

/// Everything the simulator needs from Mavuno. Tests replace it with a fake.
abstract interface class MavunoGateway {
  /// The signed-in farmer, shown on the simulator page.
  String get account;

  Future<HerdSnapshot> loadHerd();

  /// Files [report] as a Mavuno observation recorded at [recordedAt].
  Future<void> publish(LmsReport report, {required DateTime recordedAt});
}

/// Talks to Mavuno through its public endpoints, signed in as the farm owner,
/// exactly as the Mavuno app does. Mavuno's own ownership checks apply.
class ClientMavunoGateway implements MavunoGateway {
  ClientMavunoGateway._(this._client, this.account, this._farmId);

  final Client _client;
  final int? _farmId;

  @override
  final String account;

  static Future<ClientMavunoGateway> signIn(SimulatorConfig config) async {
    final client = Client(config.serverUrl.toString())
      ..authSessionManager = ClientAuthSessionManager(
        storage: _MemoryAuthStorage(),
      );
    final authSuccess = await client.emailIdp.login(
      email: config.email,
      password: config.password,
    );
    await client.auth.updateSignedInUser(authSuccess);
    return ClientMavunoGateway._(client, config.email, config.farmId);
  }

  @override
  Future<HerdSnapshot> loadHerd() async {
    final farms = await _client.farm.list();
    if (farms.isEmpty) {
      throw StateError(
        'This account has no farm yet. Create one in the Mavuno app first.',
      );
    }
    final farm = _farmId == null
        ? farms.first
        : farms.firstWhere(
            (farm) => farm.id == _farmId,
            orElse: () =>
                throw StateError('Farm $_farmId is not one of your farms.'),
          );
    final animals = await _client.animal.listByFarm(farm.id!);
    final monitored = <HerdAnimal>[];
    final notMonitored = <String>[];
    for (final animal in animals) {
      final species = switch (animal.species) {
        AnimalSpecies.cattle => LmsSpecies.cattle,
        AnimalSpecies.sheep => LmsSpecies.sheep,
        AnimalSpecies.goats => LmsSpecies.goats,
        AnimalSpecies.poultry => null,
      };
      if (species == null) {
        notMonitored.add(
          '${animal.tag}: cameras cannot tell individual birds apart',
        );
      } else if (animal.status != AnimalStatus.active) {
        notMonitored.add('${animal.tag}: ${animal.status.name}');
      } else {
        monitored.add(
          HerdAnimal(
            id: animal.id!,
            tag: animal.tag,
            name: animal.name,
            species: species,
            isFemale: animal.sex == AnimalSex.female,
          ),
        );
      }
    }
    return HerdSnapshot(
      farm: FarmSummary(id: farm.id!, name: farm.name),
      monitored: monitored,
      notMonitored: notMonitored,
    );
  }

  @override
  Future<void> publish(LmsReport report, {required DateTime recordedAt}) =>
      _client.observation.create(
        report.animal.id,
        recordedAt,
        appetiteScore: report.appetiteScore,
        activityScore: report.activityScore,
        notes: observationNotesFor(report),
      );
}

/// The simulator signs in afresh on every start, so the session only needs
/// to live in memory.
class _MemoryAuthStorage implements ClientAuthSuccessStorage {
  AuthSuccess? _value;

  @override
  Future<AuthSuccess?> get() async => _value;

  @override
  Future<void> set(AuthSuccess? data) async => _value = data;
}
