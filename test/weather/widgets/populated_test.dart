// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:very_good_weather/weather/weather.dart';

void main() {
  group('WeatherPopulated', () {
    final weather = Weather(
      condition: WeatherCondition.clear,
      temperature: Temperature(value: 42),
      location: 'Chicago',
      lastUpdated: DateTime(2020),
    );

    testWidgets(
      'renders correct text',
      (tester) async {
        await tester.pumpWidget(
          MaterialApp(
            home: Scaffold(
              body: WeatherPopulated(
                weather: weather,
                units: TemperatureUnits.fahrenheit,
                onRefresh: () async {},
              ),
            ),
          ),
        );
        expect(find.text('Chicago'), findsOneWidget);
      },
    );
    // Want to test for proper images being populated in the weather
    // populated page.
    // todo: research testing asset images.
  });
}
