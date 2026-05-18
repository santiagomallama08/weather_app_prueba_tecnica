import '../../domain/entities/current_weather.dart';

class CurrentWeatherModel extends CurrentWeather {
  const CurrentWeatherModel({
    required super.locationName,
    required super.temperature,
    required super.humidity,
    required super.windSpeed,
    required super.conditions,
    required super.description,
    required super.latitude,
    required super.longitude,
  });

  factory CurrentWeatherModel.fromApiResponse(Map<String, dynamic> json) {
    final current = json['currentConditions'] as Map<String, dynamic>? ?? {};

    return CurrentWeatherModel(
      locationName: json['resolvedAddress']?.toString() ?? 'Ubicación',
      temperature: (current['temp'] as num?)?.toDouble() ?? 0,
      humidity: (current['humidity'] as num?)?.toDouble() ?? 0,
      windSpeed: (current['windspeed'] as num?)?.toDouble() ?? 0,
      conditions: current['conditions']?.toString() ?? 'Sin información',
      description: current['description']?.toString() ?? '',
      latitude: (json['latitude'] as num?)?.toDouble() ?? 0,
      longitude: (json['longitude'] as num?)?.toDouble() ?? 0,
    );
  }
}