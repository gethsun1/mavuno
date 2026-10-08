import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

const _releaseUrl = 'https://github.com/gethsun1/mavuno/releases/tag/v1.0.0';
const _apkUrl =
    'https://github.com/gethsun1/mavuno/releases/download/v1.0.0/mavuno-release.apk';
const _green = Color(0xFF315D42);
const _ink = Color(0xFF203B2D);
const _paper = Color(0xFFF6F6F1);

class DownloadsPage extends StatelessWidget {
  const DownloadsPage({super.key});

  Future<void> _open(BuildContext context, String url) async {
    final opened = await launchUrl(
      Uri.parse(url),
      mode: LaunchMode.externalApplication,
    );
    if (!opened && context.mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('The link could not be opened.')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final wide = MediaQuery.sizeOf(context).width >= 760;
    return Scaffold(
      backgroundColor: _paper,
      appBar: AppBar(
        leading: IconButton(
          tooltip: 'Back to Mavuno',
          onPressed: () => Navigator.of(context).maybePop(),
          icon: const Icon(Icons.arrow_back),
        ),
        title: Image.asset('assets/mavuno-logo.png', height: 38),
        centerTitle: false,
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).maybePop(),
            child: const Text('Sign in'),
          ),
          const SizedBox(width: 16),
        ],
      ),
      body: SingleChildScrollView(
        child: Center(
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 1120),
            child: Padding(
              padding: EdgeInsets.fromLTRB(
                wide ? 32 : 20,
                24,
                wide ? 32 : 20,
                64,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  _HeroCard(onDownload: () => _open(context, _apkUrl)),
                  const SizedBox(height: 24),
                  Wrap(
                    spacing: 12,
                    runSpacing: 12,
                    children: const [
                      _ReleaseFact(label: 'VERSION', value: '1.0.0'),
                      _ReleaseFact(label: 'PLATFORM', value: 'Android'),
                      _ReleaseFact(label: 'MINIMUM', value: 'Android 7.0+'),
                      _ReleaseFact(label: 'DOWNLOAD', value: '~26.3 MB APK'),
                      _ReleaseFact(label: 'BACKEND', value: 'Serverpod Cloud'),
                    ],
                  ),
                  const SizedBox(height: 52),
                  Text(
                    'Your farm, in view.',
                    style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                      color: _ink,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  const SizedBox(height: 10),
                  const Text(
                    'Keep everyday records and farm priorities together, wherever work takes you.',
                    style: TextStyle(color: Color(0xFF687267), fontSize: 16),
                  ),
                  const SizedBox(height: 24),
                  LayoutBuilder(
                    builder: (context, constraints) {
                      final count = constraints.maxWidth > 700 ? 4 : 2;
                      final width =
                          (constraints.maxWidth - 18 * (count - 1)) / count;
                      return Wrap(
                        spacing: 18,
                        runSpacing: 18,
                        children:
                            const [
                                  _Capability(
                                    icon: Icons.agriculture,
                                    title: 'Manage farms',
                                  ),
                                  _Capability(
                                    icon: Icons.pets_outlined,
                                    title: 'Manage livestock',
                                  ),
                                  _Capability(
                                    icon: Icons.note_alt_outlined,
                                    title: 'Record observations',
                                  ),
                                  _Capability(
                                    icon: Icons.water_drop_outlined,
                                    title: 'Track milk production',
                                  ),
                                  _Capability(
                                    icon: Icons.troubleshoot,
                                    title: 'Spot abnormal patterns',
                                  ),
                                  _Capability(
                                    icon: Icons.notifications_active_outlined,
                                    title: 'Review alerts and actions',
                                  ),
                                  _Capability(
                                    icon: Icons.auto_awesome_outlined,
                                    title: 'Read safe AI explanations',
                                  ),
                                  _Capability(
                                    icon: Icons.sync,
                                    title: 'Receive farm updates',
                                  ),
                                ]
                                .map(
                                  (item) => SizedBox(width: width, child: item),
                                )
                                .toList(),
                      );
                    },
                  ),
                  const SizedBox(height: 36),
                  Container(
                    padding: const EdgeInsets.all(24),
                    decoration: BoxDecoration(
                      color: const Color(0xFFE8EDE4),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Icon(Icons.cloud_done_outlined, color: _green),
                        const SizedBox(width: 16),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'One connected farm workspace',
                                style: Theme.of(context).textTheme.titleMedium
                                    ?.copyWith(
                                      fontWeight: FontWeight.w700,
                                      color: _ink,
                                    ),
                              ),
                              const SizedBox(height: 6),
                              const Text(
                                'The Android app connects to the same production Mavuno backend used by the web application.',
                                style: TextStyle(
                                  height: 1.5,
                                  color: Color(0xFF566458),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 28),
                  Align(
                    alignment: Alignment.center,
                    child: TextButton.icon(
                      onPressed: () => _open(context, _releaseUrl),
                      icon: const Icon(Icons.open_in_new),
                      label: const Text('View source & releases on GitHub'),
                    ),
                  ),
                  const SizedBox(height: 8),
                  const Center(
                    child: Text(
                      'Mavuno Sentinel provides early warnings and decision support, not veterinary diagnosis.',
                      textAlign: TextAlign.center,
                      style: TextStyle(color: Color(0xFF777A70), fontSize: 12),
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

class _HeroCard extends StatelessWidget {
  const _HeroCard({required this.onDownload});
  final VoidCallback onDownload;

  @override
  Widget build(BuildContext context) {
    final wide = MediaQuery.sizeOf(context).width >= 760;
    return Container(
      padding: EdgeInsets.all(wide ? 48 : 28),
      decoration: BoxDecoration(
        color: _green,
        borderRadius: BorderRadius.circular(28),
        gradient: const LinearGradient(
          colors: [Color(0xFF203B2D), Color(0xFF315D42)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 7),
            decoration: BoxDecoration(
              color: Colors.white.withValues(alpha: .12),
              borderRadius: BorderRadius.circular(30),
            ),
            child: const Text(
              'MAVUNO  ·  ANDROID 1.0.0',
              style: TextStyle(
                color: Colors.white,
                letterSpacing: 1.1,
                fontSize: 12,
              ),
            ),
          ),
          const SizedBox(height: 26),
          Text(
            'Mavuno for Android',
            style: Theme.of(context).textTheme.displaySmall?.copyWith(
              color: Colors.white,
              fontWeight: FontWeight.w700,
              height: 1.08,
            ),
          ),
          const SizedBox(height: 16),
          ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 740),
            child: const Text(
              'Take Mavuno farm intelligence with you. Record observations, monitor livestock, review Sentinel assessments, and stay connected to your farm from Android.',
              style: TextStyle(
                color: Color(0xFFE4EAE2),
                fontSize: 17,
                height: 1.55,
              ),
            ),
          ),
          const SizedBox(height: 28),
          FilledButton.icon(
            onPressed: onDownload,
            icon: const Icon(Icons.download_rounded),
            label: const Text('Download Android APK'),
            style: FilledButton.styleFrom(
              foregroundColor: _ink,
              backgroundColor: const Color(0xFFF5D9A8),
              padding: const EdgeInsets.symmetric(horizontal: 22, vertical: 18),
              textStyle: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w700,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _ReleaseFact extends StatelessWidget {
  const _ReleaseFact({required this.label, required this.value});
  final String label;
  final String value;

  @override
  Widget build(BuildContext context) => Container(
    constraints: const BoxConstraints(minWidth: 138),
    padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
    decoration: BoxDecoration(
      color: Colors.white,
      border: Border.all(color: const Color(0xFFE5E6DE)),
      borderRadius: BorderRadius.circular(14),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: const TextStyle(
            color: Color(0xFF777A70),
            fontSize: 10,
            letterSpacing: 1,
          ),
        ),
        const SizedBox(height: 4),
        Text(
          value,
          style: const TextStyle(color: _ink, fontWeight: FontWeight.w700),
        ),
      ],
    ),
  );
}

class _Capability extends StatelessWidget {
  const _Capability({required this.icon, required this.title});
  final IconData icon;
  final String title;

  @override
  Widget build(BuildContext context) => Container(
    constraints: const BoxConstraints(minHeight: 84),
    padding: const EdgeInsets.all(16),
    decoration: BoxDecoration(
      color: Colors.white,
      border: Border.all(color: const Color(0xFFE5E6DE)),
      borderRadius: BorderRadius.circular(16),
    ),
    child: Row(
      children: [
        Icon(icon, color: _green),
        const SizedBox(width: 12),
        Expanded(
          child: Text(
            title,
            style: const TextStyle(color: _ink, fontWeight: FontWeight.w600),
          ),
        ),
      ],
    ),
  );
}
