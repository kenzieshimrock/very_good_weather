import 'package:json_annotation/json_annotation.dart';

part 'weather.g.dart';

/// WeatherState model enumeration
enum WeatherState {
  /// snow
  @JsonValue('sn')
  snow,

  /// sleet
  @JsonValue('sl')
  sleet,

  /// hail
  @JsonValue('h')
  hail,

  /// thunderstorm
  @JsonValue('t')
  thunderstorm,

  /// heavy rain
  @JsonValue('hr')
  heavyRain,

  /// light rain
  @JsonValue('lr')
  lightRain,

  /// showers
  @JsonValue('s')
  showers,

  /// heavy cloud
  @JsonValue('hc')
  heavyCloud,

  /// light cloud
  @JsonValue('lc')
  lightCloud,

  /// clear
  @JsonValue('c')
  clear,

  /// unknown
  unknown
}

/// WeatherState extension
extension WeatherStateX on WeatherState {
  /// provides WeatherState abbreviations
  String? get abbr => _$WeatherStateEnumMap[this];
}

/// WindDirection model enumeration
enum WindDirectionCompass {
  /// north
  @JsonValue('N')
  north,

  /// north east
  @JsonValue('NE')
  northEast,

  /// east
  @JsonValue('E')
  east,

  /// south east
  @JsonValue('SE')
  southEast,

  /// south
  @JsonValue('S')
  south,

  /// south west
  @JsonValue('SW')
  southWest,

  /// west
  @JsonValue('W')
  west,

  /// north west
  @JsonValue('NW')
  northWest,

  /// unknown
  unknown,
}

/// Weather model class
@JsonSerializable()
class Weather {
  /// Weather constructor
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

  /// Json Deserialization
  factory Weather.fromJson(Map<String, dynamic> json) =>
      _$WeatherFromJson(json);

  /// internal identifier for forecase
  final int id;

  /// text description of the weather state
  final String weatherStateName;

  /// WeatherState abbreviation
  @JsonKey(unknownEnumValue: WeatherState.unknown)
  final WeatherState weatherStateAbbr;

  /// WindDirection abbreviation
  @JsonKey(unknownEnumValue: WindDirectionCompass.unknown)
  final WindDirectionCompass windDirectionCompass;

  /// forecast creation time
  final DateTime created;

  /// forecast date
  final DateTime applicableDate;

  /// minimum temperature
  final double minTemp;

  /// maximum temperature
  final double maxTemp;

  /// current temperature
  final double theTemp;

  /// wind speed
  final double windSpeed;

  /// wind direction
  final double windDirection;

  /// air pressure
  final double airPressure;

  /// humidity
  final int humidity;

  /// visibility
  final double visibility;

  /// API's interpretation of the level to which the forecast agrees
  /// with each other - 100% being a complete consensus
  final int predictability;
}
