import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mavuno_flutter/main.dart';

void main() {
  testWidgets('app shell shows the greeting form', (tester) async {
    await tester.pumpWidget(const MyApp());

    expect(find.text('Serverpod Example'), findsOneWidget);
    final textField = tester.widget<TextField>(find.byType(TextField));
    expect(textField.decoration?.hintText, 'Enter your name');
    expect(find.text('No server response yet.'), findsOneWidget);
  });
}
