import 'package:flutter/material.dart';
import 'package:very_good_weather/styles/sizing.dart';
import 'package:very_good_weather/weather/weather.dart';

class WeatherPopulated extends StatelessWidget {
  const WeatherPopulated({
    Key? key,
    required this.weather,
    required this.units,
    required this.onRefresh,
  }) : super(key: key);

  final Weather weather;
  final TemperatureUnits units;
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
                  _WeatherIcon(condition: weather.condition),
                  Text(
                    weather.location,
                    style: TextStyle(fontSize: (Sizing.xlarge * 1.3)),
                  ),
                  Text(
                    weather.formattedTemperature(units),
                    style: TextStyle(fontSize: (Sizing.xlarge * 1.3)),
                  ),
                  Text(
                    '''Last Updated at ${TimeOfDay.fromDateTime(weather.lastUpdated).format(context)}''',
                    style:
                        TextStyle(fontSize: Sizing.medium, color: Colors.grey),
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
      default:
        return 'assets/weather_icons/sunny.png';
    }
  }
}

extension on Weather {
  String formattedTemperature(TemperatureUnits units) {
    return '''${temperature.value.toStringAsPrecision(2)}°${units.isCelsius ? 'C' : 'F'}''';
  }
}
