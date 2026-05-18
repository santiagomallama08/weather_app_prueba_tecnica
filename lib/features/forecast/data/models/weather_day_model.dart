import '../../domain/entities/weather_day.dart';

class WeatherDayModel extends WeatherDay {
  const WeatherDayModel({
    required super.date,
    required super.temperature,
    required super.maxTemperature,
    required super.minTemperature,
    required super.humidity,
    required super.windSpeed,
    required super.precipitation,
    required super.conditions,
    required super.description,
  });

  factory WeatherDayModel.fromJson(Map<String, dynamic> json) {
    final dateText = json['datetime']?.toString() ?? '';
    final parsedDate = DateTime.tryParse(dateText) ?? DateTime.now();

    return WeatherDayModel(
      date: parsedDate,
      temperature: (json['temp'] as num?)?.toDouble() ?? 0,
      maxTemperature: (json['tempmax'] as num?)?.toDouble() ?? 0,
      minTemperature: (json['tempmin'] as num?)?.toDouble() ?? 0,
      humidity: (json['humidity'] as num?)?.toDouble() ?? 0,
      windSpeed: (json['windspeed'] as num?)?.toDouble() ?? 0,
      precipitation: (json['precip'] as num?)?.toDouble() ?? 0,
      conditions: json['conditions']?.toString() ?? 'Sin información',
      description: json['description']?.toString() ?? '',
    );
  }

  static List<WeatherDayModel> fromApiResponse(Map<String, dynamic> json) {
    final days = json['days'] as List<dynamic>? ?? [];

    return days
        .whereType<Map<String, dynamic>>()
        .map(WeatherDayModel.fromJson)
        .toList();
  }
}