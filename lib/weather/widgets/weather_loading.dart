import 'package:flutter/material.dart';
import 'package:very_good_weather/styles/sizing.dart';

class WeatherLoading extends StatelessWidget {
  const WeatherLoading({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Text(
          'Loading Weather',
          style: TextStyle(fontSize: Sizing.large),
        ),
        const Padding(
          padding: EdgeInsets.all(16.0),
          child: CircularProgressIndicator(color: Colors.black),
        ),
      ],
    );
  }
}
