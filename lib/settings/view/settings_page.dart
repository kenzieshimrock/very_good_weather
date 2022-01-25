import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:very_good_weather/styles/sizing.dart';
import 'package:very_good_weather/weather/weather.dart';

/// SettingsPage widget
class SettingsPage extends StatelessWidget {
  /// SettingsPage Widget constructor
  const SettingsPage({Key? key}) : super(key: key);

  /// Returns new MaterialPageRoute
  static Route route(WeatherCubit weatherCubit) {
    return MaterialPageRoute<void>(
      /*
       BlocProvider.value provides the existing WeatherCubit
       instance to its child.
       */
      builder: (_) => BlocProvider.value(
        value: weatherCubit,
        child: const SettingsPage(),
      ),
    );
  }

  /// celsius or fahrenheit
  String temperatureString;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Very Good Settings',
          style: TextStyle(fontSize: Sizing.medium),
        ),
        iconTheme: const IconThemeData(color: Colors.black),
      ),
      body: Padding(
        padding: EdgeInsets.all(Sizing.standard),
        child: ListView(
          children: <Widget>[
            /*
               BlocBuilder rebuilds UI based on state changes emitting from
                WeatherCubit() instance
             */
            BlocBuilder<WeatherCubit, WeatherState>(
              buildWhen: (previous, current) =>
                  previous.temperatureUnits !=
                  current.temperatureUnits,
              builder: (context, state) {
                /// This had to be created because Intellij would
                /// not format correctly when placed as string interpolation
                /// inline. Exceeded 80 lines + max-lines formatting settings
                /// are properly set. Looking for solution.
                temperatureString =
                    state.temperatureUnits.isCelsius
                        ? 'Celsius'
                        : 'Fahrenheit';
                return ListTile(
                  title: Text(
                    'Temperature Units',
                    style: TextStyle(
                      fontSize: Sizing.medium,
                    ),
                  ),
                  isThreeLine: true,
                  subtitle: Text(
                    'Current: $temperatureString',
                    style: TextStyle(
                      fontSize: Sizing.medium,
                      color: Colors.black38,
                    ),
                  ),
                  trailing: Switch(
                    value: state.temperatureUnits.isCelsius,
                    onChanged: (_) => context
                        .read<WeatherCubit>()
                        .toggleUnits(),
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
