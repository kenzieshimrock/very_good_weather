import 'package:flutter/material.dart';
import 'package:very_good_weather/styles/sizing.dart';

/// WeatherError widget displays when weather data
/// retrieval fails
class WeatherError extends StatelessWidget {
  /// WeatherError constructor
  const WeatherError({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(
          Icons.error_outline,
          size: Sizing.large,
        ),
        SizedBox(height: Sizing.standard),
        Text(
          'Something went wrong!',
          style: TextStyle(fontSize: Sizing.large),
        ),
        Text(
          'Check your connection, or try searching for a different city.',
          textAlign: TextAlign.center,
          style: TextStyle(
            fontSize: Sizing.medium,
            color: Colors.black38,
          ),
        ),
      ],
    );
  }
}
