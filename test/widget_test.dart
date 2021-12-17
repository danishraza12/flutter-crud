// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility that Flutter provides. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:flutterform/main.dart';

void main() {
  testWidgets("Test for Name Field", (WidgetTester tester) async {
    await tester.pumpWidget(MyApp());
    Finder nameField = find.byKey(Key('Name'));
    await tester.enterText(nameField, "Bilal");
    expect(find.text('Bilal'), findsOneWidget);

    // Finder loginButton = find.byKey(new Key('login_btn'));
    // await tester.tap(loginButton);
    // await tester.pump();
  });

  testWidgets("Test for Age Field", (WidgetTester tester) async {
    await tester.pumpWidget(MyApp());
    Finder ageField = find.byKey(Key('Age'));
    await tester.enterText(ageField, "12");
    expect(find.text('12'), findsOneWidget);
  });

  testWidgets("Test for City Field", (WidgetTester tester) async {
    await tester.pumpWidget(MyApp());
    Finder cityField = find.byKey(Key('City'));
    await tester.enterText(cityField, "Karachi");
    expect(find.text('Karachi'), findsOneWidget);
  });

  testWidgets("Validation Check for Name Field", (WidgetTester tester) async {
    await tester.pumpWidget(MyApp());
    Finder nameField = find.byKey(Key('Name'));
    await tester.enterText(nameField, "123");
    expect(find.text('123'), findsNothing);
  });

  testWidgets("Validation Check for Age Field", (WidgetTester tester) async {
    await tester.pumpWidget(MyApp());
    Finder ageField = find.byKey(Key('Age'));
    await tester.enterText(ageField, "B12");
    expect(find.text('B12'), findsNothing);
  });

  testWidgets("Validation Check For City Field", (WidgetTester tester) async {
    await tester.pumpWidget(MyApp());
    Finder cityField = find.byKey(Key('City'));
    await tester.enterText(cityField, "12");
    expect(find.text('12'), findsNothing);
  });

  // testWidgets("Test For Add Student Button", (WidgetTester tester) async {
  //   await tester.pumpWidget(MyApp());
  //   Finder nameField = find.byKey(Key('Name'));
  //   Finder ageField = find.byKey(Key('Age'));
  //   Finder cityField = find.byKey(Key('City'));

  //   await tester.enterText(nameField, "text");
  //   // expect(find.text('text'), findsOneWidget);
  //   await tester.enterText(ageField, "12");
  //   // expect(find.text('12'), findsOneWidget);
  //   await tester.enterText(cityField, "Karachi");
  //   // expect(find.text('Karachi'), findsOneWidget);

  //   Finder loginButton = find.byKey(Key('Add Record Button'));
  //   await tester.tap(loginButton);
  //   await tester.pump();
  //   expect(find.text('Successfully saved the data'), findsWidgets);
  // });

  // test('enter text', () async {
  //   final formFinder = find.byKey(Key('Name'));
  //   final formFinder1 = find.byKey(Key('Age'));
  //   final formFinder2 = find.byKey(Key('City'));

  //   await driver.waitFor(formFinder);
  //   await driver.tap(formFinder);
  //   await driver.enterText('Hello');
  //   print('entered text');

  //   await driver.waitFor(formFinder1);
  //   await driver.tap(formFinder1);
  //   await driver.enterText('123456');
  //   print('entered number');
  // });

  // testWidgets("Flutter Widget Test", (WidgetTester tester) async {
  //   // await tester.pumpWidget(MyApp());
  //   // // var textField = find.byType(TextField);
  //   // expect(find.text('Name'), findsOneWidget);

  //   // await tester.pumpWidget(MyApp());
  //   //  var textField = find.byType(TextField);
  //   //  expect(textField, findsOneWidget);
  //   // expect(find.text('Name'), findsOneWidget);
  //   // await tester.enterText(find.byType(TextField), 'hi');

  //   final TextField textField = tester.widget<TextField>(find.text('Name'));
  //   expect(textField, findsOneWidget);
  //   // await tester.enterText(textField, 'Flutter Devs');
  //   // final taskItem = find.text('Flutter Devs');
  //   // expect(find.text('Flutter Devs'), findsOneWidget);
  //   // print('Flutter Devs');
  // });
  // testWidgets('Counter increments smoke test', (WidgetTester tester) async {
  //   // Build our app and trigger a frame.
  //   await tester.pumpWidget(const MyApp());

  //   // Verify that our counter starts at 0.
  //   expect(find.text('0'), findsOneWidget);
  //   expect(find.text('1'), findsNothing);

  //   // Tap the '+' icon and trigger a frame.
  //   await tester.tap(find.byIcon(Icons.add));
  //   await tester.pump();

  //   // Verify that our counter has incremented.
  //   expect(find.text('0'), findsNothing);
  //   expect(find.text('1'), findsOneWidget);
  // }
  //);
}
