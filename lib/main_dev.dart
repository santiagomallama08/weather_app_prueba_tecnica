import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

import 'app.dart';
import 'core/config/app_config.dart';
import 'core/config/environment.dart';
import 'core/di/injection_container.dart';
import 'core/utils/constants.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await dotenv.load(fileName: '.env');

  final config = AppConfig(
    environment: Environment.dev,
    appName: 'Weather Events Dev',
    baseUrl: dotenv.env[AppConstants.visualCrossingBaseUrl] ??
        'https://weather.visualcrossing.com',
    enableLogs: true,
    flavorName: 'dev',
  );

  await initDependencies(config);

  runApp(const WeatherEventsApp());
}