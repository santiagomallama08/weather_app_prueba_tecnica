import 'package:dio/dio.dart';

import 'location_suggestion.dart';

class SearchLocations {
  final Dio dio;

  SearchLocations(this.dio);

  Future<List<LocationSuggestion>> call(String query) async {
    final cleanQuery = query.trim();

    if (cleanQuery.length < 3) {
      return [];
    }

    final response = await dio.get(
      'https://nominatim.openstreetmap.org/search',
      queryParameters: {
        'q': cleanQuery,
        'format': 'jsonv2',
        'limit': 5,
        'addressdetails': 1,
      },
      options: Options(
        headers: {
          'User-Agent': 'weather_events_app_flutter_test',
        },
      ),
    );

    final data = response.data;

    if (data is! List) {
      return [];
    }

    return data
        .whereType<Map<String, dynamic>>()
        .map((item) {
          final lat = double.tryParse(item['lat']?.toString() ?? '');
          final lon = double.tryParse(item['lon']?.toString() ?? '');

          if (lat == null || lon == null) {
            return null;
          }

          return LocationSuggestion(
            displayName: item['display_name']?.toString() ?? cleanQuery,
            latitude: lat,
            longitude: lon,
          );
        })
        .whereType<LocationSuggestion>()
        .toList();
  }
}