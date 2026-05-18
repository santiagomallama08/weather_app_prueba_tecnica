import 'package:dio/dio.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:intl/intl.dart';

import '../../../../core/error/exceptions.dart';
import '../../../../core/utils/constants.dart';
import '../models/weather_event_model.dart';

class EventsApi {
  final Dio dio;

  EventsApi(this.dio);

  Future<List<WeatherEventModel>> getEvents(String location) async {
    final apiKey = dotenv.env[AppConstants.visualCrossingApiKey];

    if (apiKey == null || apiKey.isEmpty) {
      throw const ServerException('La API Key no está configurada.');
    }

    final endDate = DateTime.now();
    final startDate = endDate.subtract(const Duration(days: 30));

    final path =
        '${AppConstants.timelinePath}/${Uri.encodeComponent(location)}/${_formatDate(startDate)}/${_formatDate(endDate)}';

    final response = await dio.get(
      path,
      queryParameters: {
        'key': apiKey,
        'unitGroup': AppConstants.unitGroup,
        'lang': AppConstants.language,
        'contentType': AppConstants.contentType,
        'include': 'events',
      },
    );

    if (response.statusCode != 200) {
      throw const ServerException();
    }

    if (response.data is! Map<String, dynamic>) {
      throw const ServerException('La respuesta del servidor no es válida.');
    }

    return WeatherEventModel.fromApiResponse(response.data);
  }

  String _formatDate(DateTime date) {
    return DateFormat('yyyy-MM-dd').format(date);
  }
}