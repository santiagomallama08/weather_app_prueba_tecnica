import 'package:equatable/equatable.dart';

class WeatherDay extends Equatable {
  final DateTime date;
  final double temperature;
  final double maxTemperature;
  final double minTemperature;
  final double humidity;
  final double windSpeed;
  final double precipitation;
  final String conditions;
  final String description;

  const WeatherDay({
    required this.date,
    required this.temperature,
    required this.maxTemperature,
    required this.minTemperature,
    required this.humidity,
    required this.windSpeed,
    required this.precipitation,
    required this.conditions,
    required this.description,
  });

  @override
  List<Object?> get props => [
        date,
        temperature,
        maxTemperature,
        minTemperature,
        humidity,
        windSpeed,
        precipitation,
        conditions,
        description,
      ];
}