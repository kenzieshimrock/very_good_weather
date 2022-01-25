import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:very_good_weather/weather/weather.dart';
import 'package:weather_repository/weather_repository.dart';

/// Weather App base widget
class WeatherApp extends StatelessWidget {
  /// WeatherApp constructor
  const WeatherApp({
    Key? key,
    required WeatherRepository weatherRepository,
  })  : _weatherRepository = weatherRepository,
        super(key: key);

  final WeatherRepository _weatherRepository;

  @override
  Widget build(BuildContext context) {
    return RepositoryProvider.value(
      value: _weatherRepository,
      child: const WeatherAppView(),
    );
  }
}

/// WeatherAppView widget
class WeatherAppView extends StatelessWidget {
  /// WeatherAppView constructor
  const WeatherAppView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return MaterialApp(
      theme: ThemeData(
        switchTheme: SwitchThemeData(
          thumbColor: MaterialStateProperty.resolveWith(
            (states) {
              Color? color;
              if (states.contains(MaterialState.selected)) {
                color = Colors.white;
              }
              return color;
            },
          ),
          trackColor: MaterialStateProperty.resolveWith(
            (states) {
              Color? color;
              if (states.contains(MaterialState.selected)) {
                color = Colors.black;
              }
              return color;
            },
          ),
        ),
        textTheme: GoogleFonts.dongleTextTheme(),
        appBarTheme: AppBarTheme(
          backgroundColor: Colors.white,
          titleTextStyle:
              GoogleFonts.dongleTextTheme(textTheme)
                  .apply(bodyColor: Colors.black)
                  .headline6,
        ),
        iconTheme: const IconThemeData(
          color: Colors.black,
        ),
      ),
      home: const WeatherPage(),
    );
  }
}
