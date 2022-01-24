// ignore_for_file: prefer_const_constructors
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:very_good_weather/weather/widgets/weather_empty.dart';

void main() {
  group('WeatherEmpty', () {
    testWidgets('renders correct text and icon', (tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: WeatherEmpty(),
          ),
        ),
      );
      expect(find.text('Please Search for a City'), findsOneWidget);
    });
  });
}
