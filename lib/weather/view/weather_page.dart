import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:very_good_weather/search/search.dart';
import 'package:very_good_weather/settings/settings.dart';
import 'package:very_good_weather/styles/sizing.dart';
import 'package:very_good_weather/weather/weather.dart';
import 'package:weather_repository/weather_repository.dart';

/// WeatherPage widget that provides WeatherCubit instance
/// and parents WeatherView widget
class WeatherPage extends StatelessWidget {
  /// WeatherPage constructor
  const WeatherPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // BlocProvider creates the single instance of WeatherCubit() within
    // the widget tree
    return BlocProvider(
      create: (context) => WeatherCubit(context.read<WeatherRepository>()),
      child: const WeatherView(),
    );
  }
}

/// WeatherView widget
class WeatherView extends StatefulWidget {
  ///WeatherView constructor
  const WeatherView({Key? key}) : super(key: key);

  @override
  State<WeatherView> createState() => _WeatherViewState();
}

class _WeatherViewState extends State<WeatherView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Row(
          children: [
            Image.asset(
              'assets/vgv_logo.png',
              scale: 14,
            ),
            SizedBox(
              width: Sizing.standard,
            ),
            Text(
              'Very Good Weather',
              style: TextStyle(fontSize: Sizing.medium),
            ),
          ],
        ),
        centerTitle: false,
        actions: [
          IconButton(
            icon: const Icon(
              Icons.settings,
              color: Colors.black,
            ),
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
        padding: const EdgeInsets.all(30),
        child: Center(
          // BlocBuilder allows UI to re-render based on state changes emitted
          // from WeatherCubit() instance
          child: BlocBuilder<WeatherCubit, WeatherState>(
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
          if (!mounted) return;
          await context.read<WeatherCubit>().fetchWeather(city);
        },
      ),
    );
  }
}
