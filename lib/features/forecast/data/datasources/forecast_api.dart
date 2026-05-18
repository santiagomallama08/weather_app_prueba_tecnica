import 'package:dio/dio.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:intl/intl.dart';

import '../../../../core/error/exceptions.dart';
import '../../../../core/utils/constants.dart';
import '../models/current_weather_model.dart';
import '../models/weather_day_model.dart';

class ForecastApi {
  final Dio dio;

  ForecastApi(this.dio);

  Future<Map<String, dynamic>> _getForecastResponse(String location) async {
    final apiKey = dotenv.env[AppConstants.visualCrossingApiKey];

    if (apiKey == null || apiKey.isEmpty) {
      throw const ServerException('La API Key no está configurada.');
    }

    final endDate = DateTime.now();
    final startDate = endDate.subtract(const Duration(days: 4));

    final path =
        '${AppConstants.timelinePath}/${Uri.encodeComponent(location)}/${_formatDate(startDate)}/${_formatDate(endDate)}';

    final response = await dio.get(
      path,
      queryParameters: {
        'key': apiKey,
        'unitGroup': AppConstants.unitGroup,
        'lang': AppConstants.language,
        'contentType': AppConstants.contentType,
        'include': 'days,current',
      },
    );

    if (response.statusCode != 200) {
      throw const ServerException();
    }

    if (response.data is! Map<String, dynamic>) {
      throw const ServerException('La respuesta del servidor no es válida.');
    }

    return response.data;
  }

  Future<CurrentWeatherModel> getCurrentWeather(String location) async {
    final json = await _getForecastResponse(location);

    return CurrentWeatherModel.fromApiResponse(json);
  }

  Future<List<WeatherDayModel>> getLastFiveDays(String location) async {
    final json = await _getForecastResponse(location);

    return WeatherDayModel.fromApiResponse(json);
  }

  String _formatDate(DateTime date) {
    return DateFormat('yyyy-MM-dd').format(date);
  }
}