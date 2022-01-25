import 'package:flutter/material.dart';
import 'package:very_good_weather/styles/sizing.dart';
import 'package:very_good_weather/weather/weather.dart';

/// WeatherPopulated widget is displayed on weather page
/// when data is successfully retrieved from weather_repository
class WeatherPopulated extends StatelessWidget {
  /// WeatherPopulated constructor
  const WeatherPopulated({
    Key? key,
    required this.weather,
    required this.units,
    required this.onRefresh,
  }) : super(key: key);

  /// weather data from weather_repository
  final Weather weather;

  /// celsius or fahrenheit
  final TemperatureUnits units;

  /// function that is called when user "refreshes" weather page
  final ValueGetter<Future<void>> onRefresh;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        RefreshIndicator(
          backgroundColor: Colors.black,
          color: Colors.white,
          onRefresh: onRefresh,
          child: SingleChildScrollView(
            physics: const AlwaysScrollableScrollPhysics(),
            clipBehavior: Clip.none,
            child: Center(
              child: Column(
                children: [
                  _WeatherIcon(
                    condition: weather.condition,
                  ),
                  Text(
                    weather.location,
                    style: TextStyle(
                      fontSize: Sizing.xlarge * 1.3,
                    ),
                  ),
                  Text(
                    weather.formattedTemperature(units),
                    style: TextStyle(
                      fontSize: Sizing.xlarge * 1.3,
                    ),
                  ),
                  Text(
                    '''Last Updated at ${TimeOfDay.fromDateTime(weather.lastUpdated).format(context)}''',
                    style: TextStyle(
                      fontSize: Sizing.medium,
                      color: Colors.grey,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}

class _WeatherIcon extends StatelessWidget {
  const _WeatherIcon({Key? key, required this.condition}) : super(key: key);

  final WeatherCondition condition;

  @override
  Widget build(BuildContext context) {
    return Image.asset(
      condition.toImagePath,
      scale: 1,
    );
  }
}

extension on WeatherCondition {
  String get toImagePath {
    switch (this) {
      case WeatherCondition.clear:
        return 'assets/weather_icons/sunny.png';
      case WeatherCondition.rainy:
        return 'assets/weather_icons/rainy.png';
      case WeatherCondition.cloudy:
        return 'assets/weather_icons/cloudy.png';
      case WeatherCondition.snowy:
        return 'assets/weather_icons/snowy.png';
      case WeatherCondition.unknown:
        return 'assets/weather_icons/sunny.png';
    }
  }
}

extension on Weather {
  String formattedTemperature(TemperatureUnits units) {
    return '''${temperature.value.toStringAsPrecision(2)}°${units.isCelsius ? 'C' : 'F'}''';
  }
}
