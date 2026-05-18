import 'package:equatable/equatable.dart';

class FavoriteEvent extends Equatable {
  final String id;
  final String title;
  final String type;
  final String description;
  final DateTime date;
  final String locationName;
  final double latitude;
  final double longitude;
  final DateTime savedAt;

  const FavoriteEvent({
    required this.id,
    required this.title,
    required this.type,
    required this.description,
    required this.date,
    required this.locationName,
    required this.latitude,
    required this.longitude,
    required this.savedAt,
  });

  WeatherEventData toEvent() {
    return WeatherEventData(
      id: id,
      title: title,
      type: type,
      description: description,
      date: date,
      locationName: locationName,
      latitude: latitude,
      longitude: longitude,
      isFavorite: true,
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
        savedAt,
      ];
}

class WeatherEventData {
  final String id;
  final String title;
  final String type;
  final String description;
  final DateTime date;
  final String locationName;
  final double latitude;
  final double longitude;
  final bool isFavorite;

  const WeatherEventData({
    required this.id,
    required this.title,
    required this.type,
    required this.description,
    required this.date,
    required this.locationName,
    required this.latitude,
    required this.longitude,
    required this.isFavorite,
  });
}