import 'package:flutter/material.dart';
import 'package:flutter_application_mini_project/screen/splash_screen/splash_screen.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  testWidgets('Logo muncul', (widgetTester) async {
    await widgetTester.pumpWidget(
      const MaterialApp(
        home: SplashScreen(),
      ),
    );

    expect(find.text('TruDav UI'), findsOneWidget);
  });
}