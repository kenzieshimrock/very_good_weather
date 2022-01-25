import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:weather_repository/weather_repository.dart'
    hide Weather;
import 'package:weather_repository/weather_repository.dart'
as weather_repository;

part 'weather.g.dart';

/// Temperature units enumeration
enum TemperatureUnits {
  /// fahrenheit value
  fahrenheit,

  /// celsius value
  celsius
}

/// TemperatureUnits enumeration extension
extension TemperatureUnitsX on TemperatureUnits {
  /// boolean "assignment" of temperature unit fahrenheit status
  bool get isFahrenheit =>
      this == TemperatureUnits.fahrenheit;

  /// boolean "assignment" of temperature unit celsius status
  bool get isCelsius => this == TemperatureUnits.celsius;
}

/// Temperature model class
@JsonSerializable()
class Temperature extends Equatable {
  /// Temperature constructor
  const Temperature({required this.value});

  /// Json Deserialization
  factory Temperature.fromJson(Map<String, dynamic> json) =>
      _$TemperatureFromJson(json);

  /// temperature value (displayed on WeatherView)
  final double value;

  /// Json Serialization
  Map<String, dynamic> toJson() =>
      _$TemperatureToJson(this);

  @override
  List<Object> get props => [value];
}

/// Weather model class
@JsonSerializable()
class Weather extends Equatable {
  /// Weather constructor
  const Weather({
    required this.condition,
    required this.lastUpdated,
    required this.location,
    required this.temperature,
  });

  /// Json Deserialization
  factory Weather.fromJson(Map<String, dynamic> json) =>
      _$WeatherFromJson(json);

  /// Retrieves weather data from weather_repository and creates
  /// Weather() instance with applicable data
  factory Weather.fromRepository(
      weather_repository.Weather weather,) {
    return Weather(
      condition: weather.condition,
      lastUpdated: DateTime.now(),
      location: weather.location,
      temperature: Temperature(value: weather.temperature),
    );
  }

  /// Default Weather() instance for WeatherEmpty()
  static final empty = Weather(
    condition: WeatherCondition.unknown,
    lastUpdated: DateTime(0),
    temperature: const Temperature(value: 0),
    location: '--',
  );

  /// clear, rainy, sunny, snowy, unknown
  final WeatherCondition condition;

  /// time in which weather data was last retrieved
  /// and displayed information was updated
  final DateTime lastUpdated;

  /// City name
  final String location;

  /// temperature
  final Temperature temperature;

  @override
  List<Object> get props =>
      [condition, lastUpdated, location, temperature];

  /// Json Serialization
  Map<String, dynamic> toJson() => _$WeatherToJson(this);

  /// Copies Weather() with new/changed values
  Weather copyWith({
    WeatherCondition? condition,
    DateTime? lastUpdated,
    String? location,
    Temperature? temperature,
  }) {
    return Weather(
      condition: condition ?? this.condition,
      lastUpdated: lastUpdated ?? this.lastUpdated,
      location: location ?? this.location,
      temperature: temperature ?? this.temperature,
    );
  }
}
