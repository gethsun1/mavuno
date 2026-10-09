import 'package:flutter/material.dart';
import 'package:flutter_web_plugins/url_strategy.dart';
import 'package:mavuno_client/mavuno_client.dart';
import 'package:serverpod_auth_idp_flutter/serverpod_auth_idp_flutter.dart';

import 'client.dart';
import 'screens/mavuno_app.dart';
import 'screens/downloads_page.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  usePathUrlStrategy();
  await initializeClient();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) => MaterialApp(
    title: 'Mavuno',
    debugShowCheckedModeBanner: false,
    theme: mavunoTheme,
    home: const SessionRouter(),
    onGenerateRoute: (settings) {
      if (settings.name == '/downloads') {
        return MaterialPageRoute<void>(
          settings: settings,
          builder: (_) => const DownloadsPage(),
        );
      }
      return null;
    },
  );
}

final mavunoTheme = ThemeData(
  useMaterial3: true,
  scaffoldBackgroundColor: const Color(0xFFF6F6F1),
  colorScheme: ColorScheme.fromSeed(
    seedColor: const Color(0xFF315D42),
    primary: const Color(0xFF315D42),
    secondary: const Color(0xFFB87943),
    surface: const Color(0xFFFFFEFB),
    error: const Color(0xFFAE4036),
  ),
  textTheme: const TextTheme(
    headlineMedium: TextStyle(
      fontSize: 28,
      height: 1.15,
      fontWeight: FontWeight.w700,
      color: Color(0xFF203B2D),
    ),
    titleLarge: TextStyle(fontSize: 20, fontWeight: FontWeight.w700),
    titleMedium: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
    bodyLarge: TextStyle(fontSize: 16, height: 1.45),
    bodyMedium: TextStyle(fontSize: 14, height: 1.4),
  ),
  appBarTheme: const AppBarTheme(
    backgroundColor: Color(0xFFF6F6F1),
    surfaceTintColor: Colors.transparent,
  ),
  inputDecorationTheme: InputDecorationTheme(
    filled: true,
    fillColor: const Color(0xFFFFFEFB),
    border: OutlineInputBorder(
      borderRadius: BorderRadius.circular(12),
      borderSide: const BorderSide(color: Color(0xFFE1E2D9)),
    ),
    enabledBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(12),
      borderSide: const BorderSide(color: Color(0xFFE1E2D9)),
    ),
  ),
  filledButtonTheme: FilledButtonThemeData(
    style: FilledButton.styleFrom(
      minimumSize: const Size(48, 48),
      padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 12),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
    ),
  ),
  outlinedButtonTheme: OutlinedButtonThemeData(
    style: OutlinedButton.styleFrom(
      minimumSize: const Size(48, 48),
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
    ),
  ),
  cardTheme: const CardThemeData(
    color: Color(0xFFFFFEFB),
    surfaceTintColor: Colors.transparent,
    elevation: 0,
    margin: EdgeInsets.zero,
  ),
);

class SessionRouter extends StatefulWidget {
  const SessionRouter({super.key});

  @override
  State<SessionRouter> createState() => _SessionRouterState();
}

class _SessionRouterState extends State<SessionRouter> {
  bool _loading = true;
  bool _signingOut = false;
  Object? _error;
  Farm? _farm;

  @override
  void initState() {
    super.initState();
    client.auth.authInfoListenable.addListener(_sessionChanged);
    _restore();
  }

  @override
  void dispose() {
    client.auth.authInfoListenable.removeListener(_sessionChanged);
    super.dispose();
  }

  void _sessionChanged() {
    if (!mounted) return;
    if (client.auth.isAuthenticated) {
      _loadFarm();
    } else {
      setState(() {
        _farm = null;
        _loading = false;
        _error = null;
        _signingOut = false;
      });
    }
  }

  Future<void> _restore() async {
    setState(() => _loading = true);
    try {
      await client.auth.initialize();
      if (!mounted) return;
      if (client.auth.isAuthenticated) {
        await _loadFarm();
      } else {
        setState(() => _loading = false);
      }
    } catch (error) {
      if (mounted)
        setState(() {
          _loading = false;
          _error = error;
        });
    }
  }

  Future<void> _loadFarm() async {
    setState(() {
      _loading = true;
      _error = null;
    });
    try {
      final farms = await client.farm.list().timeout(
        const Duration(seconds: 20),
      );
      if (!mounted) return;
      setState(() {
        _farm = farms.isEmpty ? null : farms.first;
        _loading = false;
      });
    } catch (error) {
      if (!mounted) return;
      if (!client.auth.isAuthenticated) {
        setState(() {
          _farm = null;
          _loading = false;
        });
      } else {
        setState(() {
          _error = error;
          _loading = false;
        });
      }
    }
  }

  Future<void> _createFarm({
    required String name,
    String? location,
    required String type,
    required String activities,
    required String livestock,
  }) async {
    setState(() {
      _loading = true;
      _error = null;
    });
    try {
      final description = [
        if (activities.trim().isNotEmpty) 'Activities: ${activities.trim()}',
        if (livestock.trim().isNotEmpty) 'Livestock: ${livestock.trim()}',
      ].join('\n');
      _farm = await client.farm.create(
        name,
        location: location,
        farmType: type,
        description: description.isEmpty ? null : description,
      );
      if (mounted) setState(() => _loading = false);
    } catch (error) {
      if (mounted)
        setState(() {
          _error = error;
          _loading = false;
        });
      rethrow;
    }
  }

  Future<void> _signOut() async {
    setState(() => _signingOut = true);
    try {
      await client.auth.signOutDevice();
      if (mounted)
        setState(() {
          _farm = null;
          _signingOut = false;
        });
    } catch (error) {
      if (mounted)
        setState(() {
          _error = error;
          _signingOut = false;
        });
    }
  }

  @override
  Widget build(BuildContext context) {
    if (_loading || _signingOut) {
      return const LoadingPage(label: 'Preparing your farm');
    }
    if (!client.auth.isAuthenticated) {
      return SignInPage(
        onBusy: (_) {},
        client: client,
        busy: false,
        error: _error,
        onRetry: _restore,
      );
    }
    if (_error != null && _farm == null) {
      return ErrorPage(error: _error!, onRetry: _loadFarm, onSignOut: _signOut);
    }
    if (_farm == null) {
      return FarmOnboardingPage(
        onCreate: _createFarm,
        error: _error,
        onSignOut: _signOut,
      );
    }
    return FarmWorkspace(
      farm: _farm!,
      onFarmCreated: (farm) => setState(() => _farm = farm),
      onSignOut: _signOut,
    );
  }
}
