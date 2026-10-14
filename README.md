# Mavuno

**Farm intelligence, from soil to decision.**

Mavuno is a farm management and livestock early-warning app for smallholder farmers. It brings farm and animal records, field observations, milk production, alerts, and follow-up tasks into one responsive application for web and Android.

Mavuno is built with Flutter and Serverpod. Its backend authenticates users, enforces farm ownership, and persists farm data in PostgreSQL. The app is designed for smallholder livestock farming in East Africa.

![Mavuno farm intelligence](mavuno_flutter/assets/mavuno_github_cover.jpg)

## Try Mavuno

- [Open the web app](https://mavuno.serverpod.space/)
- [Download the Android app](https://github.com/gethsun1/mavuno/releases/download/v1.0.1/mavuno-android-v1.0.1.apk) · [Release notes](https://github.com/gethsun1/mavuno/releases/tag/v1.0.1)
- [Production API](https://mavuno.api.serverpod.space/)

## Screenshots

Screens from the Mavuno app. The same workflows are available on web and Android.

| Farm dashboard | Animal profile |
| --- | --- |
| ![Farm dashboard](docs/screenshots/dashboard.png) | ![Animal profile](docs/screenshots/animal-profile.png) |

| Record an observation | Sentinel assessment |
| --- | --- |
| ![Observation form](docs/screenshots/observation-form.png) | ![Farm Sentinel assessment](docs/screenshots/sentinel-assessment.png) |

| Alert and follow-up task | Optional AI explanation |
| --- | --- |
| ![Alert and task](docs/screenshots/alert-task.png) | ![AI explanation](docs/screenshots/ai-explanation.png) |

## What Mavuno does

- Supports account sign-in, farm onboarding, and farm management.
- Lets farmers register livestock, browse animals, and maintain animal profiles, including photos.
- Stores structured observations—temperature, appetite, activity, symptoms, and notes—separately from milk production records.
- Uses **Farm Sentinel**, a deterministic rules engine, to assess recorded signals and save the evidence and recommended follow-up.
- Organizes farm alerts and follow-up tasks, with a dashboard for current farm activity.
- Delivers farm-scoped realtime events so connected clients can refresh after records change.
- Can provide an optional server-side AI explanation of a saved Sentinel assessment.

## Farm Sentinel

Sentinel evaluates persisted records on the server. Current rules look for temperature at or above 39.5 °C, appetite or activity at or below 4/10, and a milk-production decline of at least 20% between the latest two compatible records. The number of detected signals determines a Low, Moderate, High, or Critical assessment. Milk comparisons require matching units and an earlier value above zero.

Assessments include their detected signals, supporting evidence, and a suggested next action. Sentinel is an explainable early-warning tool, not a diagnosis or a substitute for veterinary care. When there is no assessment, Mavuno shows **Not assessed** rather than estimating a risk level. Rules and thresholds are product logic, not universal clinical guidance.

AI is optional and only explains an assessment already persisted by the server. It does not select the risk level or replace the assessment evidence. If the AI provider is unavailable, farm records and Sentinel results remain available.

## How it is built

```text
Flutter Web / Android
        ↓
Authenticated Serverpod endpoints and ownership checks
        ↓
PostgreSQL farm records
        ↓
Farm Sentinel → persisted assessments, alerts, and tasks
        ↓
Serverpod realtime events → connected clients refresh
```

| Layer | Technology |
| --- | --- |
| Client | Flutter and Dart (web and Android) |
| Backend | Serverpod 4, Dart, authenticated endpoints and method streams |
| Persistence | PostgreSQL through Serverpod |
| Optional explanations | Server-side Groq integration |
| Hosting | Serverpod Cloud |

Farm and animal access is checked on the server for every protected operation. Realtime events prompt clients to reload persisted state; they are not the source of truth. AI provider credentials remain on the server.

## Run locally

Requirements: Flutter 3.44.4 (or compatible Flutter 3.x), Dart 3.12.2 (or compatible), and Serverpod CLI 4.0.0.

```bash
git clone https://github.com/gethsun1/mavuno.git
cd mavuno
dart pub global activate serverpod_cli 4.0.0
dart pub get
cd mavuno_server
serverpod start
```

`serverpod start` starts the backend and configured Flutter app and watches for code changes. Local configuration and database data live under `mavuno_server/config/` and `mavuno_server/.serverpod/`; keep credentials out of tracked files.

## Project layout

```text
mavuno/
├── mavuno_flutter/   # Flutter app and widget tests
├── mavuno_server/    # Serverpod endpoints, domain logic, and tests
├── mavuno_client/    # Generated Serverpod client protocol
├── mavuno_lms_sim/   # Standalone simulated livestock monitoring system
└── docs/screenshots/ # Product screenshots
```

`mavuno_lms_sim` is a development simulator that sends sample livestock behaviour observations to a local Mavuno server. It is a prototype for a planned IoT capability: connecting real monitoring devices to provide farmers with timely livestock activity and progress updates, and to support theft deterrence. Real device monitoring and theft prevention are not current app features.

Serverpod-generated files are maintained by the generator. Make server model and endpoint changes in their source files, not in generated output.
