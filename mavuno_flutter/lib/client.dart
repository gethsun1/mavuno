import 'dart:async';
import 'dart:convert';

import 'package:flutter/services.dart';
import 'package:mavuno_client/mavuno_client.dart';
import 'package:serverpod_auth_idp_flutter/serverpod_auth_idp_flutter.dart';
import 'package:serverpod_flutter/serverpod_flutter.dart';

// SERVER_URL is the production build override. Development uses assets/config.json.
final serverUrl = _getServerUrl();

Future<String> _getServerUrl() async {
  const serverUrlFromEnvironment = String.fromEnvironment('SERVER_URL');
  if (serverUrlFromEnvironment.isNotEmpty) return serverUrlFromEnvironment;

  final data = await rootBundle.loadString('assets/config.json');
  final config = jsonDecode(data) as Map<String, dynamic>;
  final apiUrl = config['apiUrl'] as String?;
  if (apiUrl == null || apiUrl.isEmpty) {
    throw StateError(
      'Set SERVER_URL or configure apiUrl in assets/config.json.',
    );
  }
  return apiUrl;
}

/// Sets up a global client object that can be used to talk to the server from
/// anywhere in our app. The client is generated from your server code
/// and is set up to connect to a Serverpod running on a local server on
/// the default port. You will need to modify this to connect to staging or
/// production servers.
/// In a larger app, you may want to use the dependency injection of your choice
/// instead of using a global client object. This is just a simple example.
late final Client client;

Future<void> initializeClient() async {
  client = Client(await serverUrl)
    ..connectivityMonitor = FlutterConnectivityMonitor()
    ..authSessionManager = FlutterAuthSessionManager();
  unawaited(client.auth.initialize());
}
