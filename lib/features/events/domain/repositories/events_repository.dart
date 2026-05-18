import '../entities/favorite_event.dart';
import '../entities/weather_event.dart';

abstract class EventsRepository {
  Future<List<WeatherEvent>> getEventsByLocation(String location);

  Future<List<WeatherEvent>> getCachedEvents();

  Future<List<FavoriteEvent>> getFavoriteEvents();

  Future<bool> isFavorite(String eventId);

  Future<void> toggleFavorite(WeatherEvent event);
}