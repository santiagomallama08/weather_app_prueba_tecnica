import 'package:equatable/equatable.dart';

class WeatherEvent extends Equatable {
  final String id;
  final String title;
  final String type;
  final String description;
  final DateTime date;
  final String locationName;
  final double latitude;
  final double longitude;
  final bool isFavorite;

  const WeatherEvent({
    required this.id,
    required this.title,
    required this.type,
    required this.description,
    required this.date,
    required this.locationName,
    required this.latitude,
    required this.longitude,
    this.isFavorite = false,
  });

  WeatherEvent copyWith({
    String? id,
    String? title,
    String? type,
    String? description,
    DateTime? date,
    String? locationName,
    double? latitude,
    double? longitude,
    bool? isFavorite,
  }) {
    return WeatherEvent(
      id: id ?? this.id,
      title: title ?? this.title,
      type: type ?? this.type,
      description: description ?? this.description,
      date: date ?? this.date,
      locationName: locationName ?? this.locationName,
      latitude: latitude ?? this.latitude,
      longitude: longitude ?? this.longitude,
      isFavorite: isFavorite ?? this.isFavorite,
    );
  }

  @override
  List<Object?> get props => [
        id,
        title,
        type,
        description,
        date,
        locationName,
        latitude,
        longitude,
        isFavorite,
      ];
}