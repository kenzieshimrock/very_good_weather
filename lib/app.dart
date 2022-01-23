import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:very_good_weather/theme/theme.dart';
import 'package:very_good_weather/weather/weather.dart';
import 'package:weather_repository/weather_repository.dart';

class WeatherApp extends StatelessWidget {
  const WeatherApp({Key? key, required WeatherRepository weatherRepository})
      : _weatherRepository = weatherRepository,
        super(key: key);

  final WeatherRepository _weatherRepository;

  @override
  Widget build(BuildContext context) {
    return RepositoryProvider.value(
      value: _weatherRepository,
      child: BlocProvider(
        create: (_) => ThemeCubit(),
        child: WeatherAppView(),
      ),
    );
  }
}

class WeatherAppView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return BlocBuilder<ThemeCubit, Color>(
      builder: (context, color) {
        return MaterialApp(
          theme: ThemeData(
            switchTheme: SwitchThemeData(
              thumbColor: MaterialStateProperty.resolveWith(
                (states) {
                  if (states.contains(MaterialState.selected)) {
                    return Colors.white;
                  }
                },
              ),
              trackColor: MaterialStateProperty.resolveWith(
                (states) {
                  if (states.contains(MaterialState.selected)) {
                    return Colors.black;
                  }
                },
              ),
            ),
            textTheme: GoogleFonts.dongleTextTheme(),
            appBarTheme: AppBarTheme(
              backgroundColor: Colors.white,
              titleTextStyle: GoogleFonts.dongleTextTheme(textTheme)
                  .apply(bodyColor: Colors.black)
                  .headline6,
            ),
            iconTheme: const IconThemeData(
              color: Colors.black,
            ),
          ),
          home: WeatherPage(),
        );
      },
    );
  }
}
