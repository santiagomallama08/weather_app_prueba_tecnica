// ignore_for_file: avoid_print
import 'package:dio/dio.dart';

class AppInterceptor extends Interceptor {
  final bool enableLogs;

  AppInterceptor({
    required this.enableLogs,
  });

  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    if (enableLogs) {
      print('REQUEST: ${options.method} ${options.uri}');
    }

    handler.next(options);
  }

  @override
  void onResponse(Response response, ResponseInterceptorHandler handler) {
    if (enableLogs) {
      print('RESPONSE: ${response.statusCode} ${response.requestOptions.uri}');
    }

    handler.next(response);
  }

  @override
  void onError(DioException err, ErrorInterceptorHandler handler) {
    if (enableLogs) {
      print('ERROR: ${err.response?.statusCode} ${err.requestOptions.uri}');
      print('MESSAGE: ${err.message}');
    }

    handler.next(err);
  }
}