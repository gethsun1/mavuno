import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mavuno_client/mavuno_client.dart';
import 'package:mavuno_flutter/screens/mavuno_app.dart';
import 'package:mavuno_flutter/screens/field_record_dialogs.dart';

Farm _farm() => Farm(
  id: 1,
  ownerId: 'farmer-1',
  name: 'Green Valley Farm',
  location: 'Nakuru',
  farmType: 'Mixed livestock',
  createdAt: DateTime(2025),
  updatedAt: DateTime(2025),
);

Animal _animal() => Animal(
  id: 7,
  farmId: 1,
  tag: 'COW-07',
  name: 'Nora',
  species: AnimalSpecies.cattle,
  breed: 'Friesian',
  sex: AnimalSex.female,
  status: AnimalStatus.active,
  createdAt: DateTime(2025),
  updatedAt: DateTime(2025),
);

void main() {
  testWidgets('unauthenticated routing presents the branded sign-in page', (
    tester,
  ) async {
    await tester.pumpWidget(
      MaterialApp(
        home: SignInPage(
          busy: false,
          onBusy: _noop,
          onRetry: _noopAsync,
        ),
      ),
    );
    expect(find.text('Welcome to Mavuno'), findsOneWidget);
    expect(
      find.text('Sign in or create your farmer account to continue.'),
      findsOneWidget,
    );
  });

  testWidgets('farm onboarding validates required farm name', (tester) async {
    await tester.pumpWidget(
      MaterialApp(
        home: FarmOnboardingPage(onCreate: _createFarm, onSignOut: _noopAsync),
      ),
    );
    await tester.ensureVisible(find.text('Create farm'));
    await tester.tap(find.text('Create farm'));
    await tester.pump();
    expect(find.text('Enter your farm name.'), findsOneWidget);
  });

  testWidgets(
    'dashboard shows real empty livestock state and no fabricated health score',
    (tester) async {
      tester.view.physicalSize = const Size(1100, 900);
      tester.view.devicePixelRatio = 1;
      addTearDown(tester.view.resetPhysicalSize);
      addTearDown(tester.view.resetDevicePixelRatio);
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: DashboardPage(
              farm: _farm(),
              onAddAnimal: () {},
              onAnimal: (_) {},
              onViewLivestock: () {},
              onSignOut: _noopAsync,
              loadData: () async =>
                  DashboardData(const [], const [], const [], const []),
            ),
          ),
        ),
      );
      await tester.pumpAndSettle();
      expect(find.text('No livestock added yet.'), findsOneWidget);
      expect(find.text('Learning'), findsOneWidget);
      expect(find.text('No risk assessments yet'), findsOneWidget);
      expect(find.textContaining('Health score'), findsNothing);
    },
  );

  testWidgets(
    'livestock renders persisted animal identity and honest assessment state',
    (tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: LivestockPage(
              farm: _farm(),
              onAnimal: (_) {},
              onAddAnimal: () {},
              loadAnimals: () async => [_animal()],
            ),
          ),
        ),
      );
      await tester.pumpAndSettle();
      expect(find.textContaining('COW-07'), findsOneWidget);
      expect(find.textContaining('Friesian'), findsOneWidget);
      expect(find.text('Not assessed'), findsOneWidget);
    },
  );

  testWidgets('animal form validates required tag', (tester) async {
    await tester.pumpWidget(
      const MaterialApp(home: Scaffold(body: AddAnimalDialog(farmId: 1))),
    );
    await tester.ensureVisible(find.text('Save animal'));
    await tester.tap(find.text('Save animal'));
    await tester.pump();
    expect(find.text('Enter an animal tag.'), findsOneWidget);
  });

  testWidgets(
    'observation form renders field scales and validates temperature',
    (tester) async {
      await tester.pumpWidget(
        const MaterialApp(home: Scaffold(body: ObservationDialog(animalId: 7))),
      );
      expect(find.text('Log observation'), findsOneWidget);
      expect(find.text('Symptoms'), findsOneWidget);
      await tester.enterText(
        find.widgetWithText(TextFormField, 'Temperature (°C)'),
        '99',
      );
      await tester.tap(find.text('Save observation'));
      await tester.pump();
      expect(
        find.text('Enter a temperature from 30 to 45 °C.'),
        findsOneWidget,
      );
    },
  );

  testWidgets('milk form renders litres and rejects empty quantity', (
    tester,
  ) async {
    await tester.pumpWidget(
      const MaterialApp(home: Scaffold(body: ProductionDialog(animalId: 7))),
    );
    expect(find.text('Record milk'), findsOneWidget);
    expect(find.text('Quantity (litres)'), findsOneWidget);
    await tester.tap(find.text('Save milk'));
    await tester.pump();
    expect(find.text('Enter a quantity greater than zero.'), findsOneWidget);
  });
}

void _noop(bool value) {}
Future<void> _noopAsync() async {}
Future<void> _createFarm({
  required String name,
  String? location,
  required String type,
  required String activities,
  required String livestock,
}) async {}
