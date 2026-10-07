# Mavuno — Farm Intelligence, From Soil to Decision

Mavuno is a farm-management and early-warning application for smallholder livestock farmers. It brings farm records, livestock observations, deterministic Farm Sentinel assessments, alerts, and follow-up tasks into one authenticated Flutter app backed by Serverpod.

## The problem

Farm observations and production records can be difficult to compare when they are kept in separate places. Changes in temperature, appetite, activity, or milk production may be harder to spot in time to decide what to check next. Mavuno organizes those records and highlights patterns that may need attention. It is decision support, not veterinary diagnosis or a replacement for professional care.

## The solution

Farmers record structured information about animals. Farm Sentinel evaluates persisted observations and production records using explicit deterministic rules, stores an assessment with its evidence, and creates or updates related alerts and follow-up tasks. The dashboard puts current farm priorities in one view.

```mermaid
flowchart LR
  Observation["Observation or production record"] --> Persist["Persist farm record"]
  Persist --> Evaluate["Evaluate Farm Sentinel rules"]
  Evaluate --> Signals["Detected signals<br/>Temperature · appetite · activity · milk production"]
  Signals --> Risk["Classify risk"]
  Risk --> Assessment["Structured SentinelAssessment<br/>evidence and recommended action"]
  Assessment --> Alert["FarmAlert"]
  Assessment --> Task["FarmTask"]
  Alert --> Farmer["Farmer reviews and acts"]
  Task --> Farmer
  Assessment -. "Planned Phase 7: reads this assessment" .-> Explanation["AI explanation layer<br/>does not determine risk"]
```

## Why Mavuno is different

1. **Farm records come first.** Sentinel uses persisted, structured observations and production records.
2. **Deterministic rules determine risk.** The same records produce the same signals and classification.
3. **Assessments retain evidence.** Signals, source context, and recommended actions are stored with the assessment.
4. **Alerts and tasks make results actionable.** Sentinel maintains active alerts and one open follow-up task per animal as assessments are reevaluated.
5. **AI is a planned explanation layer.** **AI does not decide whether an animal is high risk.**

### Current Sentinel rules

These are Mavuno's current deterministic early-warning thresholds. They are implementation rules, not universal veterinary thresholds or diagnoses.

| Persisted pattern | Signal |
| --- | --- |
| Temperature at or above 39.5 °C | Elevated temperature |
| Appetite score at or below 4/10 | Reduced appetite |
| Activity score at or below 4/10 | Reduced activity |
| Milk production decline of at least 20% between the latest two compatible records | Declining milk production |

Milk records must have matching units, and the earlier value must be greater than zero for the decline comparison.

Signals are counted to classify risk:

| Signal count | Mavuno risk level |
| ---: | --- |
| 0 | LOW |
| 1 | MODERATE |
| 2–3 | HIGH |
| 4 | CRITICAL |

An assessment describes an abnormal pattern that may require attention; it does not identify a disease.

### Illustrative example

This example illustrates the rules; it is not a diagnosis or a claim about a particular farm record.

```text
Farmer → Farm → Nora · COW-07
Temperature: 40.1 °C · Appetite: 2/10 · Activity: 3/10
→ Three signals → HIGH early-warning assessment
→ Evidence and recommended action → Farm alert + follow-up task
```

If two compatible milk records also show a decline of at least 20%, that is a fourth signal and the classification becomes CRITICAL. The farmer can open the animal record to review the underlying evidence and decide what to do next.

## Core features

### Identity and farm management

- Email-based Serverpod authentication and farm onboarding.
- Farm and livestock records with server-enforced ownership boundaries.
- Animal browsing and detail pages.

### Field records

- Persisted animal observations for temperature, appetite, activity, selected symptoms, and notes.
- Separate persisted production records, including milk quantity and unit.
- Validation for supported values and record times.

### Farm Sentinel

- Deterministic signals and LOW, MODERATE, HIGH, and CRITICAL classifications.
- Persisted `SentinelAssessment` records containing detected signals and recommended actions.
- Automatic reevaluation after an observation or production record is created.
- Precautionary recommendations; no disease diagnosis.

### Alerts, tasks, and dashboard

- Sentinel-generated farm alerts and one open Sentinel follow-up task per animal, updated/deduplicated on reevaluation.
- One authenticated farm dashboard snapshot with the latest assessment per animal, herd risk counts, animals needing attention, active alerts, open tasks (including tasks without a due date), recent observations, and milk comparisons when two compatible records exist.
- Returning from animal detail reloads the dashboard data.

## System architecture

```mermaid
flowchart TB
  Flutter["Flutter client"] -->|"Authenticated, strongly typed Serverpod RPC"| API["Serverpod authenticated API"]
  API --> Endpoints["Farm and domain endpoints"]
  Endpoints --> Records["Farm · Animal · Observation · Production"]
  Records <--> DB[("PostgreSQL persistence")]
  Endpoints --> Sentinel["Farm Sentinel service"]
  Sentinel --> Rules["Deterministic domain rules"]
  Rules --> Assessment["SentinelAssessment"]
  Assessment --> Alert["FarmAlert"]
  Assessment --> Task["FarmTask"]
  Alert --> DB
  Task --> DB
  Assessment --> DB
  API --> Dashboard["Farm dashboard snapshot"]
  DB --> Dashboard
  Dashboard --> Flutter
  Assessment -. "Planned Phase 7 explanation only" .-> AI["Future AI explanation layer"]
```

Serverpod provides the authenticated backend, generated client/server protocol, persistence, domain endpoints, ownership checks, farm-level dashboard aggregation, and Sentinel orchestration. It is part of the product architecture, not only a database wrapper.

## Planned AI explanation (Phase 7)

Mavuno does not currently use an LLM to determine risk. Phase 7 is planned to read an existing structured Sentinel assessment and produce a farmer-friendly explanation of why the animal was flagged, which signals and evidence were used, what to monitor next, and what limitations apply.

The planned explanation layer must not diagnose disease, invent measurements, change risk classifications, create alerts or tasks, or override deterministic Sentinel logic. Phase 7 is the next planned phase; it is not implemented.

## Security and data access

- Serverpod authenticated sessions identify the user making each request.
- Server-side `FarmAccess` checks verify farm ownership and resolve animal access through its farm. Client-supplied farm identifiers are never authoritative for ownership.
- Dashboard records are scoped to the owned farm and its animals; cross-farm access is covered by integration tests.
- Put local password overrides in `mavuno_server/config/passwords.yaml`, which is ignored by Git. The checked-in Compose file is for local development only and contains local service credentials; replace them with private values before using Compose in a shared environment. Never reuse local credentials for deployment or commit deployment secrets.

## Technology

Versions below reflect the repository's current SDK constraints and resolved Serverpod dependencies; the Flutter and Dart versions are those used for verification.

- Flutter 3.44.4 and Dart 3.12.2.
- Serverpod 4.0.0 and Serverpod Auth IDP 4.0.0.
- PostgreSQL-backed persistence through Serverpod; the optional Docker Compose service uses PostgreSQL 16. The configured local development and test runtimes use separate Serverpod data paths.
- Generated, strongly typed Serverpod client/server protocol.

## Repository structure

```text
mavuno/
├── AGENTS.md
├── mavuno_client/                 # Generated Serverpod client protocol
├── mavuno_flutter/
│   ├── lib/screens/               # Sign-in, farm workspace, dashboard, records
│   └── test/                      # Flutter widget tests
├── mavuno_server/
│   ├── lib/src/farm/              # Farm domain and ownership
│   ├── lib/src/livestock/         # Animal records
│   ├── lib/src/observations/      # Field observations
│   ├── lib/src/production/        # Production records
│   ├── lib/src/sentinel/          # Rules, assessments, orchestration
│   ├── lib/src/alerts/            # Farm alerts
│   ├── lib/src/tasks/             # Follow-up tasks
│   ├── lib/src/dashboard/         # Farm dashboard aggregation
│   └── test/                      # Rule and endpoint tests
├── pubspec.yaml                   # Dart workspace
└── README.md
```

## Development setup

### Prerequisites

- Flutter SDK 3.44.4 or later in the compatible 3.x range, with its bundled Dart SDK (3.12.2 or later in the compatible 3.x range).
- The Serverpod CLI, matching the project's Serverpod 4.0.0 version.
- Git and a supported local development environment.

### Run the app

```bash
git clone https://github.com/gethsun1/mavuno.git
cd mavuno

# Install the Serverpod CLI and ensure the Dart pub cache bin directory is on PATH.
dart pub global activate serverpod_cli 4.0.0

# Resolve all packages in the Dart workspace.
dart pub get

# Start the backend and its configured Flutter app.
cd mavuno_server
serverpod start
```

The development configuration stores local PostgreSQL data under `mavuno_server/.serverpod/development/pgdata`; Redis is disabled in the local configuration. `serverpod start` watches for code generation and reloads. The companion Flutter app is configured to launch with it. To launch Flutter separately, leave the server running and use another terminal:

```bash
cd mavuno/mavuno_flutter
flutter run -d chrome
```

For local credentials or service overrides, use the ignored `mavuno_server/config/passwords.yaml` and the Serverpod configuration files. Do not add private credentials to source-controlled files. The test runtime is separate: it uses an isolated embedded PostgreSQL data directory under `.serverpod/test/pgdata` and does not require Docker or use the development database.

### Run checks

```bash
# Server rules and integration tests
cd mavuno/mavuno_server
dart analyze
dart test

# Flutter analysis and widget tests
cd ../mavuno_flutter
flutter analyze
flutter test
```

At the Phase 6 documentation update, the server suite has **53 passing tests** and the Flutter suite has **8 passing tests**. `dart analyze` passes for the server. `flutter analyze` has informational lint/deprecation findings and no compile errors. `git diff --check` passes.

## Roadmap

- [x] **Phases 1–3:** Authentication, farm onboarding, ownership, and livestock registration.
- [x] **Phase 4:** Persisted field observations and production records.
- [x] **Phase 5:** Deterministic Farm Sentinel assessments, alerts, and tasks.
- [x] **Phase 6:** Actionable farm dashboard and authenticated snapshot aggregation.
- [ ] **Phase 7 — Next:** AI Sentinel explanation of an existing structured assessment.
- [ ] **Phase 8 — Planned:** Serverpod Realtime / event showcase. Realtime is not currently implemented.
