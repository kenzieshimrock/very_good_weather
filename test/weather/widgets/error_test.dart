// ignore_for_file: prefer_const_constructors
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:very_good_weather/weather/widgets/weather_error.dart';

void main() {
  group('WeatherError', () {
    testWidgets('renders correct text and icon',
        (tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: WeatherError(),
          ),
        ),
      );
      expect(
        find.text('Something went wrong!'),
        findsOneWidget,
      );
      expect(
        find.text(
          'Check your connection, or try searching for a different city.',
        ),
        findsWidgets,
      );
      expect(
        find.byIcon(Icons.error_outline),
        findsOneWidget,
      );
    });
  });
}
