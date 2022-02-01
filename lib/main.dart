import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_services_binding/flutter_services_binding.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:path_provider/path_provider.dart';
import 'package:very_good_weather/app.dart';
import 'package:weather_repository/weather_repository.dart';

Future<void> main() async {
  FlutterServicesBinding.ensureInitialized();

  /// HydratedStorage.build() asynchronously creates the connection
  /// between the HydratedBloc and the device's local storage.
  final storage = await HydratedStorage.build(
    /// If no value is provided for storageDirectory,
    ///  the data will be stored in a temporary storage.
    ///  This storage can be removed by OS at any point, so
    ///  it is not recommended to use.
    storageDirectory: kIsWeb
        ? HydratedStorage.webStorageDirectory

        /// Changed getTemporaryDirectory() to
        /// getApplicationDocumentsDirectory().
        /// This calls native code to initialize the required storage and
        /// link to HydratedBloc.
        : await getApplicationDocumentsDirectory(),
  );
  HydratedBlocOverrides.runZoned(
    () => runApp(
      WeatherApp(
        weatherRepository: WeatherRepository(),
      ),
    ),
    storage: storage,
  );
}
