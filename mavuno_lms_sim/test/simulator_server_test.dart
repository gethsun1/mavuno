import 'dart:convert';
import 'dart:io';

import 'package:mavuno_lms_sim/mavuno_lms_sim.dart';
import 'package:test/test.dart';

import 'support/fakes.dart';

void main() {
  late HttpServer server;
  late FakeGateway gateway;
  final http = HttpClient();

  setUp(() async {
    gateway = FakeGateway(herd: cows);
    server = await SimulatorServer(
      SimulatorController(gateway: gateway, store: MemoryStore()),
      port: 0,
    ).start();
  });

  tearDown(() => server.close(force: true));
  tearDownAll(http.close);

  Future<(int, Map<String, Object?>)> call(
    String method,
    String path, {
    Object? body,
    bool pageHeader = true,
    String host = 'localhost',
  }) async {
    final request = await http.open(
      method,
      InternetAddress.loopbackIPv4.address,
      server.port,
      path,
    );
    request.headers.host = host;
    if (pageHeader) request.headers.set(SimulatorServer.requestHeader, '1');
    if (body != null) {
      request.headers.contentType = ContentType.json;
      request.write(jsonEncode(body));
    }
    final response = await request.close();
    final text = await utf8.decodeStream(response);
    final json = response.headers.contentType?.mimeType == 'application/json'
        ? jsonDecode(text) as Map<String, Object?>
        : <String, Object?>{'html': text};
    return (response.statusCode, json);
  }

  group('SimulatorServer', () {
    test('serves the page and the state', () async {
      final (pageStatus, page) = await call('GET', '/');
      expect(pageStatus, 200);
      expect(page['html'], contains('Generate report'));

      final (status, state) = await call('GET', '/api/state');
      expect(status, 200);
      expect(state['herd'], hasLength(2));
      expect((state['nextWindow'] as Map)['label'], 'Day 1, 06:00–10:00');
    });

    test('generates a report through the API', () async {
      final (status, body) = await call('POST', '/api/generate', body: {});
      expect(status, 200);
      expect((body['run'] as Map)['posted'], 2);
      expect(gateway.published, hasLength(2));
    });

    test('rejects changes that do not come from the page', () async {
      final (status, _) = await call(
        'POST',
        '/api/generate',
        body: {},
        pageHeader: false,
      );
      expect(status, 403);
      expect(gateway.published, isEmpty);
    });

    test('rejects requests addressed to another host', () async {
      final (status, _) = await call('GET', '/api/state', host: 'evil.example');
      expect(status, 403);
    });

    test('validates settings and conditions', () async {
      final (badRef, error) = await call(
        'POST',
        '/api/settings',
        body: {
          'references': {
            'cattle': {'feedingHoursPerDay': 0, 'activeHoursPerDay': 4},
          },
        },
      );
      expect(badRef, 400);
      expect(error['error'], contains('between'));

      final (ok, body) = await call(
        'POST',
        '/api/conditions',
        body: {'animalId': 1, 'condition': 'unwell'},
      );
      expect(ok, 200);
      final herd = (body['state'] as Map)['herd'] as List;
      expect((herd.first as Map)['conditionSetting'], 'unwell');

      final (badCondition, _) = await call(
        'POST',
        '/api/conditions',
        body: {'animalId': 1, 'condition': 'sleepy'},
      );
      expect(badCondition, 400);
    });
  });
}
