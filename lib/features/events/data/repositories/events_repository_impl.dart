import '../../../../core/network/network_info.dart';
import '../../domain/entities/favorite_event.dart';
import '../../domain/entities/weather_event.dart';
import '../../domain/repositories/events_repository.dart';
import '../datasources/events_api.dart';
import '../datasources/events_local_storage.dart';

class EventsRepositoryImpl implements EventsRepository {
  final EventsApi api;
  final EventsLocalStorage localStorage;
  final NetworkInfo networkInfo;

  EventsRepositoryImpl({
    required this.api,
    required this.localStorage,
    required this.networkInfo,
  });

  @override
  Future<List<WeatherEvent>> getEventsByLocation(String location) async {
    final hasInternet = await networkInfo.isConnected;

    if (!hasInternet) {
      final cachedEvents = await localStorage.getCachedEvents();

      if (cachedEvents.isEmpty) {
        throw Exception('No hay conexión ni eventos guardados.');
      }

      return cachedEvents;
    }

    final events = await api.getEvents(location);
    final updatedEvents = <WeatherEvent>[];

    for (final event in events) {
      final favorite = await localStorage.isFavorite(event.id);

      updatedEvents.add(
        event.copyWith(isFavorite: favorite),
      );
    }

    await localStorage.saveEvents(updatedEvents);

    return updatedEvents;
  }

  @override
  Future<List<WeatherEvent>> getCachedEvents() {
    return localStorage.getCachedEvents();
  }

  @override
  Future<List<FavoriteEvent>> getFavoriteEvents() {
    return localStorage.getFavoriteEvents();
  }

  @override
  Future<bool> isFavorite(String eventId) {
    return localStorage.isFavorite(eventId);
  }

  @override
  Future<void> toggleFavorite(WeatherEvent event) {
    return localStorage.toggleFavorite(event);
  }
}