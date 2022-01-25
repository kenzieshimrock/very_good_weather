import 'package:equatable/equatable.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:very_good_weather/weather/weather.dart';
import 'package:weather_repository/weather_repository.dart'
    show WeatherRepository;

part 'weather_cubit.g.dart';
part 'weather_state.dart';

/// Weather cubit that fetches data from weather_repository and
/// emits state changes.
class WeatherCubit extends HydratedCubit<WeatherState> {
  /// WeatherCubit constructor
  WeatherCubit(this._weatherRepository)
      : super(WeatherState());

  final WeatherRepository _weatherRepository;

  /// Retrieves weather object for given city from weather_repository
  Future<void> fetchWeather(String? city) async {
    if (city == null || city.isEmpty) return;
    emit(state.copyWith(status: WeatherStatus.loading));

    try {
      /*
            Weather() object containing "location," "temperature," and
            "condition" data from weather repository is assigned to the
             weather variable.
       */
      final weather = Weather.fromRepository(
        /*
          within the weatherRepository, "getWeather()" attempts to retrieve
           weather data from external DB, and returns a Weather()
            object containing only data relevant to application.
         */
        await _weatherRepository.getWeather(city),
      );

      // Current temperature units
      final units = state.temperatureUnits;
      final value = units.isFahrenheit
          ? weather.temperature.value.toFahrenheit()
          : weather.temperature.value;

      /*
        emits a state change with new values for "status,"
        "temperatureUnits," and "weather."
       */
      emit(
        state.copyWith(
          status: WeatherStatus.success,
          temperatureUnits: units,
          weather: weather.copyWith(
            temperature: Temperature(value: value),
          ),
        ),
      );
    } on Exception {
      /*
        emits a state change with failing value for "status" if Weather()
        object from weather repository is unretrievable.
       */
      emit(state.copyWith(status: WeatherStatus.failure));
    }
  }

  /// Retrieves new Weather() object using the weather repository given the
  /// current weather state
  Future<void> refreshWeather() async {
    if (!state.status.isSuccess) return;
    if (state.weather == Weather.empty) return;
    try {
      /*
        Within the weatherRepository, "getWeather()" attempts to retrieve
        updated weather data from external DB,
        and returns an updated Weather() object for the current
         state's location.
       */
      final weather = Weather.fromRepository(
        await _weatherRepository
            .getWeather(state.weather.location),
      );

      // Current temperature units
      final units = state.temperatureUnits;
      final value = units.isFahrenheit
          ? weather.temperature.value.toFahrenheit()
          : weather.temperature.value;

      // emits a state change with new values for "status," "temperatureUnits,"
      // and "weather."
      emit(
        state.copyWith(
          status: WeatherStatus.success,
          temperatureUnits: units,
          weather: weather.copyWith(
            temperature: Temperature(value: value),
          ),
        ),
      );

      // if there is no update to state properties, emit "new" state with
      // unchanged values
    } on Exception {
      emit(state);
    }
  }

  /// Toggles Celsius and Fahrenheit values
  void toggleUnits() {
    final units = state.temperatureUnits.isFahrenheit
        ? TemperatureUnits.celsius
        : TemperatureUnits.fahrenheit;

    // Emits a new state containing updated temperatureUnits value if status
    // isn't "isSuccess"
    if (!state.status.isSuccess) {
      emit(state.copyWith(temperatureUnits: units));
      return;
    }

    final weather = state.weather;
    if (weather != Weather.empty) {
      final temperature = weather.temperature;
      final value = units.isCelsius
          ? temperature.value.toCelsius()
          : temperature.value.toFahrenheit();
      // Emits a new state containing updated temperatureUnits and weather
      // values if weather isn't empty
      emit(
        state.copyWith(
          temperatureUnits: units,
          weather: weather.copyWith(
            temperature: Temperature(value: value),
          ),
        ),
      );
    }
  }

  // For state data Persistence
  @override
  WeatherState fromJson(Map<String, dynamic> json) =>
      WeatherState.fromJson(json);

  // For state data Persistence
  @override
  Map<String, dynamic> toJson(WeatherState state) =>
      state.toJson();
}

extension on double {
  double toFahrenheit() => (this * 9 / 5) + 32;

  double toCelsius() => (this - 32) * 5 / 9;
}
