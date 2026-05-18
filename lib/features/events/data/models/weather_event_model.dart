import '../../domain/entities/weather_event.dart';

class WeatherEventModel extends WeatherEvent {
  const WeatherEventModel({
    required super.id,
    required super.title,
    required super.type,
    required super.description,
    required super.date,
    required super.locationName,
    required super.latitude,
    required super.longitude,
    super.isFavorite,
  });

  factory WeatherEventModel.fromJson(
    Map<String, dynamic> json, {
    required String locationName,
    required double latitude,
    required double longitude,
    required DateTime fallbackDate,
  }) {
    final type = json['eventtype']?.toString() ??
        json['type']?.toString() ??
        'Evento climático';

    final description = json['description']?.toString() ??
        json['details']?.toString() ??
        'Evento climático reportado para la ubicación consultada.';

    final dateText = json['datetime']?.toString() ??
        json['starttime']?.toString() ??
        fallbackDate.toIso8601String();

    final parsedDate = DateTime.tryParse(dateText) ?? fallbackDate;

    return WeatherEventModel(
      id: '$type-${parsedDate.toIso8601String()}-$locationName',
      title: _translateEventType(type),
      type: type,
      description: description,
      date: parsedDate,
      locationName: locationName,
      latitude: latitude,
      longitude: longitude,
      isFavorite: false,
    );
  }

  static List<WeatherEventModel> fromApiResponse(Map<String, dynamic> json) {
    final locationName =
        json['resolvedAddress']?.toString() ?? 'Ubicación consultada';

    final latitude = (json['latitude'] as num?)?.toDouble() ?? 0;
    final longitude = (json['longitude'] as num?)?.toDouble() ?? 0;

    final events = <WeatherEventModel>[];

    final topLevelEvents = json['events'] as List<dynamic>? ?? [];

    for (final item in topLevelEvents) {
      if (item is Map<String, dynamic>) {
        events.add(
          WeatherEventModel.fromJson(
            item,
            locationName: locationName,
            latitude: latitude,
            longitude: longitude,
            fallbackDate: DateTime.now(),
          ),
        );
      }
    }

    final days = json['days'] as List<dynamic>? ?? [];

    for (final day in days) {
      if (day is! Map<String, dynamic>) continue;

      final dayDate = DateTime.tryParse(day['datetime']?.toString() ?? '') ??
          DateTime.now();

      final dayEvents = day['events'] as List<dynamic>? ?? [];

      for (final item in dayEvents) {
        if (item is Map<String, dynamic>) {
          events.add(
            WeatherEventModel.fromJson(
              item,
              locationName: locationName,
              latitude: latitude,
              longitude: longitude,
              fallbackDate: dayDate,
            ),
          );
        }
      }
    }

    return events;
  }

  static String _translateEventType(String value) {
    final text = value.toLowerCase();

    if (text.contains('hail')) return 'Granizo';
    if (text.contains('tornado')) return 'Tornado';
    if (text.contains('wind')) return 'Viento fuerte';
    if (text.contains('earthquake')) return 'Terremoto';
    if (text.contains('rain')) return 'Lluvia';
    if (text.contains('storm')) return 'Tormenta';

    return 'Evento meteorológico';
  }
}