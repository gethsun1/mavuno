import '../lms/lms_report.dart';

/// Marks every note this simulator writes, so farmers and later tooling can
/// tell synthetic observations from real ones.
const lmsSourceTag = 'Simulated LMS';

/// Formats a report as the `notes` of a Mavuno observation, for example:
///
/// `[Simulated LMS · Day 2, 06:00–10:00] Feeding 82 min · active 64 min ·
/// lying 71 min. 08:42 Cam 1 (Feeding area): Had a fight with COW-02 at the
/// trough (2 min, 91% confidence).`
String observationNotesFor(LmsReport report) {
  final header = '[$lmsSourceTag · ${report.window.label}]';
  final behaviour =
      'Feeding ${report.feedingMinutes} min · '
      'active ${report.activeMinutes} min · '
      'lying ${report.lyingMinutes} min.';
  final events = report.events.isEmpty
      ? 'No unusual behaviour detected.'
      : report.events.map(_event).join(' ');
  return '$header $behaviour $events';
}

String _event(LmsEvent event) {
  final confidence = '${(event.confidence * 100).round()}% confidence';
  final description = event.description.endsWith(')')
      ? '${event.description.substring(0, event.description.length - 1)}, '
            '$confidence)'
      : '${event.description} ($confidence)';
  return '${event.time} ${event.camera.label} (${event.camera.zone}): '
      '$description.';
}
