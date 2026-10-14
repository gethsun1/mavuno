import 'package:flutter/material.dart';

const _tourGreen = Color(0xFF315D42);

class OnboardingGuide extends StatelessWidget {
  const OnboardingGuide({
    super.key,
    required this.title,
    required this.description,
    required this.step,
    required this.total,
    required this.onBack,
    required this.onNext,
    required this.onSkip,
    this.nextLabel = 'Next',
  });

  final String title;
  final String description;
  final int step;
  final int total;
  final VoidCallback onBack;
  final VoidCallback onNext;
  final VoidCallback onSkip;
  final String nextLabel;

  @override
  Widget build(BuildContext context) => Card(
    color: const Color(0xFFF0F5EE),
    elevation: 0,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(16),
      side: BorderSide(color: _tourGreen.withValues(alpha: 0.3)),
    ),
    child: Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              const Icon(
                Icons.lightbulb_outline,
                color: _tourGreen,
                size: 19,
              ),
              const SizedBox(width: 8),
              Expanded(
                child: Text(
                  title,
                  style: const TextStyle(fontWeight: FontWeight.w700),
                ),
              ),
              Text(
                '$step of $total',
                style: Theme.of(context).textTheme.labelSmall,
              ),
            ],
          ),
          const SizedBox(height: 7),
          Text(description),
          const SizedBox(height: 10),
          Wrap(
            alignment: WrapAlignment.end,
            crossAxisAlignment: WrapCrossAlignment.center,
            spacing: 4,
            children: [
              TextButton(onPressed: onSkip, child: const Text('Skip tour')),
              TextButton.icon(
                onPressed: step == 1 ? null : onBack,
                icon: const Icon(Icons.arrow_back, size: 17),
                label: const Text('Back'),
              ),
              FilledButton.icon(
                onPressed: onNext,
                icon: const Icon(Icons.arrow_forward, size: 17),
                label: Text(nextLabel),
              ),
            ],
          ),
        ],
      ),
    ),
  );
}

class TourSpotlight extends StatelessWidget {
  const TourSpotlight({super.key, required this.active, required this.child});

  final bool active;
  final Widget child;

  @override
  Widget build(BuildContext context) => AnimatedContainer(
    duration: const Duration(milliseconds: 220),
    padding: active ? const EdgeInsets.all(4) : EdgeInsets.zero,
    decoration: active
        ? BoxDecoration(
            color: const Color(0xFFFFF5D9),
            borderRadius: BorderRadius.circular(14),
            border: Border.all(color: const Color(0xFFE4A93C), width: 2),
            boxShadow: const [
              BoxShadow(color: Color(0x334B3510), blurRadius: 12),
            ],
          )
        : null,
    child: child,
  );
}
