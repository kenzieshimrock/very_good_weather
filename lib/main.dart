import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_services_binding/flutter_services_binding.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:path_provider/path_provider.dart';
import 'package:very_good_weather/app.dart';
import 'package:weather_repository/weather_repository.dart';

Future<void> main() async {
  FlutterServicesBinding.ensureInitialized();
  final storage = await HydratedStorage.build(
    storageDirectory: kIsWeb
        ? HydratedStorage.webStorageDirectory
        : await getTemporaryDirectory(),
  );
  HydratedBlocOverrides.runZoned(
    () => runApp(
      WeatherApp(weatherRepository: WeatherRepository()),
    ),
    storage: storage,
  );
}
