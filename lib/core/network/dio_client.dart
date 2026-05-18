import 'package:dio/dio.dart';

import '../config/app_config.dart';
import '../utils/constants.dart';
import 'interceptors/app_interceptor.dart';

class DioClient {
  final AppConfig config;

  DioClient({
    required this.config,
  });

  Dio build() {
    final dio = Dio(
      BaseOptions(
        baseUrl: config.baseUrl,
        connectTimeout: const Duration(
          seconds: AppConstants.connectTimeoutSeconds,
        ),
        receiveTimeout: const Duration(
          seconds: AppConstants.receiveTimeoutSeconds,
        ),
        sendTimeout: const Duration(
          seconds: AppConstants.sendTimeoutSeconds,
        ),
        headers: const {
          'Accept': 'application/json',
        },
      ),
    );

    dio.interceptors.add(
      AppInterceptor(enableLogs: config.enableLogs),
    );

    return dio;
  }
}