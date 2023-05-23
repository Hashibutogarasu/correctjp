// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility in the flutter_test package. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.

// ignore_for_file: avoid_print

import 'package:correctjp/converter.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:correctjp/main.dart';

void main() {
  testWidgets('Test Convert coorectJP', (WidgetTester tester) async {
    // Build our app and trigger a frame.
    await tester.pumpWidget(const MyApp());

    await Converter(prompt: "あなたは怪しい日本語を変換することができます！").converttocjp().then((value){
      print(value);
    });
  });
}
