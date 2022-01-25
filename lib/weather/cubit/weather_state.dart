part of 'weather_cubit.dart';

/// status of retrieving weather data
enum WeatherStatus {
  /// initial status
  initial,

  /// loading status/attempting to retrieve data
  loading,

  /// success status when data is successfully retrieved
  success,

  /// failure status when data is not successfully retrieved
  failure
}

/// WeahterStatus extension
extension WeatherStatusX on WeatherStatus {
  /// boolean "assignment" of getting initial status
  bool get isInitial => this == WeatherStatus.initial;

  /// boolean "assignment" of getting loading status
  bool get isLoading => this == WeatherStatus.loading;

  /// boolean "assignment" of getting success status
  bool get isSuccess => this == WeatherStatus.success;

  /// boolean "assignment" of getting failure status
  bool get isFailure => this == WeatherStatus.failure;
}

/// WeatherState class
@JsonSerializable()
class WeatherState extends Equatable {
  /// WeatherState constructor, sets default values for status and
  /// temperatureUnits
  WeatherState({
    this.status = WeatherStatus.initial,
    this.temperatureUnits = TemperatureUnits.celsius,
    Weather? weather,
  }) : weather = weather ?? Weather.empty;

  /// Json deserialization
  factory WeatherState.fromJson(
    Map<String, dynamic> json,
  ) =>
      _$WeatherStateFromJson(json);

  /// status of weather data retrieval
  final WeatherStatus status;

  /// weather data model
  final Weather weather;

  /// Temperature units data model
  final TemperatureUnits temperatureUnits;

  /// Creates a copy of WeatherState with updated/changed values
  WeatherState copyWith({
    WeatherStatus? status,
    TemperatureUnits? temperatureUnits,
    Weather? weather,
  }) {
    return WeatherState(
      status: status ?? this.status,
      temperatureUnits: temperatureUnits ?? this.temperatureUnits,
      weather: weather ?? this.weather,
    );
  }

  /// Json Serialization
  Map<String, dynamic> toJson() => _$WeatherStateToJson(this);

  @override
  List<Object?> get props => [status, temperatureUnits, weather];
}
