import 'dart:async';
import 'dart:io';

import 'package:mavuno_lms_sim/mavuno_lms_sim.dart';

const _usage = '''
Simulated Livestock Monitoring System for a local Mavuno server.

Usage: dart run bin/mavuno_lms_sim.dart [--port=8095] [--config=config/credentials.yaml]

Run it from the mavuno_lms_sim folder while `serverpod start` is running,
then open http://localhost:8095.''';

/// Signs in to the local Mavuno server as the farm owner and serves the
/// simulator page.
Future<void> main(List<String> args) async {
  if (args.contains('--help') || args.contains('-h')) {
    stdout.writeln(_usage);
    return;
  }
  final port = int.tryParse(_option(args, 'port') ?? '8095');
  if (port == null) {
    stderr.writeln('--port must be a number.');
    exitCode = 64;
    return;
  }

  final SimulatorConfig config;
  try {
    config = SimulatorConfig.load(
      File(_option(args, 'config') ?? 'config/credentials.yaml'),
    );
  } on FormatException catch (error) {
    stderr.writeln(error.message);
    exitCode = 78;
    return;
  }

  stdout.writeln(
    'Signing in to Mavuno at ${config.serverUrl} as ${config.email}…',
  );
  final ClientMavunoGateway gateway;
  try {
    gateway = await ClientMavunoGateway.signIn(config);
  } on Object catch (error) {
    stderr.writeln('Could not sign in: ${describeError(error)}');
    exitCode = 1;
    return;
  }

  final controller = SimulatorController(
    gateway: gateway,
    store: FileSimulatorStore(File('.lms/state.json')),
  );
  await controller.refreshHerd();

  final HttpServer server;
  try {
    server = await SimulatorServer(controller, port: port).start();
  } on SocketException catch (error) {
    stderr.writeln('Port $port is not available: ${error.message}');
    exitCode = 1;
    return;
  }

  final farm = controller.toJson()['farm'] as Map<String, Object?>?;
  stdout
    ..writeln(
      farm == null
          ? 'Signed in, but the herd could not be loaded yet.'
          : 'Monitoring ${farm['name']}.',
    )
    ..writeln('Simulated LMS running at http://localhost:$port')
    ..writeln('Press Ctrl+C to stop.');

  late final StreamSubscription<ProcessSignal> stop;
  stop = ProcessSignal.sigint.watch().listen((_) async {
    await stop.cancel();
    await server.close(force: true);
    stdout.writeln('Simulated LMS stopped.');
    exit(0);
  });
}

String? _option(List<String> args, String name) {
  for (final arg in args) {
    if (arg.startsWith('--$name=')) return arg.substring(name.length + 3);
  }
  return null;
}
