import 'package:realm/realm.dart';

import '../../domain/entities/current_weather.dart';
import '../../domain/entities/weather_day.dart';

part 'forecast_local_storage.realm.dart';

@RealmModel()
class _CachedCurrentWeather {
  @PrimaryKey()
  late String id;

  late String locationName;
  late double temperature;
  late double humidity;
  late double windSpeed;
  late String conditions;
  late String description;
  late double latitude;
  late double longitude;
}

@RealmModel()
class _CachedWeatherDay {
  @PrimaryKey()
  late String id;

  late DateTime date;
  late double temperature;
  late double maxTemperature;
  late double minTemperature;
  late double humidity;
  late double windSpeed;
  late double precipitation;
  late String conditions;
  late String description;
}

class ForecastLocalStorage {
  late final Realm _realm;

  ForecastLocalStorage() {
    final config = Configuration.local([
      CachedCurrentWeather.schema,
      CachedWeatherDay.schema,
    ]);

    _realm = Realm(config);
  }

  Future<void> saveCurrentWeather(CurrentWeather weather) async {
    _realm.write(() {
      _realm.deleteAll<CachedCurrentWeather>();

      _realm.add(
        CachedCurrentWeather(
          'current_weather',
          weather.locationName,
          weather.temperature,
          weather.humidity,
          weather.windSpeed,
          weather.conditions,
          weather.description,
          weather.latitude,
          weather.longitude,
        ),
      );
    });
  }

  Future<CurrentWeather?> getCurrentWeather() async {
    final cached = _realm.find<CachedCurrentWeather>('current_weather');

    if (cached == null) {
      return null;
    }

    return CurrentWeather(
      locationName: cached.locationName,
      temperature: cached.temperature,
      humidity: cached.humidity,
      windSpeed: cached.windSpeed,
      conditions: cached.conditions,
      description: cached.description,
      latitude: cached.latitude,
      longitude: cached.longitude,
    );
  }

  Future<void> saveDays(List<WeatherDay> days) async {
    _realm.write(() {
      _realm.deleteAll<CachedWeatherDay>();

      for (final day in days) {
        _realm.add(
          CachedWeatherDay(
            day.date.toIso8601String(),
            day.date,
            day.temperature,
            day.maxTemperature,
            day.minTemperature,
            day.humidity,
            day.windSpeed,
            day.precipitation,
            day.conditions,
            day.description,
          ),
        );
      }
    });
  }

  Future<List<WeatherDay>> getDays() async {
    final cachedDays = _realm.all<CachedWeatherDay>();

    return cachedDays.map((day) {
      return WeatherDay(
        date: day.date,
        temperature: day.temperature,
        maxTemperature: day.maxTemperature,
        minTemperature: day.minTemperature,
        humidity: day.humidity,
        windSpeed: day.windSpeed,
        precipitation: day.precipitation,
        conditions: day.conditions,
        description: day.description,
      );
    }).toList();
  }
}