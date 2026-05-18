import 'environment.dart';

class AppConfig {
  final Environment environment;
  final String appName;
  final String baseUrl;
  final bool enableLogs;
  final String flavorName;

  const AppConfig({
    required this.environment,
    required this.appName,
    required this.baseUrl,
    required this.enableLogs,
    required this.flavorName,
  });

  bool get isDev => environment == Environment.dev;

  bool get isProd => environment == Environment.prod;
}