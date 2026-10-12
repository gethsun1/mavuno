# Mavuno simulated LMS

A simulated **Livestock Monitoring System** for local Mavuno development. Three virtual farm cameras follow the herd. A behaviour engine turns what they see into appetite and activity scores and behaviour notes, which are sent to Mavuno as ordinary observations. Farm Sentinel then assesses them like any other record.

It is a standalone package. It is not part of the Mavuno workspace and talks to Mavuno only through its public endpoints, signed in as the farm owner. A real LMS can replace it later by producing the same reports (`LmsReport`).

## Run it

1. Start Mavuno as usual: `serverpod start` in `mavuno_server`.
2. In the Mavuno app, create a farmer account, a farm and some cattle, sheep or goats.
3. Set up the simulator once:

   ```bash
   cd mavuno_lms_sim
   dart pub get
   cp config/credentials.example.yaml config/credentials.yaml   # then add the farmer's email and password
   ```

4. Start it and open http://localhost:8095:

   ```bash
   dart run bin/mavuno_lms_sim.dart
   ```

`config/credentials.yaml` and the `.lms/` state folder are ignored by git. The simulator refuses to connect to anything but a local Mavuno server, because its observations raise real alerts and tasks.

## What one click does

**Generate report** simulates 4 hours of camera tracking on the simulator's own farm clock. Days run from 06:00 to 18:00:

| Click | Window |
|---|---|
| 1 | Day 1, 06:00–10:00 |
| 2 | Day 1, 10:00–14:00 |
| 3 | Day 1, 14:00–18:00 |
| 4 | Day 2, 06:00–10:00 |

For every active cow, sheep and goat it posts one Mavuno observation, dated at the moment of the click, with:

- **`appetiteScore`**: feeding minutes against the species reference.
- **`activityScore`**: active minutes against the species reference.
- **`notes`**: tagged `[Simulated LMS · Day 2, 06:00–10:00]`, with the time budget and any events.

Example note:

```text
[Simulated LMS · Day 2, 06:00–10:00] Feeding 82 min · active 64 min · lying 71 min. 08:42 Cam 1 (Feeding area): Had a fight with COW-02 at the trough (2 min, 91% confidence).
```

Temperature and symptoms are not sent. Poultry are skipped, because cameras cannot follow individual birds, and so are sold, deceased and quarantined animals.

**Dry run** previews the next window without posting or moving the clock. If the herd and settings stay the same, a later real click sends exactly what was previewed.

## Scoring

A score of 10 means the animal fed, or moved, for the species reference time. The reference values are per 12-hour monitored day and are prorated to each 4-hour window. They can be edited on the page:

| Species | Feeding = 10 | Active = 10 |
|---|---|---|
| Cattle | 5 h/day (100 min/window) | 4 h/day (80 min/window) |
| Sheep | 6 h/day (120 min/window) | 5 h/day (100 min/window) |
| Goats | 5 h/day (100 min/window) | 5 h/day (100 min/window) |

The animals' actual behaviour always follows these default values. Raising a reference therefore makes the same behaviour score lower, which makes Sentinel more sensitive. Sentinel flags scores of 4 or below.

## How the herd behaves

Each animal has a hidden condition. It can be set per animal on the page, or left on **Auto**, a schedule that is repeatable from the seed:

| Condition | What the cameras see |
|---|---|
| Healthy | Normal feeding and activity. Scores stay above 4. |
| Unwell | Little feeding or movement. It stays apart from the herd, lies down for long periods, and may miss a feed. |
| Lame | Limping and low activity, but it keeps eating. |
| In heat (females) | Restless and very active, with mounting activity and less feeding. |

Fights happen between animals of the same species, mostly at the trough, and appear in both animals' notes. Behaviour also follows the time of day: grazing peaks in the morning and animals rest through the midday heat.

## Code map

| Path | Purpose |
|---|---|
| `lib/src/lms/` | The LMS contract (`LmsReport`, `LivestockMonitoringSystem`) and the farm clock. |
| `lib/src/simulation/` | Simulated cameras and behaviour engine, conditions and scoring. |
| `lib/src/mavuno/` | Sign-in, herd loading, observation notes and posting to Mavuno. |
| `lib/src/app/` | The controller behind the page and its saved settings. |
| `lib/src/web/` | The local web page and its JSON API (localhost only). |

Checks: `dart analyze --fatal-infos`, `dart format .` and `dart test`. None of them need Mavuno running.
