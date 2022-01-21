import 'package:json_annotation/json_annotation.dart';

part 'weather.g.dart';

/*
  Weather model should store data returned by weather API. Looks like the following:
    {
    "id": 5037922198749184,
    "weather_state_name": "Heavy Cloud",
    "weather_state_abbr": "hc",
    "wind_direction_compass": "SSE",
    "created": "2021-05-28T15:32:01.902125Z",
    "applicable_date": "2021-05-28",
    "min_temp": 9.61,
    "max_temp": 19.375,
    "the_temp": 18.54,
    "wind_speed": 3.0192401717198227,
    "wind_direction": 148.63313166521016,
    "air_pressure": 1023.0,
    "humidity": 57,
    "visibility": 10.56983466555317,
    "predictability": 71
  }
 */

// WeatherState enumeration to store weather constants.
enum WeatherState {
  @JsonValue('sn')
  snow,
  @JsonValue('sl')
  sleet,
  @JsonValue('h')
  hail,
  @JsonValue('t')
  thunderstorm,
  @JsonValue('hr')
  heavyRain,
  @JsonValue('lr')
  lightRain,
  @JsonValue('s')
  showers,
  @JsonValue('hc')
  heavyCloud,
  @JsonValue('lc')
  lightCloud,
  @JsonValue('c')
  clear,
  unknown
}

extension WeatherStateX on WeatherState {
  String? get abbr => _$WeatherStateEnumMap[this];
}

// WindDirectionCompass enumeration to store wind direction constants.
enum WindDirectionCompass {
  @JsonValue('N')
  north,
  @JsonValue('NE')
  northEast,
  @JsonValue('E')
  east,
  @JsonValue('SE')
  southEast,
  @JsonValue('S')
  south,
  @JsonValue('SW')
  southWest,
  @JsonValue('W')
  west,
  @JsonValue('NW')
  northWest,
  unknown
}

@JsonSerializable()
class Weather {
  const Weather({
    required this.id,
    required this.weatherStateName,
    required this.weatherStateAbbr,
    required this.windDirectionCompass,
    required this.created,
    required this.applicableDate,
    required this.minTemp,
    required this.maxTemp,
    required this.theTemp,
    required this.windSpeed,
    required this.windDirection,
    required this.airPressure,
    required this.humidity,
    required this.visibility,
    required this.predictability,
  });

  factory Weather.fromJson(Map<String, dynamic> json) =>
      _$WeatherFromJson(json);

  final int id;
  final String weatherStateName;
  final WeatherState weatherStateAbbr;
  final WindDirectionCompass windDirectionCompass;
  final DateTime created;
  final DateTime applicableDate;
  final double minTemp;
  final double maxTemp;
  final double theTemp;
  final double windSpeed;
  final double windDirection;
  final double airPressure;
  final int humidity;
  final double visibility;
  final int predictability;
}