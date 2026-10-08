import 'dart:convert';
import 'dart:io';

import 'package:serverpod/serverpod.dart';

import '../generated/protocol.dart';
import '../shared/farm_access.dart';

abstract interface class SentinelAiProvider {
  Future<Map<String, Object?>> explain(Map<String, Object?> evidence);
}

/// Groq adapter kept behind [SentinelAiProvider] so deployments can swap it.
class GroqSentinelAiProvider implements SentinelAiProvider {
  GroqSentinelAiProvider({HttpClient? httpClient})
    : _httpClient = httpClient ?? HttpClient();

  final HttpClient _httpClient;

  static final Map<String, String> _dotenv = _readDotEnv();

  @override
  Future<Map<String, Object?>> explain(Map<String, Object?> evidence) async {
    final apiKey = _setting('GROQ_API_KEY');
    if (apiKey == null || apiKey.isEmpty) {
      throw StateError('Sentinel AI provider is not configured.');
    }
    final model = _setting('GROQ_MODEL') ?? 'openai/gpt-oss-120b';
    final serviceTier = _setting('GROQ_SERVICE_TIER');
    if (serviceTier != null &&
        !const {'auto', 'on_demand', 'flex', 'performance'}.contains(
          serviceTier,
        )) {
      throw StateError(
        'GROQ_SERVICE_TIER is not a supported Groq service tier.',
      );
    }
    final request = await _httpClient
        .postUrl(Uri.https('api.groq.com', '/openai/v1/chat/completions'))
        .timeout(const Duration(seconds: 20));
    request.headers
      ..set(HttpHeaders.authorizationHeader, 'Bearer $apiKey')
      ..contentType = ContentType.json;
    request.write(
      jsonEncode({
        'model': model,
        if (serviceTier != null) 'service_tier': serviceTier,
        'temperature': 0,
        'response_format': {'type': 'json_object'},
        'messages': [
          {
            'role': 'system',
            'content':
                '''You explain a deterministic farm risk assessment. You are not diagnosing disease. Use only the provided evidence. Do not invent measurements, symptoms, causes, diagnoses, medications, or treatments. Never name a disease or call an elevated temperature a fever; say “Mavuno detected an elevated temperature.” If evidence is insufficient, say so explicitly. Use cautious, concise, farmer-friendly language. Explain what Mavuno detected, not what the animal definitely has. Return one JSON object with string fields summary, whyFlagged, whatToWatch, limitations. Do not include markdown.''',
          },
          {'role': 'user', 'content': jsonEncode(evidence)},
        ],
      }),
    );
    final response = await request.close().timeout(const Duration(seconds: 20));
    final body = await response.transform(utf8.decoder).join();
    if (response.statusCode < 200 || response.statusCode >= 300) {
      throw HttpException('AI provider returned ${response.statusCode}.');
    }
    final envelope = jsonDecode(body) as Map<String, dynamic>;
    final content = envelope['choices']?[0]?['message']?['content'];
    if (content is! String) throw const FormatException('Missing AI content.');
    final decoded = jsonDecode(content);
    if (decoded is! Map<String, dynamic>) {
      throw const FormatException('AI content is not a JSON object.');
    }
    return decoded.map((key, value) => MapEntry(key, value));
  }

  static String? _setting(String name) {
    final processValue = Platform.environment[name]?.trim();
    if (processValue != null && processValue.isNotEmpty) return processValue;
    return _dotenv[name];
  }

  static Map<String, String> _readDotEnv() {
    // `serverpod start` launches the server with mavuno_server as its working
    // directory. Serverpod inherits OS environment variables but does not
    // automatically load the workspace-root .env file.
    for (final file in [File('.env'), File('../.env')]) {
      if (!file.existsSync()) continue;
      try {
        final values = <String, String>{};
        for (final rawLine in file.readAsLinesSync()) {
          final line = rawLine.trim();
          if (line.isEmpty || line.startsWith('#')) continue;
          final assignment = line.startsWith('export ')
              ? line.substring(7).trimLeft()
              : line;
          final separator = assignment.indexOf('=');
          if (separator <= 0) continue;
          final name = assignment.substring(0, separator).trim();
          var value = assignment.substring(separator + 1).trim();
          if (value.length >= 2 &&
              ((value.startsWith('"') && value.endsWith('"')) ||
                  (value.startsWith("'") && value.endsWith("'")))) {
            value = value.substring(1, value.length - 1);
          } else {
            final comment = RegExp(r'\s+#').firstMatch(value);
            if (comment != null)
              value = value.substring(0, comment.start).trim();
          }
          if (name.isNotEmpty) values[name] = value;
        }
        return values;
      } on FileSystemException {
        // Fall back to the other conventional working-directory location.
      }
    }
    return const {};
  }
}

class SentinelExplanationService {
  SentinelExplanationService({SentinelAiProvider? provider})
    : _provider = provider ?? GroqSentinelAiProvider();

  final SentinelAiProvider _provider;

  Future<SentinelAiExplanation?> explainLatest(
    Session session,
    int animalId,
  ) async {
    final animal = await FarmAccess.ownedAnimal(session, animalId);
    final assessment = await SentinelAssessment.db.findFirstRow(
      session,
      where: (t) => t.animalId.equals(animalId),
      orderBy: (t) => t.assessedAt.desc(),
    );
    if (assessment == null || assessment.farmId != animal.farmId) return null;

    final signals = _signals(assessment.detectedSignals);
    final evidence = <String, Object?>{
      'animal': {
        if (animal.name?.trim().isNotEmpty == true) 'name': animal.name,
        'tag': animal.tag,
        'species': animal.species.name,
        if (animal.breed != null) 'breed': animal.breed,
      },
      'riskLevel': assessment.riskLevel.name,
      'signals': signals,
      'evidenceSummary': assessment.baselineSummary,
      'recommendedAction': assessment.recommendedAction,
    };
    final key = jsonEncode(evidence);
    if (assessment.aiExplanationKey == key &&
        assessment.aiExplanationJson != null) {
      try {
        return _decode(assessment.aiExplanationJson!, signals, evidence);
      } on FormatException {
        // Regenerate corrupted stored output.
      }
    }

    try {
      final result = await _provider.explain(evidence);
      final explanation = _validate(result, signals, evidence);
      await SentinelAssessment.db.updateRow(
        session,
        assessment.copyWith(
          aiExplanationJson: jsonEncode({
            'summary': explanation.summary,
            'whyFlagged': explanation.whyFlagged,
            'signals': explanation.signals,
            'whatToWatch': explanation.whatToWatch,
            'limitations': explanation.limitations,
          }),
          aiExplanationKey: key,
        ),
      );
      return explanation;
    } on Object catch (error, stackTrace) {
      session.log(
        'Sentinel AI explanation unavailable',
        level: LogLevel.warning,
        exception: error,
        stackTrace: stackTrace,
      );
      return null;
    }
  }

  static List<Map<String, Object?>> _signals(String json) {
    final value = jsonDecode(json);
    if (value is! List)
      throw const FormatException('Invalid assessment signals.');
    return value.map((item) {
      if (item is! Map)
        throw const FormatException('Invalid assessment signal.');
      return item.map((key, value) => MapEntry(key.toString(), value));
    }).toList();
  }

  static SentinelAiExplanation _decode(
    String json,
    List<Map<String, Object?>> signals,
    Map<String, Object?> evidence,
  ) {
    final decoded = jsonDecode(json);
    if (decoded is! Map<String, dynamic>) {
      throw const FormatException('Invalid stored explanation.');
    }
    return _validate(decoded, signals, evidence);
  }

  static SentinelAiExplanation _validate(
    Map<String, Object?> value,
    List<Map<String, Object?>> signals,
    Map<String, Object?> evidence,
  ) {
    String requiredText(String field) {
      final text = value[field];
      if (text is! String || text.trim().isEmpty || text.length > 1200) {
        throw FormatException('Invalid AI explanation field: $field.');
      }
      return text.trim();
    }

    final summary = requiredText('summary');
    final whyFlagged = requiredText('whyFlagged');
    final whatToWatch = requiredText('whatToWatch');
    final limitations = requiredText('limitations');
    final safeLimitations = limitations.replaceAll(
      RegExp(r'\bnot (?:a )?(?:veterinary )?diagnosis\b', caseSensitive: false),
      '',
    );
    final explanationText =
        '$summary $whyFlagged $whatToWatch $safeLimitations';
    final unsafeClaims = RegExp(
      r'\b(mastitis|pneumonia|infection|infected|disease|illness|fever|antibiotic|medication|medicine|dosage|treatment|diagnosed|diagnosis|caused by|due to|likely has|probably has)\b',
      caseSensitive: false,
    );
    if (unsafeClaims.hasMatch(explanationText)) {
      throw const FormatException(
        'AI response contains unsupported medical claims.',
      );
    }
    if (signals.isEmpty &&
        !RegExp(
          r'no (?:abnormal )?signals?|not enough evidence|insufficient',
          caseSensitive: false,
        ).hasMatch('$summary $whyFlagged $limitations')) {
      throw const FormatException(
        'AI response does not describe the lack of evidence.',
      );
    }
    final evidenceNumbers = RegExp(r'\d+(?:\.\d+)?')
        .allMatches(jsonEncode(evidence))
        .map((match) => double.parse(match.group(0)!))
        .toSet();
    final unsupportedNumber = RegExp(r'\d+(?:\.\d+)?')
        .allMatches(explanationText)
        .map((match) => double.parse(match.group(0)!))
        .any((number) => !evidenceNumbers.contains(number));
    if (unsupportedNumber) {
      throw const FormatException(
        'AI response contains unsupported measurements.',
      );
    }

    return SentinelAiExplanation(
      summary: summary,
      whyFlagged: whyFlagged,
      signals: signals.map((signal) => signal['title'].toString()).toList(),
      whatToWatch: whatToWatch,
      limitations: limitations,
    );
  }
}
