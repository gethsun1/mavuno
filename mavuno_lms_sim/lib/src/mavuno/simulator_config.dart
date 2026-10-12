import 'dart:io';

import 'package:yaml/yaml.dart';

/// Local connection settings, read from `config/credentials.yaml`.
class SimulatorConfig {
  const SimulatorConfig({
    required this.serverUrl,
    required this.email,
    required this.password,
    this.farmId,
  });

  static const defaultServerUrl = 'http://localhost:8080/';
  static const _localHosts = {'localhost', '127.0.0.1', '::1'};

  final Uri serverUrl;
  final String email;
  final String password;

  /// The farm to monitor. Defaults to the account's first farm, the same farm
  /// the Mavuno app shows.
  final int? farmId;

  static SimulatorConfig load(File file) {
    if (!file.existsSync()) {
      throw FormatException(
        'Missing ${file.path}. Copy config/credentials.example.yaml to '
        'config/credentials.yaml and add your local farmer account.',
      );
    }
    final yaml = loadYaml(file.readAsStringSync());
    if (yaml is! Map) {
      throw FormatException('${file.path} must contain YAML settings.');
    }
    return fromMap(yaml);
  }

  static SimulatorConfig fromMap(Map<dynamic, dynamic> values) {
    String required(String key) {
      final value = values[key];
      if (value is! String || value.trim().isEmpty) {
        throw FormatException('Set "$key" in config/credentials.yaml.');
      }
      return value.trim();
    }

    final serverUrl = Uri.tryParse(
      (values['serverUrl'] as String?)?.trim() ?? defaultServerUrl,
    );
    if (serverUrl == null || !serverUrl.hasScheme || serverUrl.host.isEmpty) {
      throw const FormatException('"serverUrl" must be a full URL.');
    }
    // Synthetic observations raise real alerts and tasks, so they must never
    // reach a shared or production Mavuno server.
    if (!_localHosts.contains(serverUrl.host)) {
      throw FormatException(
        'The simulator only connects to a local Mavuno server, not '
        '${serverUrl.host}.',
      );
    }
    // Passwords are kept exactly as written, including spaces.
    final password = values['password'];
    if (password is! String || password.isEmpty) {
      throw const FormatException(
        'Set "password" in config/credentials.yaml, in quotes.',
      );
    }
    final farmId = values['farmId'];
    if (farmId != null && farmId is! int) {
      throw const FormatException('"farmId" must be a whole number.');
    }
    return SimulatorConfig(
      serverUrl: serverUrl,
      email: required('email'),
      password: password,
      farmId: farmId as int?,
    );
  }
}
