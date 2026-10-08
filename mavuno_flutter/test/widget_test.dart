import 'dart:async';

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
              loadData: () async => DashboardData(
                FarmDashboardSnapshot(
                  animals: const [],
                  assessments: const [],
                  alerts: const [],
                  tasks: const [],
                  observations: const [],
                  production: const [],
                ),
              ),
            ),
          ),
        ),
      );
      await tester.pumpAndSettle();
      expect(find.text('No livestock added yet.'), findsOneWidget);
      expect(find.text('Not assessed yet'), findsOneWidget);
      expect(find.textContaining('Health score'), findsNothing);
    },
  );

  testWidgets('dashboard refreshes from authorized intelligence events', (
    tester,
  ) async {
    final events = StreamController<FarmIntelligenceChanged>();
    var loads = 0;
    await tester.pumpWidget(
      MaterialApp(
        home: DashboardPage(
          farm: _farm(),
          onAddAnimal: () {},
          onAnimal: (_) {},
          onViewLivestock: () {},
          onSignOut: _noopAsync,
          loadData: () async {
            loads++;
            return _emptyDashboard();
          },
          watchIntelligence: (_) => events.stream,
        ),
      ),
    );
    await tester.pump();
    await tester.pump();
    expect(loads, 1);

    events.add(FarmIntelligenceChanged(farmId: 999));
    await tester.pump();
    expect(loads, 1);

    events.add(FarmIntelligenceChanged(farmId: 1));
    await tester.pump();
    await tester.pump();
    expect(loads, 2);

    await tester.pumpWidget(const SizedBox.shrink());
    expect(events.hasListener, isFalse);
  });

  testWidgets('dashboard stays usable when its intelligence stream fails', (
    tester,
  ) async {
    final events = StreamController<FarmIntelligenceChanged>();
    await tester.pumpWidget(
      MaterialApp(
        home: DashboardPage(
          farm: _farm(),
          onAddAnimal: () {},
          onAnimal: (_) {},
          onViewLivestock: () {},
          onSignOut: _noopAsync,
          loadData: () async => _emptyDashboard(),
          watchIntelligence: (_) => events.stream,
        ),
      ),
    );
    await tester.pump();
    await tester.pump();
    events.addError(StateError('offline'));
    await tester.pump();
    expect(find.text('Green Valley Farm'), findsOneWidget);

    await tester.pumpWidget(const SizedBox.shrink());
  });

  testWidgets('switching farms cancels the old intelligence stream', (
    tester,
  ) async {
    final firstFarmEvents = StreamController<FarmIntelligenceChanged>();
    final secondFarmEvents = StreamController<FarmIntelligenceChanged>();
    var farm = _farm();
    var loads = 0;

    await tester.pumpWidget(
      MaterialApp(
        home: StatefulBuilder(
          builder: (context, setState) => Column(
            children: [
              TextButton(
                onPressed: () => setState(
                  () => farm = farm.copyWith(id: 2, name: 'Second farm'),
                ),
                child: const Text('Switch farm'),
              ),
              Expanded(
                child: DashboardPage(
                  farm: farm,
                  onAddAnimal: () {},
                  onAnimal: (_) {},
                  onViewLivestock: () {},
                  onSignOut: _noopAsync,
                  loadData: () async {
                    loads++;
                    return _emptyDashboard();
                  },
                  watchIntelligence: (farmId) => farmId == 1
                      ? firstFarmEvents.stream
                      : secondFarmEvents.stream,
                ),
              ),
            ],
          ),
        ),
      ),
    );
    await tester.pump();
    await tester.pump();
    expect(firstFarmEvents.hasListener, isTrue);

    await tester.tap(find.text('Switch farm'));
    await tester.pump();
    await tester.pump();
    expect(firstFarmEvents.hasListener, isFalse);
    expect(secondFarmEvents.hasListener, isTrue);

    firstFarmEvents.add(FarmIntelligenceChanged(farmId: 1));
    await tester.pump();
    expect(loads, 2);
    secondFarmEvents.add(FarmIntelligenceChanged(farmId: 2));
    await tester.pump();
    expect(loads, 3);

    await tester.pumpWidget(const SizedBox.shrink());
    expect(secondFarmEvents.hasListener, isFalse);
  });

  testWidgets('dashboard prioritizes the latest critical animal assessment', (
    tester,
  ) async {
    tester.view.physicalSize = const Size(1200, 2200);
    tester.view.devicePixelRatio = 1;
    addTearDown(tester.view.resetPhysicalSize);
    addTearDown(tester.view.resetDevicePixelRatio);
    final nora = _animal();
    final cattle = nora.copyWith(id: 8, tag: 'COW-08', name: 'Malaika');
    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: DashboardPage(
            farm: _farm(),
            onAddAnimal: () {},
            onAnimal: (_) {},
            onViewLivestock: () {},
            onSignOut: _noopAsync,
            loadData: () async => DashboardData(
              FarmDashboardSnapshot(
                animals: [nora, cattle],
                assessments: [
                  SentinelAssessment(
                    id: 1,
                    farmId: 1,
                    animalId: 7,
                    assessedAt: DateTime(2025, 1, 1),
                    riskScore: 1,
                    riskLevel: RiskLevel.moderate,
                    detectedSignals: '[]',
                    baselineSummary: '',
                    explanation: '',
                    recommendedAction: '',
                  ),
                  SentinelAssessment(
                    id: 2,
                    farmId: 1,
                    animalId: 7,
                    assessedAt: DateTime(2025, 1, 2),
                    riskScore: 4,
                    riskLevel: RiskLevel.critical,
                    detectedSignals: '[{"title":"Elevated temperature"}]',
                    baselineSummary: '',
                    explanation: '',
                    recommendedAction: '',
                  ),
                  SentinelAssessment(
                    id: 3,
                    farmId: 1,
                    animalId: 8,
                    assessedAt: DateTime(2025, 1, 2),
                    riskScore: 0,
                    riskLevel: RiskLevel.low,
                    detectedSignals: '[]',
                    baselineSummary: '',
                    explanation: '',
                    recommendedAction: '',
                  ),
                ],
                alerts: [
                  FarmAlert(
                    farmId: 1,
                    animalId: 7,
                    severity: AlertSeverity.critical,
                    alertType: AlertType.health,
                    title: 'Farm Sentinel · CRITICAL',
                    description: 'Elevated temperature',
                    createdAt: DateTime(2025, 1, 2),
                  ),
                ],
                tasks: [
                  FarmTask(
                    farmId: 1,
                    animalId: 7,
                    title: 'Sentinel follow-up · COW-07',
                    description: 'Record follow-up observation',
                    priority: TaskPriority.urgent,
                    status: TaskStatus.open,
                    createdAt: DateTime(2025, 1, 2),
                  ),
                ],
                observations: [
                  AnimalObservation(
                    animalId: 7,
                    recordedAt: DateTime(2025, 1, 2),
                    temperature: 40.1,
                    appetiteScore: 2,
                    recordedBy: 'tester',
                  ),
                ],
                production: [
                  ProductionRecord(
                    animalId: 7,
                    recordedAt: DateTime(2025, 1, 1),
                    metricType: 'milk',
                    value: 10,
                    unit: 'L',
                  ),
                  ProductionRecord(
                    animalId: 7,
                    recordedAt: DateTime(2025, 1, 2),
                    metricType: 'milk',
                    value: 4.5,
                    unit: 'L',
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
    await tester.pumpAndSettle();
    expect(find.text('2 assessed · 0 not assessed'), findsOneWidget);
    expect(find.text('CRITICAL'), findsNWidgets(2));
    expect(find.textContaining('Elevated temperature'), findsNWidgets(2));
    expect(find.textContaining('1 need attention'), findsOneWidget);
    expect(find.textContaining('Farm Sentinel'), findsNWidgets(2));
    expect(find.text('Sentinel follow-up · COW-07'), findsOneWidget);
    expect(find.textContaining('Appetite 2/10'), findsOneWidget);
    expect(find.textContaining('10.00 L → 4.50 L'), findsOneWidget);
    expect(find.text('↓ 55%'), findsOneWidget);
  });

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

  testWidgets('AI explanation is separate from the deterministic result', (
    tester,
  ) async {
    final assessment = SentinelAssessment(
      farmId: 1,
      animalId: 7,
      assessedAt: DateTime(2026, 1, 1),
      riskScore: 2,
      riskLevel: RiskLevel.high,
      detectedSignals: '[{"title":"Elevated temperature","evidence":"40.1°C"}]',
      baselineSummary: 'latest observation',
      explanation: 'deterministic',
      recommendedAction: 'Monitor closely and record a follow-up observation.',
    );
    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: SentinelAssessmentPanel(
            assessment: assessment,
            explanation: SentinelAiExplanation(
              summary: 'Mavuno flagged Nora from the recorded evidence.',
              whyFlagged: 'The observation recorded 40.1°C.',
              signals: ['Elevated temperature'],
              whatToWatch: 'Record another observation.',
              limitations: 'This is not a diagnosis.',
            ),
            loading: false,
            unavailable: false,
            onExplain: _noopAsync,
          ),
        ),
      ),
    );
    expect(find.text('Mavuno Sentinel assessment'), findsOneWidget);
    expect(find.text('AI explanation'), findsOneWidget);
    expect(find.text('High'), findsOneWidget);
    expect(find.textContaining('40.1'), findsWidgets);
    expect(find.text(assessment.recommendedAction), findsOneWidget);
    expect(find.text('This is not a diagnosis.'), findsOneWidget);
  });

  testWidgets(
    'AI explanation loading and unavailable states keep risk visible',
    (
      tester,
    ) async {
      final assessment = SentinelAssessment(
        farmId: 1,
        animalId: 7,
        assessedAt: DateTime(2026, 1, 1),
        riskScore: 2,
        riskLevel: RiskLevel.critical,
        detectedSignals: '[]',
        baselineSummary: '',
        explanation: 'deterministic',
        recommendedAction: 'Contact a livestock professional.',
      );
      Widget panel({required bool loading, required bool unavailable}) =>
          MaterialApp(
            home: Scaffold(
              body: SentinelAssessmentPanel(
                assessment: assessment,
                explanation: null,
                loading: loading,
                unavailable: unavailable,
                onExplain: _noopAsync,
              ),
            ),
          );

      await tester.pumpWidget(panel(loading: true, unavailable: false));
      expect(find.text('Critical'), findsOneWidget);
      expect(find.text('Preparing an explanation…'), findsOneWidget);
      expect(find.text(assessment.recommendedAction), findsOneWidget);

      await tester.pumpWidget(panel(loading: false, unavailable: true));
      expect(find.text('Critical'), findsOneWidget);
      expect(
        find.text('AI explanation currently unavailable.'),
        findsOneWidget,
      );
      expect(find.text(assessment.recommendedAction), findsOneWidget);
    },
  );

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

DashboardData _emptyDashboard() => DashboardData(
  FarmDashboardSnapshot(
    animals: const [],
    assessments: const [],
    alerts: const [],
    tasks: const [],
    observations: const [],
    production: const [],
  ),
);

void _noop(bool value) {}
Future<void> _noopAsync() async {}
Future<void> _createFarm({
  required String name,
  String? location,
  required String type,
  required String activities,
  required String livestock,
}) async {}
