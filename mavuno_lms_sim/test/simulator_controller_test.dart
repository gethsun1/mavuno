import 'package:mavuno_lms_sim/mavuno_lms_sim.dart';
import 'package:test/test.dart';

import 'support/fakes.dart';

void main() {
  final clickTime = DateTime(2026, 10, 12, 9, 30);

  SimulatorController controllerFor(FakeGateway gateway, MemoryStore store) =>
      SimulatorController(gateway: gateway, store: store, now: () => clickTime);

  group('SimulatorController', () {
    test(
      'a click posts one observation per animal and moves the clock',
      () async {
        final gateway = FakeGateway(herd: cows);
        final store = MemoryStore();
        final controller = controllerFor(gateway, store);

        final run = await controller.generate();

        expect(run.window.label, 'Day 1, 06:00–10:00');
        expect(run.posted, 2);
        expect(gateway.published.map((p) => p.$1.animal.tag), [
          'COW-01',
          'COW-02',
        ]);
        expect(gateway.published.map((p) => p.$2), everyElement(clickTime));
        expect(controller.settings.nextWindow.label, 'Day 1, 10:00–14:00');
        expect(store.saved?.nextWindow.index, 1);
      },
    );

    test('the fourth click starts the next day at 06:00', () async {
      final controller = controllerFor(FakeGateway(herd: cows), MemoryStore());
      final labels = [
        for (var click = 0; click < 4; click++)
          (await controller.generate()).window.label,
      ];
      expect(labels.last, 'Day 2, 06:00–10:00');
      expect(controller.runs.first.window.label, 'Day 2, 06:00–10:00');
    });

    test('a dry run previews without posting or moving the clock', () async {
      final gateway = FakeGateway(herd: cows);
      final controller = controllerFor(gateway, MemoryStore());
      await controller.setDryRun(true);

      final preview = await controller.generate();
      await controller.setDryRun(false);
      final real = await controller.generate();

      expect(preview.dryRun, isTrue);
      expect(preview.posted, 0);
      expect(real.window, preview.window);
      expect(
        real.readings.map((r) => r.toJson()).toList(),
        preview.readings.map((r) => r.toJson()).toList(),
        reason: 'the preview shows exactly what will be sent',
      );
      expect(gateway.published, hasLength(2));
    });

    test(
      'partial failures are reported; total failure keeps the window',
      () async {
        final gateway = FakeGateway(herd: cows, failTags: {'COW-02'});
        final controller = controllerFor(gateway, MemoryStore());

        final partial = await controller.generate();
        expect(partial.posted, 1);
        expect(partial.failures.single, startsWith('COW-02:'));
        expect(controller.settings.nextWindow.index, 1);

        final failing = FakeGateway(herd: cows, failTags: {'COW-01', 'COW-02'});
        final stuck = controllerFor(failing, MemoryStore());
        await stuck.generate();
        expect(stuck.settings.nextWindow.index, 0);
      },
    );

    test('explains an unreachable Mavuno or an empty herd', () async {
      final gateway = FakeGateway()..unreachable = true;
      final controller = controllerFor(gateway, MemoryStore());
      await expectLater(controller.generate(), throwsStateError);
      expect(controller.toJson()['herdError'], 'Mavuno is down for the test.');

      gateway.unreachable = false;
      await expectLater(
        controller.generate(),
        throwsA(
          isA<StateError>().having(
            (e) => e.message,
            'message',
            contains('No animals to monitor'),
          ),
        ),
      );
    });

    test('conditions can be forced and returned to the schedule', () async {
      final store = MemoryStore();
      final controller = controllerFor(FakeGateway(herd: cows), store);

      await controller.setCondition(2, AnimalCondition.lame);
      var run = await controller.generate();
      expect(run.readings[1].condition, AnimalCondition.lame);
      expect(run.readings[1].conditionOverridden, isTrue);
      expect(store.saved?.conditionOverrides, {2: AnimalCondition.lame});

      await controller.setCondition(2, null);
      run = await controller.generate();
      expect(run.readings[1].conditionOverridden, isFalse);
    });

    test('settings survive a restart through the store', () async {
      final store = MemoryStore();
      final first = controllerFor(FakeGateway(herd: cows), store);
      await first.generate();
      await first.setReferences(
        ReferenceValues.fromJson({
          'cattle': {'feedingHoursPerDay': 6, 'activeHoursPerDay': 4},
        }),
      );

      final restored = SimulatorSettings.fromJson(store.saved!.toJson());
      expect(restored.nextWindow.index, 1);
      expect(restored.references[LmsSpecies.cattle].feedingHoursPerDay, 6);
      expect(restored.seed, 99);
    });

    test('page state lists the herd, cameras and latest run', () async {
      final controller = controllerFor(FakeGateway(herd: cows), MemoryStore());
      await controller.refreshHerd();
      await controller.generate();
      final state = controller.toJson();

      expect((state['farm'] as Map)['name'], 'LMS Test Farm');
      expect(state['herd'], hasLength(2));
      expect(state['notMonitored'], hasLength(1));
      final latest = state['latestRun'] as Map<String, Object?>;
      expect(latest['cameras'], hasLength(3));
      final readings = latest['readings'] as List;
      expect(
        (readings.first as Map)['notes'],
        startsWith('[Simulated LMS · Day 1, 06:00–10:00]'),
      );
    });
  });
}
