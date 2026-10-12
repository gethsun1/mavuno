import 'dart:convert';
import 'dart:io';

import '../app/simulator_controller.dart';
import '../simulation/animal_condition.dart';
import '../simulation/reference_values.dart';
import 'simulator_page.dart';

/// Serves the simulator page and its small JSON API on localhost only.
///
/// The simulator acts with the farmer's Mavuno login, so it only answers
/// requests addressed to localhost (blocking DNS rebinding) and only accepts
/// changes carrying the page's own header (blocking cross-site requests).
class SimulatorServer {
  SimulatorServer(this.controller, {this.port = 8095});

  static const requestHeader = 'x-mavuno-lms';

  final SimulatorController controller;
  final int port;

  Future<HttpServer> start() async {
    final server = await HttpServer.bind(InternetAddress.loopbackIPv4, port);
    server.listen((request) async {
      try {
        await _handle(request);
      } on Object catch (error) {
        await _json(request.response, HttpStatus.internalServerError, {
          'error': describeError(error),
        });
      }
    });
    return server;
  }

  Future<void> _handle(HttpRequest request) async {
    final response = request.response;
    final host = request.headers.host;
    if (host != 'localhost' && host != '127.0.0.1') {
      return _json(response, HttpStatus.forbidden, {
        'error': 'The simulator only answers on localhost.',
      });
    }

    final route = '${request.method} ${request.uri.path}';
    if (route == 'GET /') {
      response.headers.contentType = ContentType.html;
      response.headers.set('cache-control', 'no-store');
      response.write(simulatorPage);
      return response.close();
    }
    if (route == 'GET /api/state') {
      await controller.refreshHerd();
      return _json(response, HttpStatus.ok, controller.toJson());
    }

    if (request.method != 'POST') {
      return _json(response, HttpStatus.notFound, {'error': 'Not found.'});
    }
    if (request.headers.value(requestHeader) != '1') {
      return _json(response, HttpStatus.forbidden, {
        'error': 'Requests must come from the simulator page.',
      });
    }
    final body = await _body(request);
    switch (request.uri.path) {
      case '/api/generate':
        try {
          final run = await controller.generate();
          return _json(response, HttpStatus.ok, {
            'run': run.toJson(),
            'state': controller.toJson(),
          });
        } on SimulatorBusyException catch (error) {
          return _json(response, HttpStatus.conflict, {'error': '$error'});
        } on Object catch (error) {
          return _json(response, HttpStatus.badGateway, {
            'error': describeError(error),
            'state': controller.toJson(),
          });
        }
      case '/api/settings':
        if (body['dryRun'] case final bool dryRun) {
          await controller.setDryRun(dryRun);
        }
        if (body['references'] case final Map<String, Object?> references) {
          final ReferenceValues values;
          try {
            values = ReferenceValues.fromJson(references);
          } on FormatException catch (error) {
            return _json(response, HttpStatus.badRequest, {
              'error': error.message,
            });
          }
          await controller.setReferences(values);
        }
      case '/api/conditions':
        final animalId = body['animalId'];
        final setting = body['condition'];
        final condition = setting is String
            ? AnimalCondition.tryParse(setting)
            : null;
        if (animalId is! int || (setting != 'auto' && condition == null)) {
          return _json(response, HttpStatus.badRequest, {
            'error': 'Choose an animal and a condition.',
          });
        }
        await controller.setCondition(animalId, condition);
      case '/api/clock/reset':
        await controller.resetClock();
      default:
        return _json(response, HttpStatus.notFound, {'error': 'Not found.'});
    }
    await controller.refreshHerd();
    return _json(response, HttpStatus.ok, {'state': controller.toJson()});
  }

  static Future<Map<String, Object?>> _body(HttpRequest request) async {
    final text = await utf8.decodeStream(request);
    if (text.trim().isEmpty) return const {};
    final decoded = jsonDecode(text);
    return decoded is Map<String, Object?> ? decoded : const {};
  }

  static Future<void> _json(
    HttpResponse response,
    int status,
    Map<String, Object?> body,
  ) async {
    response
      ..statusCode = status
      ..headers.contentType = ContentType.json
      ..headers.set('cache-control', 'no-store')
      ..write(jsonEncode(body));
    await response.close();
  }
}
