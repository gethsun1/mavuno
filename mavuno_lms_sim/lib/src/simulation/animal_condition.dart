import 'dart:math';

import '../lms/lms_report.dart';

/// The hidden true state of an animal. Cameras never see this directly; they
/// only see the behaviour it causes.
enum AnimalCondition {
  healthy('Healthy'),
  unwell('Unwell'),
  lame('Lame'),
  inHeat('In heat');

  const AnimalCondition(this.label);

  final String label;

  static AnimalCondition? tryParse(String value) {
    for (final condition in values) {
      if (condition.name == value) return condition;
    }
    return null;
  }
}

/// Decides, deterministically from a seed, when animals fall unwell, go lame
/// or come into heat. The same seed always replays the same farm history.
class ConditionSchedule {
  const ConditionSchedule(this.seed);

  /// Chance that a new episode starts for an animal on a given day.
  static const episodeChancePerDay = 0.08;
  static const maxEpisodeDays = 3;

  final int seed;

  AnimalCondition conditionOn(HerdAnimal animal, int day) {
    final firstStart = max(1, day - maxEpisodeDays + 1);
    for (var start = firstStart; start <= day; start++) {
      final random = Random(mixSeed(seed, [animal.id, start, 7]));
      if (random.nextDouble() >= episodeChancePerDay) continue;
      final options = [
        AnimalCondition.unwell,
        AnimalCondition.lame,
        if (animal.isFemale) AnimalCondition.inHeat,
      ];
      final condition = options[random.nextInt(options.length)];
      // Heat passes within a day; illness and lameness linger.
      final length = condition == AnimalCondition.inHeat
          ? 1
          : 1 + random.nextInt(maxEpisodeDays);
      if (start + length > day) return condition;
    }
    return AnimalCondition.healthy;
  }
}

/// Combines a seed with identifiers into a stable seed for [Random]. Unlike
/// [Object.hash], the result is the same on every run and machine.
int mixSeed(int seed, List<int> parts) {
  var hash = 0x811c9dc5 ^ (seed & 0x7fffffff);
  for (final part in parts) {
    hash = (hash ^ (part & 0x7fffffff)) * 0x01000193 & 0x7fffffff;
    hash ^= hash >> 15;
  }
  return hash;
}
