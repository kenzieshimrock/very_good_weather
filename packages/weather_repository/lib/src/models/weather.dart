import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'weather.g.dart';

/// Weather condition model
enum WeatherCondition {
  /// clear
  clear,

  /// rainy
  rainy,

  /// cloudy
  cloudy,

  /// snowy
  snowy,

  /// unknown
  unknown,
}

/// Weather Model class
@JsonSerializable()
class Weather extends Equatable {
  /// Weather constructor
  const Weather({
    required this.location,
    required this.temperature,
    required this.condition,
  });

  /// Json Deserialization
  factory Weather.fromJson(Map<String, dynamic> json) =>
      _$WeatherFromJson(json);

  /// Json Serialization
  Map<String, dynamic> toJson() => _$WeatherToJson(this);

  /// city
  final String location;

  /// temperature value
  final double temperature;

  /// weather condition
  final WeatherCondition condition;

  @override
  List<Object> get props =>
      [location, temperature, condition];
}
