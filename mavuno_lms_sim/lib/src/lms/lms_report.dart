import 'farm_clock.dart';

/// Species an LMS camera can identify and follow individually. Poultry are
/// not tracked: cameras cannot tell individual birds apart.
enum LmsSpecies {
  cattle('Cattle'),
  sheep('Sheep'),
  goats('Goats');

  const LmsSpecies(this.label);

  final String label;
}

/// An animal the monitoring system is asked to follow.
class HerdAnimal {
  const HerdAnimal({
    required this.id,
    required this.tag,
    required this.species,
    required this.isFemale,
    this.name,
  });

  /// The farm record identifier the report is filed against.
  final int id;
  final String tag;
  final String? name;
  final LmsSpecies species;
  final bool isFemale;

  String get displayName =>
      name?.trim().isNotEmpty == true ? '${name!.trim()} · $tag' : tag;

  Map<String, Object?> toJson() => {
    'id': id,
    'tag': tag,
    'name': name,
    'displayName': displayName,
    'species': species.name,
    'speciesLabel': species.label,
    'isFemale': isFemale,
  };
}

/// One of the farm cameras and the zone it watches.
enum Camera {
  feedingArea('Cam 1', 'Feeding area'),
  paddock('Cam 2', 'Paddock'),
  barn('Cam 3', 'Barn & resting area');

  const Camera(this.label, this.zone);

  final String label;
  final String zone;

  Map<String, Object?> toJson() => {
    'id': name,
    'label': label,
    'zone': zone,
  };
}

enum LmsEventType {
  fight('Fight'),
  isolation('Isolation from herd'),
  limping('Limping'),
  mounting('Mounting'),
  longLying('Long lying'),
  missedFeeding('Missed feeding');

  const LmsEventType(this.label);

  final String label;
}

/// A behaviour the behaviour engine noticed during a window.
class LmsEvent {
  const LmsEvent({
    required this.type,
    required this.time,
    required this.camera,
    required this.confidence,
    required this.description,
  });

  final LmsEventType type;

  /// Clock time on the simulated farm clock, for example `08:42`.
  final String time;
  final Camera camera;

  /// Detection confidence between 0 and 1.
  final double confidence;

  /// Farmer-readable sentence, for example `Had a fight with COW-02 (2 min)`.
  final String description;

  Map<String, Object?> toJson() => {
    'type': type.name,
    'typeLabel': type.label,
    'time': time,
    'camera': camera.toJson(),
    'confidence': confidence,
    'description': description,
  };
}

/// What a Livestock Monitoring System reports for one animal and one window.
///
/// This is the contract between the monitoring system and Mavuno. A real
/// LMS can replace the simulator by producing the same reports.
class LmsReport {
  const LmsReport({
    required this.animal,
    required this.window,
    required this.feedingMinutes,
    required this.activeMinutes,
    required this.lyingMinutes,
    required this.appetiteScore,
    required this.activityScore,
    required this.events,
  });

  final HerdAnimal animal;
  final MonitoringWindow window;

  /// Minutes spent grazing or at the feed trough.
  final int feedingMinutes;

  /// Minutes spent walking or otherwise up and moving, excluding grazing.
  final int activeMinutes;
  final int lyingMinutes;

  /// 0–10, feeding time measured against the species reference.
  final int appetiteScore;

  /// 0–10, active time measured against the species reference.
  final int activityScore;
  final List<LmsEvent> events;

  Map<String, Object?> toJson() => {
    'animal': animal.toJson(),
    'window': window.toJson(),
    'feedingMinutes': feedingMinutes,
    'activeMinutes': activeMinutes,
    'lyingMinutes': lyingMinutes,
    'appetiteScore': appetiteScore,
    'activityScore': activityScore,
    'events': events.map((event) => event.toJson()).toList(),
  };
}

/// A monitoring system that follows a herd through one window at a time.
abstract interface class LivestockMonitoringSystem {
  /// Returns one report per animal in [herd] for [window].
  Future<List<LmsReport>> track(List<HerdAnimal> herd, MonitoringWindow window);
}
