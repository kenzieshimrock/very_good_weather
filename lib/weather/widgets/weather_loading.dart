import 'package:flutter/material.dart';
import 'package:very_good_weather/styles/sizing.dart';

/// WeatherLoading() widget displays when
/// WeatherStatus == loading
class WeatherLoading extends StatelessWidget {
  /// WeatherLoading Constructor
  const WeatherLoading({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(
          'Loading Weather',
          style: TextStyle(fontSize: Sizing.large),
        ),
        const Padding(
          padding: EdgeInsets.all(16),
          child: CircularProgressIndicator(
            color: Colors.black,
          ),
        ),
      ],
    );
  }
}
