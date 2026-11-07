import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:input_information/main.dart';

void main() {
  testWidgets('Empty form shows validation errors', (WidgetTester tester) async {
    await tester.pumpWidget(const MyApp());

    await tester.tap(find.text('Submit'));
    await tester.pump();

    expect(find.text('Email is required'), findsOneWidget);
    expect(find.text('Phone number is required'), findsOneWidget);
    expect(find.text('Password is required'), findsOneWidget);
    expect(find.text('Success'), findsNothing);
  });

  testWidgets('Valid form shows success dialog', (WidgetTester tester) async {
    await tester.pumpWidget(const MyApp());

    final fields = find.byType(TextFormField);
    await tester.enterText(fields.at(0), 'student@example.com');
    await tester.enterText(fields.at(1), '09123456789');
    await tester.enterText(fields.at(2), 'Passw0rd!');

    await tester.tap(find.text('Submit'));
    await tester.pumpAndSettle();

    expect(find.text('Success'), findsOneWidget);
    expect(find.text('Submitted successfully'), findsOneWidget);

    await tester.tap(find.text('OK'));
    await tester.pumpAndSettle();
    expect(find.text('Success'), findsNothing);
  });

  testWidgets('Password visibility toggles', (WidgetTester tester) async {
    await tester.pumpWidget(const MyApp());

    expect(find.byIcon(Icons.visibility_off), findsOneWidget);
    await tester.tap(find.byIcon(Icons.visibility_off));
    await tester.pump();
    expect(find.byIcon(Icons.visibility), findsOneWidget);
  });
}
