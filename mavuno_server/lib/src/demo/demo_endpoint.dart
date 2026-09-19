import 'dart:math';

import 'package:serverpod/serverpod.dart';
import '../generated/protocol.dart';
import '../shared/farm_access.dart';

/// A deterministic, idempotent demo-data seeder for Mavuno.
///
/// Calling [seedDemo] multiple times by the same user is safe:
/// it checks for an existing "Mavuno Demo Farm" owned by that user
/// and skips creation if found.
///
/// The seed produces:
///   - 1 Demo Farm
///   - 7 Animals (4 cows, 2 sheep, 1 cow [#07] with a declining health pattern)
///   - 30 days of daily observations for Cow #07 (declining trend)
///   - 14 days of daily observations for other productive animals
///   - Production records matching observations for dairy/meat animals
///   - Feed records (herd-level daily for 14 days)
///   - Sample health and vaccination records
///   - 2 active alerts
///   - 2 open tasks
class DemoEndpoint extends Endpoint {
  static const _demoFarmName = 'Mavuno Demo Farm';

  Future<DemoSeedResult> seedDemo(Session session) async {
    final userId = FarmAccess.requireUser(session);

    // --- idempotency: check for existing demo farm ---
    final existing = await Farm.db.find(
      session,
      where: (t) => t.ownerId.equals(userId) & t.name.equals(_demoFarmName),
      limit: 1,
    );
    if (existing.isNotEmpty) {
      return DemoSeedResult(
        message: 'Demo farm already exists — skipping seed.',
        farmId: existing.first.id!,
        animalsSeeded: 0,
        observationsSeeded: 0,
        skipped: true,
      );
    }

    final now = DateTime.now().toUtc();

    // --- 1. Create the demo farm ---
    final farm = await Farm.db.insertRow(
      session,
      Farm(
        ownerId: userId,
        name: _demoFarmName,
        location: 'Rift Valley, Kenya',
        farmType: 'Mixed livestock',
        description:
            'Mavuno demonstration farm for testing and evaluation purposes.',
        createdAt: now,
        updatedAt: now,
      ),
    );
    final farmId = farm.id!;

    // --- 2. Define the animal roster ---
    final roster = <_AnimalSpec>[
      _AnimalSpec(
        'COW-01',
        'Bessie',
        AnimalSpecies.cattle,
        AnimalSex.female,
        'Friesian',
        true,
      ),
      _AnimalSpec(
        'COW-02',
        'Daisy',
        AnimalSpecies.cattle,
        AnimalSex.female,
        'Guernsey',
        true,
      ),
      _AnimalSpec(
        'COW-03',
        'Luna',
        AnimalSpecies.cattle,
        AnimalSex.female,
        'Jersey',
        true,
      ),
      _AnimalSpec(
        'COW-04',
        'Amber',
        AnimalSpecies.cattle,
        AnimalSex.female,
        'Ayrshire',
        true,
      ),
      _AnimalSpec(
        'COW-07',
        'Nora',
        AnimalSpecies.cattle,
        AnimalSex.female,
        'Friesian',
        true,
        declining: true,
      ),
      _AnimalSpec(
        'SHEEP-01',
        'Cotton',
        AnimalSpecies.sheep,
        AnimalSex.female,
        'Merino',
        false,
      ),
      _AnimalSpec(
        'SHEEP-02',
        'Woolly',
        AnimalSpecies.sheep,
        AnimalSex.male,
        'Dorper',
        false,
      ),
    ];

    // --- 3. Insert animals ---
    final animals = <Animal>[];
    for (var i = 0; i < roster.length; i++) {
      final spec = roster[i];
      // Fixed offsets keep the demo identical across machines and Dart runs.
      final dob = now.subtract(Duration(days: 365 * 4 + i * 90));
      final animal = await Animal.db.insertRow(
        session,
        Animal(
          farmId: farmId,
          tag: spec.tag,
          name: spec.name,
          species: spec.species,
          breed: spec.breed,
          sex: spec.sex,
          dateOfBirth: dob,
          status: AnimalStatus.active,
          createdAt: now,
          updatedAt: now,
        ),
      );
      animals.add(animal);
    }

    // --- 4. Seed observations ---
    var totalObs = 0;
    final rng = Random(42); // deterministic seed

    for (var i = 0; i < animals.length; i++) {
      final animal = animals[i];
      final spec = roster[i];
      final daysBack = spec.declining ? 30 : 14;

      for (var d = daysBack; d >= 0; d--) {
        final observedAt = now.subtract(Duration(days: d));

        double temperature;
        int activityScore;
        int appetiteScore;
        double feedIntake;
        double? productionValue;

        if (spec.declining) {
          // Cow #07: gradual deterioration over 30 days
          // Day 30 (oldest) → normal; Day 0 (today) → abnormal
          final progress = (30 - d) / 30.0; // 0.0 at oldest → 1.0 today
          temperature = 38.5 + progress * 1.8 + rng.nextDouble() * 0.2;
          activityScore = (8 - (progress * 5).round()).clamp(1, 10);
          appetiteScore = (8 - (progress * 4).round()).clamp(1, 10);
          feedIntake = 18.0 - progress * 10 + rng.nextDouble() * 0.5;
          productionValue = spec.isDairy
              ? (22.0 - progress * 14 + rng.nextDouble() * 0.8).clamp(0, 30)
              : null;
        } else {
          // Healthy animals: stable with minor jitter
          temperature = 38.5 + rng.nextDouble() * 0.4 - 0.2;
          activityScore = 7 + rng.nextInt(3);
          appetiteScore = 7 + rng.nextInt(3);
          feedIntake = 16.0 + rng.nextDouble() * 4;
          productionValue = spec.isDairy ? 18.0 + rng.nextDouble() * 6 : null;
        }

        await AnimalObservation.db.insertRow(
          session,
          AnimalObservation(
            animalId: animal.id!,
            recordedAt: observedAt,
            temperature: temperature,
            activityScore: activityScore,
            appetiteScore: appetiteScore,
            feedIntake: feedIntake.clamp(0, 30),
            productionValue: productionValue,
            productionUnit: spec.isDairy ? 'litres' : null,
            notes: spec.declining && d < 7
                ? 'Animal showing signs of reduced vitality'
                : null,
            recordedBy: userId,
          ),
        );
        totalObs++;

        // Matching production record
        if (spec.isDairy && productionValue != null) {
          await ProductionRecord.db.insertRow(
            session,
            ProductionRecord(
              animalId: animal.id!,
              recordedAt: observedAt,
              metricType: 'milk',
              value: productionValue,
              unit: 'litres',
            ),
          );
        }
      }
    }

    // --- 5. Herd-level feed records (14 days) ---
    for (var d = 14; d >= 0; d--) {
      final recordedAt = now.subtract(Duration(days: d));
      await FeedRecord.db.insertRow(
        session,
        FeedRecord(
          farmId: farmId,
          animalId: null,
          recordedAt: recordedAt,
          feedType: 'Mixed hay and silage',
          quantity: 120 + rng.nextDouble() * 20,
          unit: 'kg',
          notes: 'Daily herd ration',
        ),
      );
    }

    // --- 6. Health and vaccination records ---
    final cow01 = animals[0];
    final cow07 = animals[4];

    await HealthRecord.db.insertRow(
      session,
      HealthRecord(
        animalId: cow01.id!,
        recordedAt: now.subtract(const Duration(days: 45)),
        recordType: 'Routine check',
        description: 'Annual health inspection — all clear.',
        professionalName: 'Dr. Mwangi',
        notes: 'BCS 3.5, good body condition',
      ),
    );
    await HealthRecord.db.insertRow(
      session,
      HealthRecord(
        animalId: cow07.id!,
        recordedAt: now.subtract(const Duration(days: 5)),
        recordType: 'Sick visit',
        description:
            'Reduced appetite and milk output noted. Examination pending.',
        professionalName: 'Dr. Mwangi',
        notes: 'Possible early mastitis — monitor closely',
      ),
    );

    for (final animal in animals) {
      await VaccinationRecord.db.insertRow(
        session,
        VaccinationRecord(
          animalId: animal.id!,
          vaccination: 'FMD Vaccine',
          administeredAt: now.subtract(const Duration(days: 90)),
          nextDueAt: now.add(const Duration(days: 90)),
          provider: 'County Vet Services',
        ),
      );
    }

    // --- 7. Alerts ---
    await FarmAlert.db.insertRow(
      session,
      FarmAlert(
        farmId: farmId,
        animalId: cow07.id!,
        severity: AlertSeverity.high,
        alertType: AlertType.health,
        title: 'Cow #07 — declining production trend',
        description:
            'COW-07 (Nora) has shown a consistent 7-day decline in milk output, '
            'appetite, and activity. Temperature trending above baseline. '
            'Recommend immediate veterinary review.',
        createdAt: now.subtract(const Duration(days: 2)),
      ),
    );
    await FarmAlert.db.insertRow(
      session,
      FarmAlert(
        farmId: farmId,
        animalId: null,
        severity: AlertSeverity.moderate,
        alertType: AlertType.nutrition,
        title: 'Herd feed stock running low',
        description:
            'Current hay reserves estimated at 3 days remaining at current consumption rates.',
        createdAt: now.subtract(const Duration(days: 1)),
      ),
    );

    // --- 8. Tasks ---
    await FarmTask.db.insertRow(
      session,
      FarmTask(
        farmId: farmId,
        animalId: cow07.id!,
        title: 'Veterinary examination — Cow #07',
        description:
            'Schedule Dr. Mwangi for full health workup on COW-07 (Nora).',
        priority: TaskPriority.urgent,
        dueAt: now.add(const Duration(days: 1)),
        status: TaskStatus.open,
        createdAt: now,
      ),
    );
    await FarmTask.db.insertRow(
      session,
      FarmTask(
        farmId: farmId,
        animalId: null,
        title: 'Restock hay supplies',
        description: 'Order minimum 500 kg hay bales from Nakuru supplier.',
        priority: TaskPriority.high,
        dueAt: now.add(const Duration(days: 2)),
        status: TaskStatus.open,
        createdAt: now,
      ),
    );

    return DemoSeedResult(
      message: 'Demo farm seeded successfully.',
      farmId: farmId,
      animalsSeeded: animals.length,
      observationsSeeded: totalObs,
      skipped: false,
    );
  }
}

// DemoSeedResult is generated from demo_seed_result.spy.yaml

/// Internal spec for the animal roster — not a Serverpod model.
class _AnimalSpec {
  final String tag;
  final String name;
  final AnimalSpecies species;
  final AnimalSex sex;
  final String breed;
  final bool isDairy;
  final bool declining;

  _AnimalSpec(
    this.tag,
    this.name,
    this.species,
    this.sex,
    this.breed,
    this.isDairy, {
    this.declining = false,
  });
}
