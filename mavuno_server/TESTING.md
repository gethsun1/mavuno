# Mavuno server testing guide

Mavuno uses Serverpod's `serverpod_test` integration framework.

## Server integration tests

This workspace includes a Flutter member, so plain `dart test` from the server
package fails during workspace resolution. Use Flutter's Dart context instead:

```powershell
cd mavuno_server
docker compose up --detach postgres_test
flutter pub run test --reporter expanded
```

The test database is the `postgres_test` service in `docker-compose.yaml`,
configured in `config/test.yaml` on port 9090. Each `withServerpod` test group
uses isolated database state.

## Flutter tests and analysis

```powershell
cd mavuno_flutter
flutter test
flutter analyze
```

For the server package:

```powershell
cd mavuno_server
dart analyze
dart format .
```

## Test coverage

- `farm_test.dart`: farm CRUD and ownership isolation
- `animal_test.dart`: animal lifecycle and authorization
- `observation_test.dart`: validation and history
- `production_test.dart`: production records
- `alert_task_test.dart`: alert and task lifecycle
- `greeting_endpoint_test.dart`: generated starter endpoint smoke test

After changing `.spy.yaml` models, regenerate and migrate before testing:

```powershell
serverpod generate
serverpod create-migration
docker compose up --detach postgres_test
flutter pub run test
```
