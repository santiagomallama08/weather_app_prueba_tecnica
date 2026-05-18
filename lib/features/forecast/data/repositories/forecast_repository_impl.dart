import '../../../../core/network/network_info.dart';
import '../../domain/entities/current_weather.dart';
import '../../domain/entities/weather_day.dart';
import '../../domain/repositories/forecast_repository.dart';
import '../datasources/forecast_api.dart';
import '../datasources/forecast_local_storage.dart';

class ForecastRepositoryImpl implements ForecastRepository {
  final ForecastApi api;
  final ForecastLocalStorage localStorage;
  final NetworkInfo networkInfo;

  ForecastRepositoryImpl({
    required this.api,
    required this.localStorage,
    required this.networkInfo,
  });

  @override
  Future<CurrentWeather> getCurrentWeather(String location) async {
    final hasInternet = await networkInfo.isConnected;

    if (hasInternet) {
      final current = await api.getCurrentWeather(location);
      await localStorage.saveCurrentWeather(current);
      return current;
    }

    final cached = await localStorage.getCurrentWeather();

    if (cached == null) {
      throw Exception('No hay conexión ni información guardada.');
    }

    return cached;
  }

  @override
  Future<List<WeatherDay>> getLastFiveDays(String location) async {
    final hasInternet = await networkInfo.isConnected;

    if (hasInternet) {
      final days = await api.getLastFiveDays(location);
      await localStorage.saveDays(days);
      return days;
    }

    final cachedDays = await localStorage.getDays();

    if (cachedDays.isEmpty) {
      throw Exception('No hay conexión ni pronóstico guardado.');
    }

    return cachedDays;
  }
}