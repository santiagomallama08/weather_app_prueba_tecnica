import 'package:equatable/equatable.dart';

class CurrentWeather extends Equatable {
  final String locationName;
  final double temperature;
  final double humidity;
  final double windSpeed;
  final String conditions;
  final String description;
  final double latitude;
  final double longitude;

  const CurrentWeather({
    required this.locationName,
    required this.temperature,
    required this.humidity,
    required this.windSpeed,
    required this.conditions,
    required this.description,
    required this.latitude,
    required this.longitude,
  });

  @override
  List<Object?> get props => [
        locationName,
        temperature,
        humidity,
        windSpeed,
        conditions,
        description,
        latitude,
        longitude,
      ];
}