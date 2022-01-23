import 'dart:async';

import 'package:meta_weather_api/meta_weather_api.dart' hide Weather;
import 'package:weather_repository/weather_repository.dart';

class WeatherFailure implements Exception {}

class WeatherRepository {
  WeatherRepository({MetaWeatherApiClient? weatherApiClient})
      : _weatherApiClient = weatherApiClient ?? MetaWeatherApiClient();

  final MetaWeatherApiClient _weatherApiClient;

  /*
    Attempts to retrieve weather data from external DB,
    and returns a Weather() object containing only data relevant to application.
  */
  Future<Weather> getWeather(String city) async {
    final location = await _weatherApiClient.locationSearch(city);
    final woeid = location.woeid;
    final weather = await _weatherApiClient.getWeather(woeid);

    return Weather(
      temperature: weather.theTemp,
      location: location.title,
      condition: weather.weatherStateAbbr.toCondition,
    );
  }
}

// Converts WeatherState Model data retrieved from Meta_Weather_API to corresponding WeatherCondition Model data
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
      default:
        return WeatherCondition.unknown;
    }
  }
}
