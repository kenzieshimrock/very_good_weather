import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:very_good_weather/styles/sizing.dart';
import 'package:very_good_weather/weather/weather.dart';

class SettingsPage extends StatelessWidget {
  static Route route(WeatherCubit weatherCubit) {
    return MaterialPageRoute<void>(
      // BlocProvider.value provides the existing WeatherCubit instance to its child.
      builder: (_) => BlocProvider.value(
        value: weatherCubit,
        child: SettingsPage(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: IntrinsicWidth(
          child: Row(
            children: [
              Image.asset(
                'assets/vgv_logo.png',
                scale: 14,
              ),
              SizedBox(
                width: Sizing.standard,
              ),
              const Text('Very Good Settings'),
            ],
          ),
        ),
        iconTheme: const IconThemeData(color: Colors.black),
      ),
      body: Padding(
        padding: EdgeInsets.all(Sizing.standard),
        child: ListView(
          children: <Widget>[
            // BlocBuilder rebuilds UI based on state changes emitting from WeatherCubit() instance
            BlocBuilder<WeatherCubit, WeatherState>(
              buildWhen: (previous, current) =>
                  previous.temperatureUnits != current.temperatureUnits,
              builder: (context, state) {
                return ListTile(
                  title: Text(
                    'Temperature Units',
                    style: TextStyle(fontSize: Sizing.medium),
                  ),
                  isThreeLine: true,
                  subtitle: Text(
                    'Current: ${state.temperatureUnits.isCelsius ? 'Celsius' : 'Fahrenheit'}',
                    style: TextStyle(fontSize: Sizing.standard),
                  ),
                  trailing: Switch(
                    value: state.temperatureUnits.isCelsius,
                    onChanged: (_) =>
                        context.read<WeatherCubit>().toggleUnits(),
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
