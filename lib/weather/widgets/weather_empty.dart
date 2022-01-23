import 'package:flutter/material.dart';
import 'package:very_good_weather/styles/sizing.dart';

class WeatherEmpty extends StatelessWidget {
  const WeatherEmpty({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Icon(
          Icons.domain,
          size: Sizing.large,
        ),
        SizedBox(height: Sizing.standard),
        Text(
          'Please Search for a City',
          style: TextStyle(color: Colors.black, fontSize: Sizing.large),
        ),
      ],
    );
  }
}
