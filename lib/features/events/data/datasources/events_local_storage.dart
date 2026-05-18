import 'package:realm/realm.dart';

import '../../domain/entities/favorite_event.dart';
import '../../domain/entities/weather_event.dart';

part 'events_local_storage.realm.dart';

@RealmModel()
class _CachedEvent {
  @PrimaryKey()
  late String id;

  late String title;
  late String type;
  late String description;
  late DateTime date;
  late String locationName;
  late double latitude;
  late double longitude;
  late bool isFavorite;
}

@RealmModel()
class _FavoriteEventLocal {
  @PrimaryKey()
  late String id;

  late String title;
  late String type;
  late String description;
  late DateTime date;
  late String locationName;
  late double latitude;
  late double longitude;
  late DateTime savedAt;
}

class EventsLocalStorage {
  late final Realm _realm;

  EventsLocalStorage() {
    final config = Configuration.local([
      CachedEvent.schema,
      FavoriteEventLocal.schema,
    ]);

    _realm = Realm(config);
  }

  Future<void> saveEvents(List<WeatherEvent> events) async {
    _realm.write(() {
      _realm.deleteAll<CachedEvent>();

      for (final event in events) {
        _realm.add(
          CachedEvent(
            event.id,
            event.title,
            event.type,
            event.description,
            event.date,
            event.locationName,
            event.latitude,
            event.longitude,
            event.isFavorite,
          ),
        );
      }
    });
  }

  Future<List<WeatherEvent>> getCachedEvents() async {
    final cachedEvents = _realm.all<CachedEvent>();

    return cachedEvents.map((event) {
      final isFavorite = _realm.find<FavoriteEventLocal>(event.id) != null;

      return WeatherEvent(
        id: event.id,
        title: event.title,
        type: event.type,
        description: event.description,
        date: event.date,
        locationName: event.locationName,
        latitude: event.latitude,
        longitude: event.longitude,
        isFavorite: isFavorite,
      );
    }).toList();
  }

  Future<List<FavoriteEvent>> getFavoriteEvents() async {
    final favorites = _realm.all<FavoriteEventLocal>();

    return favorites.map((event) {
      return FavoriteEvent(
        id: event.id,
        title: event.title,
        type: event.type,
        description: event.description,
        date: event.date,
        locationName: event.locationName,
        latitude: event.latitude,
        longitude: event.longitude,
        savedAt: event.savedAt,
      );
    }).toList();
  }

  Future<bool> isFavorite(String eventId) async {
    return _realm.find<FavoriteEventLocal>(eventId) != null;
  }

  Future<void> toggleFavorite(WeatherEvent event) async {
    final favorite = _realm.find<FavoriteEventLocal>(event.id);

    _realm.write(() {
      if (favorite != null) {
        _realm.delete(favorite);
        return;
      }

      _realm.add(
        FavoriteEventLocal(
          event.id,
          event.title,
          event.type,
          event.description,
          event.date,
          event.locationName,
          event.latitude,
          event.longitude,
          DateTime.now(),
        ),
      );
    });
  }
}