import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:very_good_weather/search/search.dart';
import 'package:very_good_weather/settings/settings.dart';
import 'package:very_good_weather/styles/sizing.dart';
import 'package:very_good_weather/theme/theme.dart';
import 'package:very_good_weather/weather/weather.dart';
import 'package:weather_repository/weather_repository.dart';

class WeatherPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => WeatherCubit(context.read<WeatherRepository>()),
      child: WeatherView(),
    );
  }
}

class WeatherView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Row(
          children: [
            Image.asset(
              'assets/vgv_unicorn_filled.png',
              scale: 45,
            ),
            SizedBox(
              width: Sizing.standard,
            ),
            const Text('Very Good Weather'),
          ],
        ),
        centerTitle: false,
        actions: [
          IconButton(
            icon: const Icon(Icons.settings, color: Colors.black),
            tooltip: 'settings',
            onPressed: () {
              Navigator.of(context).push<void>(
                SettingsPage.route(
                  context.read<WeatherCubit>(),
                ),
              );
            },
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(30.0),
        child: Center(
          child: BlocConsumer<WeatherCubit, WeatherState>(
            listener: (context, state) {
              if (state.status.isSuccess) {
                context.read<ThemeCubit>().updateTheme(state.weather);
              }
            },
            builder: (context, state) {
              switch (state.status) {
                case WeatherStatus.initial:
                  return const WeatherEmpty();
                case WeatherStatus.loading:
                  return const WeatherLoading();
                case WeatherStatus.success:
                  return WeatherPopulated(
                    weather: state.weather,
                    units: state.temperatureUnits,
                    onRefresh: () {
                      return context.read<WeatherCubit>().refreshWeather();
                    },
                  );
                case WeatherStatus.failure:
                default:
                  return const WeatherError();
              }
            },
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.black,
        tooltip: 'search',
        child: const Icon(Icons.search),
        onPressed: () async {
          final city = await Navigator.of(context).push(SearchPage.route());
          await context.read<WeatherCubit>().fetchWeather(city);
        },
      ),
    );
  }
}
