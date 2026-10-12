import 'package:mavuno_lms_sim/mavuno_lms_sim.dart';
import 'package:test/test.dart';

const cow = HerdAnimal(
  id: 1,
  tag: 'COW-01',
  species: LmsSpecies.cattle,
  isFemale: true,
);

LmsReport report(List<LmsEvent> events) => LmsReport(
  animal: cow,
  window: const MonitoringWindow(3),
  feedingMinutes: 82,
  activeMinutes: 64,
  lyingMinutes: 71,
  appetiteScore: 8,
  activityScore: 8,
  events: events,
);

void main() {
  group('observationNotesFor', () {
    test('tags the note and summarises a quiet window', () {
      expect(
        observationNotesFor(report(const [])),
        '[Simulated LMS · Day 2, 06:00–10:00] Feeding 82 min · active 64 min · '
        'lying 71 min. No unusual behaviour detected.',
      );
    });

    test('lists events with camera, zone and confidence', () {
      final notes = observationNotesFor(
        report(const [
          LmsEvent(
            type: LmsEventType.fight,
            time: '08:42',
            camera: Camera.feedingArea,
            confidence: 0.91,
            description: 'Had a fight with COW-02 at the trough (2 min)',
          ),
          LmsEvent(
            type: LmsEventType.isolation,
            time: '09:10',
            camera: Camera.paddock,
            confidence: 0.86,
            description: 'Stayed apart from the herd for 1 h 25 min',
          ),
        ]),
      );
      expect(
        notes,
        endsWith(
          '08:42 Cam 1 (Feeding area): Had a fight with COW-02 at the trough '
          '(2 min, 91% confidence). 09:10 Cam 2 (Paddock): Stayed apart from '
          'the herd for 1 h 25 min (86% confidence).',
        ),
      );
    });
  });

  group('SimulatorConfig', () {
    test('accepts a local server and defaults the URL', () {
      final config = SimulatorConfig.fromMap({
        'email': 'farmer@example.com',
        'password': ' spaced secret ',
      });
      expect(config.serverUrl.host, 'localhost');
      expect(config.password, ' spaced secret ');
      expect(config.farmId, isNull);
    });

    test('refuses non-local servers and missing credentials', () {
      expect(
        () => SimulatorConfig.fromMap({
          'serverUrl': 'https://mavuno.api.serverpod.space/',
          'email': 'farmer@example.com',
          'password': 'secret',
        }),
        throwsA(
          isA<FormatException>().having(
            (e) => e.message,
            'message',
            contains('only connects to a local Mavuno server'),
          ),
        ),
      );
      expect(
        () => SimulatorConfig.fromMap({'email': 'farmer@example.com'}),
        throwsFormatException,
      );
      expect(
        () => SimulatorConfig.fromMap({'password': 'secret'}),
        throwsFormatException,
      );
    });
  });

  test('formatMinutes reads naturally', () {
    expect(formatMinutes(45), '45 min');
    expect(formatMinutes(120), '2 h');
    expect(formatMinutes(85), '1 h 25 min');
  });
}
