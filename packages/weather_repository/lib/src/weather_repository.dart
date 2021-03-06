import 'dart:async';

import 'package:meta_weather_api/meta_weather_api.dart'
    hide Weather;
import 'package:weather_repository/weather_repository.dart';

/// WeatherFailure Exception
class WeatherFailure implements Exception {}

/// WeatherRepository class
class WeatherRepository {
  /// WeatherRepository constructor
  WeatherRepository({
    MetaWeatherApiClient? weatherApiClient,
  }) : _weatherApiClient =
            weatherApiClient ?? MetaWeatherApiClient();

  final MetaWeatherApiClient _weatherApiClient;

  /// attempts to retrieve weather data from Weather API
  Future<Weather> getWeather(String city) async {
    final location =
        await _weatherApiClient.locationSearch(city);
    final woeid = location.woeid;
    final weather =
        await _weatherApiClient.getWeather(woeid);
    return Weather(
      temperature: weather.theTemp,
      location: location.title,
      condition: weather.weatherStateAbbr.toCondition,
    );
  }
}

/// allows creation of WeatherState class functionality that is
/// separate from the class's original functionality but allows the use
/// of the class's original functionality.
extension on WeatherState {
  WeatherCondition get toCondition {
    switch (this) {
      case WeatherState.clear:
        return WeatherCondition.clear;
      case WeatherState.snow:
      case WeatherState.sleet:
      case WeatherState.hail:
        return WeatherCondition.snowy;
      case WeatherState.thunderstorm:
      case WeatherState.heavyRain:
      case WeatherState.lightRain:
      case WeatherState.showers:
        return WeatherCondition.rainy;
      case WeatherState.heavyCloud:
      case WeatherState.lightCloud:
        return WeatherCondition.cloudy;
      case WeatherState.unknown:
        return WeatherCondition.unknown;
    }
  }
}
