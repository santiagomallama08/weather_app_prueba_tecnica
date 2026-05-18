import '../entities/current_weather.dart';
import '../entities/weather_day.dart';

abstract class ForecastRepository {
  Future<CurrentWeather> getCurrentWeather(String location);

  Future<List<WeatherDay>> getLastFiveDays(String location);
}