import 'package:flutter/material.dart';
import 'package:very_good_weather/styles/sizing.dart';

/// WeatherEmpty widget displays when no weather data has been
/// requested from weather API
class WeatherEmpty extends StatelessWidget {
  /// WeatherEmpty constructor
  const WeatherEmpty({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(
          Icons.domain,
          size: Sizing.large,
        ),
        SizedBox(height: Sizing.standard),
        Text(
          'Please Search for a City',
          style: TextStyle(
            color: Colors.black,
            fontSize: Sizing.large,
          ),
        ),
      ],
    );
  }
}
