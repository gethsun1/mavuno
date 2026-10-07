import 'package:flutter/material.dart';
import 'package:mavuno_client/mavuno_client.dart';
import 'package:serverpod_auth_idp_flutter/serverpod_auth_idp_flutter.dart';

import '../client.dart';
import 'field_record_dialogs.dart';

const _green = Color(0xFF315D42);
const _muted = Color(0xFF777A70);

class SignInPage extends StatefulWidget {
  const SignInPage({
    super.key,
    required this.busy,
    required this.onBusy,
    this.client,
    this.error,
    required this.onRetry,
  });
  final bool busy;
  final ValueChanged<bool> onBusy;
  final Client? client;
  final Object? error;
  final Future<void> Function() onRetry;
  @override
  State<SignInPage> createState() => _SignInPageState();
}

class _SignInPageState extends State<SignInPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(24),
            child: ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: 1040),
              child: LayoutBuilder(
                builder: (context, box) {
                  final wide = box.maxWidth > 700;
                  final brand = Container(
                    padding: const EdgeInsets.all(36),
                    decoration: BoxDecoration(
                      color: const Color(0xFFE8EDE4),
                      borderRadius: BorderRadius.circular(24),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Image.asset('assets/mavuno-logo.png', width: 210),
                        const SizedBox(height: 32),
                        const Text(
                          'Farm intelligence,\\nfrom soil to decision.',
                          style: TextStyle(
                            fontSize: 34,
                            height: 1.1,
                            fontWeight: FontWeight.w700,
                            color: Color(0xFF203B2D),
                          ),
                        ),
                        const SizedBox(height: 16),
                        const Text(
                          'Understand your farm. Detect risks earlier. Make better decisions.',
                          style: TextStyle(
                            fontSize: 16,
                            height: 1.5,
                            color: Color(0xFF566458),
                          ),
                        ),
                        if (wide) ...[
                          const SizedBox(height: 40),
                          const _BrandNote(
                            icon: Icons.eco_outlined,
                            title: 'One clear view',
                            body:
                                'Keep your livestock, farm records and daily priorities together.',
                          ),
                        ],
                      ],
                    ),
                  );
                  final auth = Padding(
                    padding: EdgeInsets.symmetric(
                      horizontal: wide ? 24 : 4,
                      vertical: 12,
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Welcome to Mavuno',
                          style: Theme.of(context).textTheme.headlineSmall
                              ?.copyWith(fontWeight: FontWeight.w700),
                        ),
                        const SizedBox(height: 8),
                        const Text(
                          'Sign in or create your farmer account to continue.',
                          style: TextStyle(color: _muted),
                        ),
                        const SizedBox(height: 24),
                        widget.client == null
                            ? const _SignInPrompt()
                            : SignInWidget(
                                client: widget.client!,
                                onAuthenticated: () => widget.onBusy(false),
                                onError: (error) {
                                  widget.onBusy(false);
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBar(
                                      content: Text(_friendlyError(error)),
                                    ),
                                  );
                                },
                              ),
                        if (widget.error != null) ...[
                          const SizedBox(height: 18),
                          ErrorBanner(
                            message: _friendlyError(widget.error!),
                            onRetry: widget.onRetry,
                          ),
                        ],
                      ],
                    ),
                  );
                  if (!wide)
                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [brand, const SizedBox(height: 28), auth],
                    );
                  return Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Expanded(flex: 11, child: brand),
                      const SizedBox(width: 32),
                      Expanded(flex: 9, child: auth),
                    ],
                  );
                },
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class _SignInPrompt extends StatelessWidget {
  const _SignInPrompt();
  @override
  Widget build(BuildContext context) => const Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Text('Email', style: TextStyle(fontWeight: FontWeight.w600)),
      SizedBox(height: 8),
      Text('Your Serverpod sign-in form is ready when you open the app.'),
    ],
  );
}

class FarmOnboardingPage extends StatefulWidget {
  const FarmOnboardingPage({
    super.key,
    required this.onCreate,
    this.error,
    required this.onSignOut,
  });
  final Future<void> Function({
    required String name,
    String? location,
    required String type,
    required String activities,
    required String livestock,
  })
  onCreate;
  final Object? error;
  final Future<void> Function() onSignOut;
  @override
  State<FarmOnboardingPage> createState() => _FarmOnboardingPageState();
}

class _FarmOnboardingPageState extends State<FarmOnboardingPage> {
  final _form = GlobalKey<FormState>();
  final _name = TextEditingController();
  final _location = TextEditingController();
  final _activities = TextEditingController();
  final _livestock = TextEditingController();
  String _type = 'Mixed livestock';
  bool _busy = false;
  @override
  void dispose() {
    _name.dispose();
    _location.dispose();
    _activities.dispose();
    _livestock.dispose();
    super.dispose();
  }

  Future<void> _submit() async {
    if (!_form.currentState!.validate()) return;
    setState(() => _busy = true);
    try {
      await widget.onCreate(
        name: _name.text.trim(),
        location: _location.text.trim().isEmpty ? null : _location.text.trim(),
        type: _type,
        activities: _activities.text,
        livestock: _livestock.text,
      );
    } catch (e) {
      if (mounted)
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(SnackBar(content: Text(_friendlyError(e))));
    } finally {
      if (mounted) setState(() => _busy = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(24),
            child: ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: 650),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Image.asset('assets/mavuno-logo.png', width: 150),
                      const Spacer(),
                      TextButton(
                        onPressed: widget.onSignOut,
                        child: const Text('Sign out'),
                      ),
                    ],
                  ),
                  const SizedBox(height: 32),
                  const StepLabel(number: '01', label: 'YOUR FARM'),
                  const SizedBox(height: 12),
                  Text(
                    'Your farm starts here.',
                    style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  const SizedBox(height: 8),
                  const Text(
                    'A few details help Mavuno organize your records around the way you farm.',
                    style: TextStyle(color: _muted),
                  ),
                  const SizedBox(height: 24),
                  CardSurface(
                    child: Form(
                      key: _form,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          TextFormField(
                            controller: _name,
                            decoration: const InputDecoration(
                              labelText: 'Farm name *',
                              hintText: 'e.g. Green Valley Farm',
                            ),
                            validator: (v) => v == null || v.trim().isEmpty
                                ? 'Enter your farm name.'
                                : null,
                          ),
                          const SizedBox(height: 14),
                          TextFormField(
                            controller: _location,
                            decoration: const InputDecoration(
                              labelText: 'Location',
                              hintText: 'Town, county or region',
                            ),
                            textInputAction: TextInputAction.next,
                          ),
                          const SizedBox(height: 14),
                          DropdownButtonFormField<String>(
                            value: _type,
                            decoration: const InputDecoration(
                              labelText: 'Farm type',
                            ),
                            items:
                                const [
                                      'Mixed livestock',
                                      'Dairy',
                                      'Beef',
                                      'Small ruminants',
                                      'Poultry',
                                      'Mixed farming',
                                      'Other',
                                    ]
                                    .map(
                                      (e) => DropdownMenuItem(
                                        value: e,
                                        child: Text(e),
                                      ),
                                    )
                                    .toList(),
                            onChanged: (v) =>
                                setState(() => _type = v ?? _type),
                          ),
                          const SizedBox(height: 14),
                          TextFormField(
                            controller: _activities,
                            decoration: const InputDecoration(
                              labelText: 'Primary activities',
                              hintText: 'e.g. milk production, breeding',
                            ),
                            textInputAction: TextInputAction.next,
                          ),
                          const SizedBox(height: 14),
                          TextFormField(
                            controller: _livestock,
                            decoration: const InputDecoration(
                              labelText: 'Livestock types',
                              hintText: 'e.g. cattle, sheep',
                            ),
                            onFieldSubmitted: (_) => _submit(),
                          ),
                          if (widget.error != null) ...[
                            const SizedBox(height: 12),
                            ErrorBanner(message: _friendlyError(widget.error!)),
                          ],
                          const SizedBox(height: 20),
                          FilledButton.icon(
                            onPressed: _busy ? null : _submit,
                            icon: _busy
                                ? const SizedBox(
                                    width: 16,
                                    height: 16,
                                    child: CircularProgressIndicator(
                                      strokeWidth: 2,
                                    ),
                                  )
                                : const Icon(Icons.arrow_forward),
                            label: Text(
                              _busy ? 'Creating farm…' : 'Create farm',
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class FarmWorkspace extends StatefulWidget {
  const FarmWorkspace({
    super.key,
    required this.farm,
    required this.onFarmCreated,
    required this.onSignOut,
  });
  final Farm farm;
  final ValueChanged<Farm> onFarmCreated;
  final Future<void> Function() onSignOut;
  @override
  State<FarmWorkspace> createState() => _FarmWorkspaceState();
}

class _FarmWorkspaceState extends State<FarmWorkspace> {
  int _section = 0;
  int? _detailId;
  int _refresh = 0;
  void _changed() => setState(() {
    _refresh++;
  });
  @override
  Widget build(BuildContext context) => LayoutBuilder(
    builder: (context, constraints) {
      final wide = constraints.maxWidth >= 900;
      final detail = _detailId != null;
      final Widget page;
      if (detail) {
        page = AnimalDetailPage(
          farm: widget.farm,
          animalId: _detailId!,
          onBack: () => setState(() => _detailId = null),
        );
      } else if (_section == 0) {
        page = DashboardPage(
          key: ValueKey('dashboard$_refresh'),
          farm: widget.farm,
          onAddAnimal: () => _openAddAnimal(context),
          onAnimal: (a) => setState(() {
            _detailId = a.id;
            _section = 1;
          }),
          onViewLivestock: () => setState(() => _section = 1),
          onSignOut: widget.onSignOut,
        );
      } else {
        page = LivestockPage(
          key: ValueKey('livestock$_refresh'),
          farm: widget.farm,
          onAnimal: (a) => setState(() => _detailId = a.id),
          onAddAnimal: () => _openAddAnimal(context),
        );
      }
      return Scaffold(
        body: SafeArea(
          child: Row(
            children: [
              if (wide)
                _SideNav(
                  selected: _section,
                  onSelect: (v) => setState(() {
                    _section = v;
                    _detailId = null;
                  }),
                  onSignOut: widget.onSignOut,
                ),
              Expanded(
                child: Column(
                  children: [
                    if (!wide)
                      _MobileTopBar(
                        farm: widget.farm,
                        onSignOut: widget.onSignOut,
                      ),
                    Expanded(child: page),
                  ],
                ),
              ),
            ],
          ),
        ),
        bottomNavigationBar: wide
            ? null
            : NavigationBar(
                selectedIndex: _section,
                onDestinationSelected: (v) => setState(() {
                  _section = v;
                  _detailId = null;
                }),
                destinations: const [
                  NavigationDestination(
                    icon: Icon(Icons.grid_view_outlined),
                    selectedIcon: Icon(Icons.grid_view),
                    label: 'Overview',
                  ),
                  NavigationDestination(
                    icon: Icon(Icons.pets_outlined),
                    selectedIcon: Icon(Icons.pets),
                    label: 'Livestock',
                  ),
                ],
              ),
      );
    },
  );
  Future<void> _openAddAnimal(BuildContext context) async {
    final added = await showDialog<bool>(
      context: context,
      builder: (_) => AddAnimalDialog(farmId: widget.farm.id!),
    );
    if (added == true) _changed();
  }
}

class DashboardPage extends StatefulWidget {
  const DashboardPage({
    super.key,
    required this.farm,
    required this.onAddAnimal,
    required this.onAnimal,
    required this.onViewLivestock,
    required this.onSignOut,
    this.loadData,
  });
  final Farm farm;
  final Future<DashboardData> Function()? loadData;
  final VoidCallback onAddAnimal;
  final ValueChanged<Animal> onAnimal;
  final VoidCallback onViewLivestock;
  final Future<void> Function() onSignOut;
  @override
  State<DashboardPage> createState() => _DashboardPageState();
}

class _DashboardPageState extends State<DashboardPage> {
  late Future<DashboardData> _data;
  @override
  void initState() {
    super.initState();
    _data = widget.loadData?.call() ?? _load();
  }

  Future<DashboardData> _load() async {
    final farmId = widget.farm.id!;
    final values = await Future.wait<Object>([
      client.animal.listByFarm(farmId),
      client.alert.listActive(farmId),
      client.task.list(farmId),
    ]).timeout(const Duration(seconds: 25));
    final animals = values[0] as List<Animal>;
    final alerts = values[1] as List<FarmAlert>;
    final today = DateTime.now();
    final startOfToday = DateTime(today.year, today.month, today.day);
    final startOfTomorrow = startOfToday.add(const Duration(days: 1));
    final tasks = (values[2] as List<FarmTask>).where((task) {
      final due = task.dueAt?.toLocal();
      return task.status == TaskStatus.open &&
          due != null &&
          due.isBefore(startOfTomorrow);
    }).toList();
    final observations = await Future.wait(
      animals.map(
        (a) => client.observation
            .listByAnimal(a.id!, limit: 1)
            .catchError((_) => <AnimalObservation>[]),
      ),
    );
    final activity = <_Activity>[];
    for (var i = 0; i < animals.length; i++) {
      activity.add(
        _Activity(
          animals[i].createdAt,
          'Livestock added',
          '${animals[i].tag}${animals[i].name == null ? '' : ' · ${animals[i].name}'}',
          Icons.pets_outlined,
        ),
      );
      if (observations[i].isNotEmpty)
        activity.add(
          _Activity(
            observations[i].first.recordedAt,
            'Observation recorded',
            animals[i].tag,
            Icons.monitor_heart_outlined,
          ),
        );
    }
    for (final a in alerts) {
      activity.add(
        _Activity(
          a.createdAt,
          'Farm alert',
          a.title,
          Icons.notifications_active_outlined,
        ),
      );
    }
    activity.sort((a, b) => b.date.compareTo(a.date));
    return DashboardData(animals, alerts, tasks, activity.take(5).toList());
  }

  @override
  Widget build(BuildContext context) => FutureBuilder<DashboardData>(
    future: _data,
    builder: (context, snap) {
      if (snap.connectionState != ConnectionState.done && !snap.hasError)
        return const LoadingPage(label: 'Loading your farm');
      if (snap.hasError)
        return ErrorPage(
          error: snap.error!,
          onRetry: () async {
            setState(() => _data = widget.loadData?.call() ?? _load());
          },
        );
      final data = snap.data!;
      final width = MediaQuery.sizeOf(context).width;
      final columns = width > 1200
          ? 4
          : width > 700
          ? 2
          : 2;
      return ListView(
        padding: EdgeInsets.symmetric(
          horizontal: width < 600 ? 18 : 36,
          vertical: 26,
        ),
        children: [
          HeaderRow(
            eyebrow: 'FARM OVERVIEW',
            title: widget.farm.name,
            subtitle: [
              widget.farm.location,
              widget.farm.farmType,
            ].where((v) => v != null && v.isNotEmpty).join('  ·  '),
            action: FilledButton.icon(
              onPressed: widget.onAddAnimal,
              icon: const Icon(Icons.add),
              label: const Text('Add livestock'),
            ),
          ),
          const SizedBox(height: 24),
          GridView.count(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            crossAxisCount: columns,
            crossAxisSpacing: 12,
            mainAxisSpacing: 12,
            childAspectRatio: width > 600 ? 1.9 : 1.55,
            children: [
              MetricCard(
                icon: Icons.pets_outlined,
                label: 'TOTAL LIVESTOCK',
                value: '${data.animals.length}',
                footnote: 'Across your farm',
              ),
              MetricCard(
                icon: Icons.notifications_none,
                label: 'ACTIVE ALERTS',
                value: '${data.alerts.length}',
                footnote: data.alerts.isEmpty
                    ? 'Everything is quiet'
                    : 'Needs your attention',
                tone: data.alerts.isEmpty ? _green : const Color(0xFFAD573B),
              ),
              MetricCard(
                icon: Icons.checklist_outlined,
                label: "TODAY'S TASKS",
                value: '${data.tasks.length}',
                footnote: data.tasks.isEmpty ? 'No open tasks' : 'Open tasks',
              ),
              MetricCard(
                icon: Icons.insights_outlined,
                label: 'FARM SENTINEL',
                value: 'Learning',
                footnote: 'No risk assessments yet',
              ),
            ],
          ),
          const SizedBox(height: 24),
          if (data.animals.isEmpty)
            EmptyState(
              icon: Icons.agriculture_outlined,
              title: 'No livestock added yet.',
              body:
                  'Add your first animal to start building a picture of your farm.',
              actionLabel: 'Add livestock',
              onAction: widget.onAddAnimal,
            )
          else
            _PanelSection(
              title: 'Your livestock',
              trailing: TextButton(
                onPressed: widget.onViewLivestock,
                child: const Text('View all'),
              ),
              child: Column(
                children: data.animals
                    .take(4)
                    .map(
                      (a) =>
                          AnimalRow(animal: a, onTap: () => widget.onAnimal(a)),
                    )
                    .toList(),
              ),
            ),
          const SizedBox(height: 18),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: _PanelSection(
                  title: 'Active alerts',
                  child: data.alerts.isEmpty
                      ? const EmptyCompact(
                          icon: Icons.notifications_none,
                          text: 'Everything is quiet. No active alerts.',
                        )
                      : Column(
                          children: data.alerts
                              .take(3)
                              .map(
                                (a) => ListTile(
                                  contentPadding: EdgeInsets.zero,
                                  leading: const Icon(
                                    Icons.warning_amber,
                                    color: Color(0xFFAD573B),
                                  ),
                                  title: Text(a.title),
                                  subtitle: Text(
                                    a.description,
                                    maxLines: 2,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                ),
                              )
                              .toList(),
                        ),
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: _PanelSection(
                  title: 'Recent activity',
                  child: data.activity.isEmpty
                      ? const EmptyCompact(
                          icon: Icons.history,
                          text:
                              'Farm activity will appear here as records are added.',
                        )
                      : Column(
                          children: data.activity
                              .map(
                                (a) => ListTile(
                                  contentPadding: EdgeInsets.zero,
                                  leading: Icon(a.icon, color: _green),
                                  title: Text(a.title),
                                  subtitle: Text(
                                    '${a.body} · ${_date(a.date)}',
                                  ),
                                ),
                              )
                              .toList(),
                        ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 20),
        ],
      );
    },
  );
}

class DashboardData {
  DashboardData(this.animals, this.alerts, this.tasks, this.activity);
  final List<Animal> animals;
  final List<FarmAlert> alerts;
  final List<FarmTask> tasks;
  final List<_Activity> activity;
}

class _Activity {
  _Activity(this.date, this.title, this.body, this.icon);
  final DateTime date;
  final String title, body;
  final IconData icon;
}

class LivestockPage extends StatefulWidget {
  const LivestockPage({
    super.key,
    required this.farm,
    required this.onAnimal,
    required this.onAddAnimal,
    this.loadAnimals,
  });
  final Farm farm;
  final Future<List<Animal>> Function()? loadAnimals;
  final ValueChanged<Animal> onAnimal;
  final VoidCallback onAddAnimal;
  @override
  State<LivestockPage> createState() => _LivestockPageState();
}

class _LivestockPageState extends State<LivestockPage> {
  late Future<List<Animal>> _animals;
  @override
  void initState() {
    super.initState();
    _animals =
        widget.loadAnimals?.call() ?? client.animal.listByFarm(widget.farm.id!);
  }

  @override
  Widget build(BuildContext context) => FutureBuilder<List<Animal>>(
    future: _animals,
    builder: (context, snap) {
      if (snap.connectionState != ConnectionState.done && !snap.hasError)
        return const LoadingPage(label: 'Loading livestock');
      if (snap.hasError)
        return ErrorPage(
          error: snap.error!,
          onRetry: () async {
            setState(
              () => _animals =
                  widget.loadAnimals?.call() ??
                  client.animal.listByFarm(widget.farm.id!),
            );
          },
        );
      final animals = snap.data!;
      return ListView(
        padding: const EdgeInsets.all(28),
        children: [
          HeaderRow(
            eyebrow: 'FARM RECORDS',
            title: 'Livestock',
            subtitle: '${animals.length} animals registered',
            action: FilledButton.icon(
              onPressed: widget.onAddAnimal,
              icon: const Icon(Icons.add),
              label: const Text('Add animal'),
            ),
          ),
          const SizedBox(height: 24),
          if (animals.isEmpty)
            EmptyState(
              icon: Icons.pets_outlined,
              title: 'No livestock added yet.',
              body:
                  'Add your first animal to keep its identity and history in one place.',
              actionLabel: 'Add an animal',
              onAction: widget.onAddAnimal,
            )
          else
            CardSurface(
              padding: EdgeInsets.zero,
              child: Column(
                children: animals
                    .map(
                      (a) => AnimalRow(
                        animal: a,
                        onTap: () => widget.onAnimal(a),
                        trailing: const StatusBadge(
                          label: 'Not assessed',
                          color: Color(0xFF6E746A),
                        ),
                      ),
                    )
                    .toList(),
              ),
            ),
        ],
      );
    },
  );
}

class AddAnimalDialog extends StatefulWidget {
  const AddAnimalDialog({super.key, required this.farmId});
  final int farmId;
  @override
  State<AddAnimalDialog> createState() => _AddAnimalDialogState();
}

class _AddAnimalDialogState extends State<AddAnimalDialog> {
  final _form = GlobalKey<FormState>();
  final _tag = TextEditingController();
  final _name = TextEditingController();
  final _breed = TextEditingController();
  final _notes = TextEditingController();
  AnimalSpecies _species = AnimalSpecies.cattle;
  AnimalSex _sex = AnimalSex.female;
  DateTime? _birth;
  bool _busy = false;
  @override
  void dispose() {
    _tag.dispose();
    _name.dispose();
    _breed.dispose();
    _notes.dispose();
    super.dispose();
  }

  Future<void> _save() async {
    if (!_form.currentState!.validate()) return;
    setState(() => _busy = true);
    try {
      await client.animal
          .create(
            widget.farmId,
            _tag.text.trim(),
            _species,
            _sex,
            name: _name.text.trim().isEmpty ? null : _name.text.trim(),
            breed: _breed.text.trim().isEmpty ? null : _breed.text.trim(),
            dateOfBirth: _birth,
            status: AnimalStatus.active,
            notes: _notes.text.trim().isEmpty ? null : _notes.text.trim(),
          )
          .timeout(const Duration(seconds: 20));
      if (mounted) Navigator.pop(context, true);
    } catch (e) {
      if (mounted) {
        setState(() => _busy = false);
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(SnackBar(content: Text(_friendlyError(e))));
      }
    }
  }

  @override
  Widget build(BuildContext context) => AlertDialog(
    title: const Text('Add livestock'),
    content: SizedBox(
      width: 480,
      child: SingleChildScrollView(
        child: Form(
          key: _form,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextFormField(
                controller: _tag,
                decoration: const InputDecoration(
                  labelText: 'Animal tag *',
                  hintText: 'e.g. COW-07',
                ),
                validator: (v) => v == null || v.trim().isEmpty
                    ? 'Enter an animal tag.'
                    : null,
              ),
              const SizedBox(height: 10),
              DropdownButtonFormField<AnimalSpecies>(
                value: _species,
                decoration: const InputDecoration(labelText: 'Species'),
                items: AnimalSpecies.values
                    .map(
                      (e) => DropdownMenuItem(
                        value: e,
                        child: Text(_speciesName(e)),
                      ),
                    )
                    .toList(),
                onChanged: (v) => setState(() => _species = v ?? _species),
              ),
              const SizedBox(height: 10),
              TextFormField(
                controller: _breed,
                decoration: const InputDecoration(labelText: 'Breed'),
              ),
              const SizedBox(height: 10),
              DropdownButtonFormField<AnimalSex>(
                value: _sex,
                decoration: const InputDecoration(labelText: 'Sex'),
                items: AnimalSex.values
                    .map(
                      (e) => DropdownMenuItem(
                        value: e,
                        child: Text(_title(e.name)),
                      ),
                    )
                    .toList(),
                onChanged: (v) => setState(() => _sex = v ?? _sex),
              ),
              const SizedBox(height: 10),
              TextFormField(
                controller: _name,
                decoration: const InputDecoration(labelText: 'Name (optional)'),
              ),
              const SizedBox(height: 10),
              TextFormField(
                controller: _notes,
                decoration: const InputDecoration(
                  labelText: 'Notes (optional)',
                ),
              ),
              const SizedBox(height: 12),
              Row(
                children: [
                  const Expanded(child: Text('Date of birth (optional)')),
                  TextButton.icon(
                    onPressed: () async {
                      final v = await showDatePicker(
                        context: context,
                        firstDate: DateTime(1980),
                        lastDate: DateTime.now(),
                        initialDate: DateTime.now(),
                      );
                      if (v != null) setState(() => _birth = v);
                    },
                    icon: const Icon(Icons.calendar_today_outlined),
                    label: Text(
                      _birth == null ? 'Choose date' : _date(_birth!),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    ),
    actions: [
      TextButton(
        onPressed: _busy ? null : () => Navigator.pop(context, false),
        child: const Text('Cancel'),
      ),
      FilledButton(
        onPressed: _busy ? null : _save,
        child: Text(_busy ? 'Saving…' : 'Save animal'),
      ),
    ],
  );
}

class AnimalDetailPage extends StatefulWidget {
  const AnimalDetailPage({
    super.key,
    required this.farm,
    required this.animalId,
    required this.onBack,
  });
  final Farm farm;
  final int animalId;
  final VoidCallback onBack;
  @override
  State<AnimalDetailPage> createState() => _AnimalDetailPageState();
}

class _AnimalDetailPageState extends State<AnimalDetailPage> {
  late Future<_AnimalData> _data;
  @override
  void initState() {
    super.initState();
    _data = _load();
  }

  Future<_AnimalData> _load() async {
    final a = await client.animal
        .get(widget.animalId)
        .timeout(const Duration(seconds: 20));
    final values = await Future.wait<Object>([
      client.observation.listByAnimal(widget.animalId, limit: 30),
      client.production.listByAnimal(widget.animalId),
      client.health.listByAnimal(widget.animalId),
      client.health.listVaccinations(widget.animalId),
      client.alert.listActive(widget.farm.id!),
    ]).timeout(const Duration(seconds: 25));
    return _AnimalData(
      a,
      values[0] as List<AnimalObservation>,
      values[1] as List<ProductionRecord>,
      values[2] as List<HealthRecord>,
      values[3] as List<VaccinationRecord>,
      (values[4] as List<FarmAlert>)
          .where((v) => v.animalId == widget.animalId)
          .toList(),
      (await client.task.list(
        widget.farm.id!,
      )).where((t) => t.animalId == widget.animalId).toList(),
    );
  }

  Future<void> _openRecordDialog(Widget dialog) async {
    final saved = await showDialog<bool>(
      context: context,
      builder: (_) => dialog,
    );
    if (saved == true && mounted) setState(() => _data = _load());
  }

  @override
  Widget build(BuildContext context) => FutureBuilder<_AnimalData>(
    future: _data,
    builder: (context, snap) {
      if (snap.connectionState != ConnectionState.done && !snap.hasError) {
        return const LoadingPage(label: 'Loading animal records');
      }
      if (snap.hasError) {
        return ErrorPage(
          error: snap.error!,
          onRetry: () async {
            setState(() => _data = _load());
          },
        );
      }
      final d = snap.data!;
      final a = d.animal;
      return ListView(
        padding: const EdgeInsets.all(28),
        children: [
          TextButton.icon(
            onPressed: widget.onBack,
            icon: const Icon(Icons.arrow_back),
            label: const Text('Back to livestock'),
            style: TextButton.styleFrom(alignment: Alignment.centerLeft),
          ),
          const SizedBox(height: 14),
          HeaderRow(
            eyebrow: 'ANIMAL RECORD',
            title: a.name == null ? a.tag : '${a.name} · ${a.tag}',
            subtitle:
                '${_speciesName(a.species)}${a.breed == null ? '' : ' · ${a.breed}'} · ${_title(a.sex.name)}',
            action: StatusBadge(
              label: _title(a.status.name),
              color: a.status == AnimalStatus.active
                  ? _green
                  : const Color(0xFFAA6840),
            ),
          ),
          const SizedBox(height: 14),
          Wrap(
            spacing: 10,
            runSpacing: 8,
            children: [
              FilledButton.icon(
                onPressed: () => _openRecordDialog(
                  ObservationDialog(animalId: widget.animalId),
                ),
                icon: const Icon(Icons.add),
                label: const Text('Log Observation'),
              ),
              OutlinedButton.icon(
                onPressed: () => _openRecordDialog(
                  ProductionDialog(animalId: widget.animalId),
                ),
                icon: const Icon(Icons.water_drop_outlined),
                label: const Text('Record Milk'),
              ),
            ],
          ),
          const SizedBox(height: 20),
          Wrap(
            spacing: 12,
            runSpacing: 12,
            children: [
              InfoChip(
                icon: Icons.cake_outlined,
                text: a.dateOfBirth == null
                    ? 'Age not recorded'
                    : _age(a.dateOfBirth!),
              ),
              const InfoChip(
                icon: Icons.insights_outlined,
                text: 'Not assessed',
              ),
            ],
          ),
          const SizedBox(height: 22),
          _PanelSection(
            title: 'Observations',
            child: d.observations.isEmpty
                ? const EmptyCompact(
                    icon: Icons.monitor_heart_outlined,
                    text: 'No observations recorded yet.',
                  )
                : Column(
                    children: d.observations
                        .map(
                          (o) => ListTile(
                            contentPadding: EdgeInsets.zero,
                            leading: const Icon(
                              Icons.monitor_heart_outlined,
                              color: _green,
                            ),
                            title: Text(_date(o.recordedAt)),
                            subtitle: Text(
                              [
                                if (o.temperature != null)
                                  'Temperature ${o.temperature}°',
                                if (o.activityScore != null)
                                  'Activity ${_activityLabel(o.activityScore!)}',
                                if (o.appetiteScore != null)
                                  'Appetite ${_appetiteLabel(o.appetiteScore!)}',
                                if (o.visibleSymptoms?.isNotEmpty == true)
                                  o.visibleSymptoms!,
                                if (o.notes?.isNotEmpty == true) o.notes!,
                              ].join(' · '),
                            ),
                          ),
                        )
                        .toList(),
                  ),
          ),
          const SizedBox(height: 16),
          _PanelSection(
            title: 'Production history',
            child: d.production.isEmpty
                ? const EmptyCompact(
                    icon: Icons.water_drop_outlined,
                    text: 'No production records yet.',
                  )
                : Column(
                    children: d.production
                        .map(
                          (p) => ListTile(
                            contentPadding: EdgeInsets.zero,
                            leading: const Icon(
                              Icons.water_drop_outlined,
                              color: _green,
                            ),
                            title: Text(
                              '${p.value.toStringAsFixed(1)} ${p.unit} · ${_title(p.metricType)}',
                            ),
                            subtitle: Text(_date(p.recordedAt)),
                          ),
                        )
                        .toList(),
                  ),
          ),
          const SizedBox(height: 16),
          _PanelSection(
            title: 'Health & vaccination',
            child: d.health.isEmpty && d.vaccines.isEmpty
                ? const EmptyCompact(
                    icon: Icons.medical_services_outlined,
                    text: 'No health or vaccination records yet.',
                  )
                : Column(
                    children: [
                      ...d.health.map(
                        (h) => ListTile(
                          contentPadding: EdgeInsets.zero,
                          leading: const Icon(
                            Icons.medical_services_outlined,
                            color: _green,
                          ),
                          title: Text(h.recordType),
                          subtitle: Text(
                            '${_date(h.recordedAt)} · ${h.description}',
                          ),
                        ),
                      ),
                      ...d.vaccines.map(
                        (v) => ListTile(
                          contentPadding: EdgeInsets.zero,
                          leading: const Icon(
                            Icons.vaccines_outlined,
                            color: _green,
                          ),
                          title: Text(v.vaccination),
                          subtitle: Text(
                            'Given ${_date(v.administeredAt)}${v.nextDueAt == null ? '' : ' · Next due ${_date(v.nextDueAt!)}'}',
                          ),
                        ),
                      ),
                    ],
                  ),
          ),
          const SizedBox(height: 16),
          _PanelSection(
            title: 'Alerts & tasks',
            child: d.alerts.isEmpty && d.tasks.isEmpty
                ? const EmptyCompact(
                    icon: Icons.check_circle_outline,
                    text: 'No active alerts or tasks for this animal.',
                  )
                : Column(
                    children: [
                      ...d.alerts.map(
                        (v) => ListTile(
                          contentPadding: EdgeInsets.zero,
                          leading: const Icon(
                            Icons.warning_amber,
                            color: Color(0xFFAD573B),
                          ),
                          title: Text(v.title),
                          subtitle: Text(v.description),
                        ),
                      ),
                      ...d.tasks.map(
                        (t) => ListTile(
                          contentPadding: EdgeInsets.zero,
                          leading: const Icon(
                            Icons.checklist_outlined,
                            color: _green,
                          ),
                          title: Text(t.title),
                          subtitle: Text(t.status.name),
                        ),
                      ),
                    ],
                  ),
          ),
        ],
      );
    },
  );
}

class _AnimalData {
  _AnimalData(
    this.animal,
    this.observations,
    this.production,
    this.health,
    this.vaccines,
    this.alerts,
    this.tasks,
  );
  final Animal animal;
  final List<AnimalObservation> observations;
  final List<ProductionRecord> production;
  final List<HealthRecord> health;
  final List<VaccinationRecord> vaccines;
  final List<FarmAlert> alerts;
  final List<FarmTask> tasks;
}

class _SideNav extends StatelessWidget {
  const _SideNav({
    required this.selected,
    required this.onSelect,
    required this.onSignOut,
  });
  final int selected;
  final ValueChanged<int> onSelect;
  final Future<void> Function() onSignOut;
  @override
  Widget build(BuildContext context) => Container(
    width: 244,
    decoration: const BoxDecoration(color: Color(0xFF203B2D)),
    padding: const EdgeInsets.all(20),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Image.asset('assets/mavuno-logo.png', width: 170, color: Colors.white),
        const SizedBox(height: 38),
        const Text(
          'WORKSPACE',
          style: TextStyle(
            color: Color(0xFFB6C4B8),
            fontSize: 11,
            letterSpacing: 1.3,
            fontWeight: FontWeight.w700,
          ),
        ),
        const SizedBox(height: 12),
        _NavItem(
          icon: Icons.grid_view_outlined,
          label: 'Overview',
          selected: selected == 0,
          onTap: () => onSelect(0),
        ),
        _NavItem(
          icon: Icons.pets_outlined,
          label: 'Livestock',
          selected: selected == 1,
          onTap: () => onSelect(1),
        ),
        const Spacer(),
        const Text(
          'MAVUNO · FARM INTELLIGENCE',
          style: TextStyle(
            color: Color(0xFFB6C4B8),
            fontSize: 10,
            letterSpacing: .5,
          ),
        ),
        const SizedBox(height: 12),
        TextButton.icon(
          onPressed: onSignOut,
          icon: const Icon(Icons.logout, color: Colors.white70),
          label: const Text(
            'Sign out',
            style: TextStyle(color: Colors.white70),
          ),
        ),
      ],
    ),
  );
}

class _NavItem extends StatelessWidget {
  const _NavItem({
    required this.icon,
    required this.label,
    required this.selected,
    required this.onTap,
  });
  final IconData icon;
  final String label;
  final bool selected;
  final VoidCallback onTap;
  @override
  Widget build(BuildContext context) => Material(
    color: Colors.transparent,
    child: ListTile(
      leading: Icon(
        icon,
        color: selected ? const Color(0xFF203B2D) : Colors.white70,
      ),
      title: Text(
        label,
        style: TextStyle(
          color: selected ? const Color(0xFF203B2D) : Colors.white,
        ),
      ),
      selected: selected,
      selectedTileColor: const Color(0xFFE4EAE2),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      onTap: onTap,
    ),
  );
}

class _MobileTopBar extends StatelessWidget {
  const _MobileTopBar({required this.farm, required this.onSignOut});
  final Farm farm;
  final Future<void> Function() onSignOut;
  @override
  Widget build(BuildContext context) => Padding(
    padding: const EdgeInsets.fromLTRB(16, 12, 16, 4),
    child: Row(
      children: [
        Image.asset('assets/mavuno-logo.png', width: 126),
        const Spacer(),
        Text(farm.name, style: const TextStyle(fontWeight: FontWeight.w600)),
        PopupMenuButton<String>(
          onSelected: (_) => onSignOut(),
          itemBuilder: (_) => const [
            PopupMenuItem(value: 'out', child: Text('Sign out')),
          ],
          icon: const Icon(Icons.more_vert),
        ),
      ],
    ),
  );
}

class CardSurface extends StatelessWidget {
  const CardSurface({
    super.key,
    required this.child,
    this.padding = const EdgeInsets.all(20),
  });
  final Widget child;
  final EdgeInsetsGeometry padding;
  @override
  Widget build(BuildContext context) => Container(
    padding: padding,
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(16),
      border: Border.all(color: const Color(0xFFE7E8E0)),
    ),
    child: child,
  );
}

class MetricCard extends StatelessWidget {
  const MetricCard({
    super.key,
    required this.icon,
    required this.label,
    required this.value,
    required this.footnote,
    this.tone = _green,
  });
  final IconData icon;
  final String label, value, footnote;
  final Color tone;
  @override
  Widget build(BuildContext context) => CardSurface(
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Row(
          children: [
            Icon(icon, color: tone, size: 20),
            const Spacer(),
            Text(
              label,
              style: const TextStyle(
                color: _muted,
                fontSize: 10,
                letterSpacing: .7,
                fontWeight: FontWeight.w700,
              ),
            ),
          ],
        ),
        Text(
          value,
          style: const TextStyle(
            fontSize: 27,
            fontWeight: FontWeight.w700,
            color: Color(0xFF25382B),
          ),
        ),
        Text(footnote, style: const TextStyle(color: _muted, fontSize: 12)),
      ],
    ),
  );
}

class StatusBadge extends StatelessWidget {
  const StatusBadge({super.key, required this.label, required this.color});
  final String label;
  final Color color;
  @override
  Widget build(BuildContext context) => Container(
    padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
    decoration: BoxDecoration(
      color: color.withValues(alpha: .1),
      borderRadius: BorderRadius.circular(20),
    ),
    child: Text(
      label,
      style: TextStyle(color: color, fontSize: 12, fontWeight: FontWeight.w600),
    ),
  );
}

class HeaderRow extends StatelessWidget {
  const HeaderRow({
    super.key,
    required this.eyebrow,
    required this.title,
    required this.subtitle,
    this.action,
  });
  final String eyebrow, title, subtitle;
  final Widget? action;
  @override
  Widget build(BuildContext context) => LayoutBuilder(
    builder: (context, box) => Row(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                eyebrow,
                style: const TextStyle(
                  color: _muted,
                  fontSize: 10,
                  letterSpacing: 1,
                  fontWeight: FontWeight.w700,
                ),
              ),
              const SizedBox(height: 6),
              Text(
                title,
                style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                  fontWeight: FontWeight.w700,
                ),
              ),
              if (subtitle.isNotEmpty)
                Text(subtitle, style: const TextStyle(color: _muted)),
            ],
          ),
        ),
        if (box.maxWidth > 380 && action != null) action!,
      ],
    ),
  );
}

class SectionHeading extends StatelessWidget {
  const SectionHeading(this.title, {super.key});
  final String title;
  @override
  Widget build(BuildContext context) => Text(
    title,
    style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w700),
  );
}

class AnimalRow extends StatelessWidget {
  const AnimalRow({
    super.key,
    required this.animal,
    required this.onTap,
    this.trailing,
  });
  final Animal animal;
  final VoidCallback onTap;
  final Widget? trailing;
  @override
  Widget build(BuildContext context) => Material(
    color: Colors.transparent,
    child: ListTile(
      onTap: onTap,
      leading: CircleAvatar(
        backgroundColor: const Color(0xFFE8EDE4),
        child: Icon(
          animal.species == AnimalSpecies.cattle
              ? Icons.agriculture_outlined
              : Icons.pets_outlined,
          color: _green,
        ),
      ),
      title: Text(
        animal.name == null ? animal.tag : '${animal.name} · ${animal.tag}',
        style: const TextStyle(fontWeight: FontWeight.w600),
      ),
      subtitle: Text(
        '${_speciesName(animal.species)}${animal.breed == null ? '' : ' · ${animal.breed}'} · ${_title(animal.status.name)}',
      ),
      trailing: trailing ?? const Icon(Icons.chevron_right),
    ),
  );
}

class _PanelSection extends StatelessWidget {
  const _PanelSection({
    required this.title,
    required this.child,
    this.trailing,
  });
  final String title;
  final Widget child;
  final Widget? trailing;
  @override
  Widget build(BuildContext context) => CardSurface(
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Row(
          children: [
            Expanded(child: SectionHeading(title)),
            if (trailing != null) trailing!,
          ],
        ),
        const SizedBox(height: 10),
        child,
      ],
    ),
  );
}

class EmptyState extends StatelessWidget {
  const EmptyState({
    super.key,
    required this.icon,
    required this.title,
    required this.body,
    this.actionLabel,
    this.onAction,
  });
  final IconData icon;
  final String title, body;
  final String? actionLabel;
  final VoidCallback? onAction;
  @override
  Widget build(BuildContext context) => CardSurface(
    child: Column(
      children: [
        Icon(icon, size: 36, color: _green),
        const SizedBox(height: 12),
        Text(
          title,
          style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w700),
        ),
        const SizedBox(height: 6),
        Text(
          body,
          textAlign: TextAlign.center,
          style: const TextStyle(color: _muted),
        ),
        if (actionLabel != null) ...[
          const SizedBox(height: 14),
          FilledButton(onPressed: onAction, child: Text(actionLabel!)),
        ],
      ],
    ),
  );
}

class EmptyCompact extends StatelessWidget {
  const EmptyCompact({super.key, required this.icon, required this.text});
  final IconData icon;
  final String text;
  @override
  Widget build(BuildContext context) => Padding(
    padding: const EdgeInsets.symmetric(vertical: 24),
    child: Column(
      children: [
        Icon(icon, color: _muted),
        const SizedBox(height: 8),
        Text(
          text,
          textAlign: TextAlign.center,
          style: const TextStyle(color: _muted),
        ),
      ],
    ),
  );
}

class LoadingPage extends StatelessWidget {
  const LoadingPage({super.key, required this.label});
  final String label;
  @override
  Widget build(BuildContext context) => Scaffold(
    body: Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const CircularProgressIndicator(),
          const SizedBox(height: 16),
          Text(label, style: const TextStyle(color: _muted)),
        ],
      ),
    ),
  );
}

class ErrorPage extends StatelessWidget {
  const ErrorPage({
    super.key,
    required this.error,
    required this.onRetry,
    this.onSignOut,
  });
  final Object error;
  final Future<void> Function() onRetry;
  final Future<void> Function()? onSignOut;
  @override
  Widget build(BuildContext context) => Scaffold(
    body: Center(
      child: Padding(
        padding: const EdgeInsets.all(24),
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 500),
          child: CardSurface(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Icon(Icons.cloud_off_outlined, size: 38, color: _muted),
                const SizedBox(height: 12),
                const Text(
                  'We could not load your farm.',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.w700),
                ),
                const SizedBox(height: 8),
                Text(_friendlyError(error), textAlign: TextAlign.center),
                const SizedBox(height: 16),
                FilledButton.icon(
                  onPressed: onRetry,
                  icon: const Icon(Icons.refresh),
                  label: const Text('Try again'),
                ),
                if (onSignOut != null)
                  TextButton(
                    onPressed: onSignOut,
                    child: const Text('Sign out'),
                  ),
              ],
            ),
          ),
        ),
      ),
    ),
  );
}

class ErrorBanner extends StatelessWidget {
  const ErrorBanner({super.key, required this.message, this.onRetry});
  final String message;
  final Future<void> Function()? onRetry;
  @override
  Widget build(BuildContext context) => Container(
    padding: const EdgeInsets.all(12),
    decoration: BoxDecoration(
      color: const Color(0xFFFCEBE8),
      borderRadius: BorderRadius.circular(10),
    ),
    child: Row(
      children: [
        const Icon(Icons.error_outline, color: Color(0xFFAE4036)),
        const SizedBox(width: 8),
        Expanded(child: Text(message)),
        if (onRetry != null)
          TextButton(onPressed: onRetry, child: const Text('Retry')),
      ],
    ),
  );
}

class StepLabel extends StatelessWidget {
  const StepLabel({super.key, required this.number, required this.label});
  final String number, label;
  @override
  Widget build(BuildContext context) => Row(
    children: [
      Text(
        number,
        style: const TextStyle(color: _green, fontWeight: FontWeight.w800),
      ),
      const SizedBox(width: 8),
      Text(
        label,
        style: const TextStyle(
          color: _muted,
          fontSize: 11,
          letterSpacing: 1,
          fontWeight: FontWeight.w700,
        ),
      ),
    ],
  );
}

class _BrandNote extends StatelessWidget {
  const _BrandNote({
    required this.icon,
    required this.title,
    required this.body,
  });
  final IconData icon;
  final String title, body;
  @override
  Widget build(BuildContext context) => Row(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Icon(icon, color: _green),
      const SizedBox(width: 12),
      Expanded(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(title, style: const TextStyle(fontWeight: FontWeight.w700)),
            const SizedBox(height: 4),
            Text(body, style: const TextStyle(color: Color(0xFF566458))),
          ],
        ),
      ),
    ],
  );
}

class InfoChip extends StatelessWidget {
  const InfoChip({super.key, required this.icon, required this.text});
  final IconData icon;
  final String text;
  @override
  Widget build(BuildContext context) => Chip(
    avatar: Icon(icon, size: 18, color: _green),
    label: Text(text),
    backgroundColor: Colors.white,
  );
}

String _friendlyError(Object error) {
  final text = error.toString();
  if (text.toLowerCase().contains('timeout'))
    return 'The request took too long. Check your connection and try again.';
  if (text.toLowerCase().contains('socket') ||
      text.toLowerCase().contains('connection'))
    return 'Mavuno could not reach the server. Check your connection and try again.';
  if (text.toLowerCase().contains('unauthor'))
    return 'Your session may have expired. Sign in again to continue.';
  return text.replaceFirst('Exception: ', '');
}

String _speciesName(AnimalSpecies species) => switch (species) {
  AnimalSpecies.cattle => 'Cattle',
  AnimalSpecies.sheep => 'Sheep',
  AnimalSpecies.goats => 'Goats',
  AnimalSpecies.poultry => 'Poultry',
};
String _title(String value) =>
    value.isEmpty ? value : '${value[0].toUpperCase()}${value.substring(1)}';

String _appetiteLabel(int score) => score >= 8
    ? 'Good'
    : score >= 4
    ? 'Reduced'
    : 'Poor';

String _activityLabel(int score) => score >= 8
    ? 'Normal'
    : score >= 4
    ? 'Reduced'
    : 'Very low';
String _date(DateTime date) =>
    '${date.day.toString().padLeft(2, '0')} ${const ['Jan', 'Feb', 'Mar', 'Apr', 'May', 'Jun', 'Jul', 'Aug', 'Sep', 'Oct', 'Nov', 'Dec'][date.month - 1]} ${date.year}';
String _age(DateTime birth) {
  final days = DateTime.now().difference(birth).inDays;
  if (days < 0) return 'Birth date in future';
  final years = days ~/ 365;
  final months = (days % 365) ~/ 30;
  return years > 0
      ? '$years yr${years == 1 ? '' : 's'}${months == 0 ? '' : ' $months mo'}'
      : '$months mo';
}
