import 'package:flutter/material.dart';

import '../client.dart';

class ObservationDialog extends StatefulWidget {
  const ObservationDialog({super.key, required this.animalId});
  final int animalId;

  @override
  State<ObservationDialog> createState() => _ObservationDialogState();
}

class _ObservationDialogState extends State<ObservationDialog> {
  static const _symptoms = [
    'Coughing',
    'Nasal discharge',
    'Diarrhea',
    'Lameness',
    'Swelling',
    'Breathing difficulty',
    'Skin abnormality',
    'Other',
  ];
  final _form = GlobalKey<FormState>();
  final _temperature = TextEditingController();
  final _notes = TextEditingController();
  final Set<String> _selected = {};
  String _appetite = 'Good';
  String _activity = 'Normal';
  bool _busy = false;

  @override
  void dispose() {
    _temperature.dispose();
    _notes.dispose();
    super.dispose();
  }

  Future<void> _save() async {
    if (!_form.currentState!.validate() || _busy) return;
    setState(() => _busy = true);
    try {
      await client.observation.create(
        widget.animalId,
        DateTime.now(),
        temperature: _temperature.text.trim().isEmpty
            ? null
            : double.parse(_temperature.text.trim()),
        activityScore: const {
          'Normal': 10,
          'Reduced': 5,
          'Very low': 1,
        }[_activity],
        appetiteScore: const {'Good': 10, 'Reduced': 5, 'Poor': 2}[_appetite],
        visibleSymptoms: _selected.isEmpty ? null : _selected.join(', '),
        notes: _notes.text.trim().isEmpty ? null : _notes.text.trim(),
      );
      if (mounted) Navigator.pop(context, true);
    } catch (_) {
      if (mounted) {
        setState(() => _busy = false);
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text(
              'Could not save observation. Check your connection and try again.',
            ),
          ),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) => AlertDialog(
    title: const Text('Log observation'),
    content: SizedBox(
      width: 480,
      child: Form(
        key: _form,
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              TextFormField(
                controller: _temperature,
                decoration: const InputDecoration(
                  labelText: 'Temperature (°C)',
                  hintText: 'e.g. 38.5',
                ),
                keyboardType: const TextInputType.numberWithOptions(
                  decimal: true,
                ),
                validator: (v) {
                  if (v == null || v.trim().isEmpty) return null;
                  final value = double.tryParse(v.trim());
                  return value == null ||
                          !value.isFinite ||
                          value < 30 ||
                          value > 45
                      ? 'Enter a temperature from 30 to 45 °C.'
                      : null;
                },
              ),
              const SizedBox(height: 12),
              DropdownButtonFormField<String>(
                initialValue: _appetite,
                decoration: const InputDecoration(labelText: 'Appetite'),
                items: ['Good', 'Reduced', 'Poor']
                    .map((v) => DropdownMenuItem(value: v, child: Text(v)))
                    .toList(),
                onChanged: _busy
                    ? null
                    : (v) => setState(() => _appetite = v ?? _appetite),
              ),
              const SizedBox(height: 12),
              DropdownButtonFormField<String>(
                initialValue: _activity,
                decoration: const InputDecoration(labelText: 'Activity'),
                items: ['Normal', 'Reduced', 'Very low']
                    .map((v) => DropdownMenuItem(value: v, child: Text(v)))
                    .toList(),
                onChanged: _busy
                    ? null
                    : (v) => setState(() => _activity = v ?? _activity),
              ),
              const SizedBox(height: 12),
              const Text('Symptoms'),
              Wrap(
                spacing: 4,
                children: _symptoms
                    .map(
                      (s) => FilterChip(
                        label: Text(s),
                        selected: _selected.contains(s),
                        onSelected: _busy
                            ? null
                            : (yes) => setState(
                                () => yes
                                    ? _selected.add(s)
                                    : _selected.remove(s),
                              ),
                      ),
                    )
                    .toList(),
              ),
              TextFormField(
                controller: _notes,
                decoration: const InputDecoration(
                  labelText: 'Notes (optional)',
                ),
                maxLines: 2,
              ),
            ],
          ),
        ),
      ),
    ),
    actions: [
      TextButton(
        onPressed: _busy ? null : () => Navigator.pop(context),
        child: const Text('Cancel'),
      ),
      FilledButton(
        onPressed: _busy ? null : _save,
        child: Text(_busy ? 'Saving…' : 'Save observation'),
      ),
    ],
  );
}

class ProductionDialog extends StatefulWidget {
  const ProductionDialog({super.key, required this.animalId});
  final int animalId;

  @override
  State<ProductionDialog> createState() => _ProductionDialogState();
}

class _ProductionDialogState extends State<ProductionDialog> {
  final _form = GlobalKey<FormState>();
  final _quantity = TextEditingController();
  final _notes = TextEditingController();
  bool _busy = false;

  @override
  void dispose() {
    _quantity.dispose();
    _notes.dispose();
    super.dispose();
  }

  Future<void> _save() async {
    if (!_form.currentState!.validate() || _busy) return;
    setState(() => _busy = true);
    try {
      await client.production.create(
        widget.animalId,
        DateTime.now(),
        'milk',
        double.parse(_quantity.text.trim()),
        'L',
        notes: _notes.text.trim().isEmpty ? null : _notes.text.trim(),
      );
      if (mounted) Navigator.pop(context, true);
    } catch (_) {
      if (mounted) {
        setState(() => _busy = false);
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text(
              'Could not save milk record. Check your connection and try again.',
            ),
          ),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) => AlertDialog(
    title: const Text('Record milk'),
    content: Form(
      key: _form,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          TextFormField(
            controller: _quantity,
            autofocus: true,
            decoration: const InputDecoration(
              labelText: 'Quantity (litres)',
              hintText: 'e.g. 12.5',
            ),
            keyboardType: const TextInputType.numberWithOptions(decimal: true),
            validator: (v) {
              final x = double.tryParse(v?.trim() ?? '');
              return x == null || !x.isFinite || x <= 0
                  ? 'Enter a quantity greater than zero.'
                  : null;
            },
          ),
          TextFormField(
            controller: _notes,
            decoration: const InputDecoration(labelText: 'Note (optional)'),
          ),
        ],
      ),
    ),
    actions: [
      TextButton(
        onPressed: _busy ? null : () => Navigator.pop(context),
        child: const Text('Cancel'),
      ),
      FilledButton(
        onPressed: _busy ? null : _save,
        child: Text(_busy ? 'Saving…' : 'Save milk'),
      ),
    ],
  );
}
