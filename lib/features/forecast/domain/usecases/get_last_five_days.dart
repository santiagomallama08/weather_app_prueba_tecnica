import '../entities/current_weather.dart';
import '../entities/weather_day.dart';
import '../repositories/forecast_repository.dart';

class GetLastFiveDays {
  final ForecastRepository repository;

  const GetLastFiveDays(this.repository);

  Future<ForecastResult> call(String location) async {
    final cleanLocation = location.trim();

    if (cleanLocation.isEmpty) {
      throw Exception('La ubicación no puede estar vacía');
    }

    final current = await repository.getCurrentWeather(cleanLocation);
    final days = await repository.getLastFiveDays(cleanLocation);

    return ForecastResult(
      current: current,
      days: days,
    );
  }
}

class ForecastResult {
  final CurrentWeather current;
  final List<WeatherDay> days;

  const ForecastResult({
    required this.current,
    required this.days,
  });
}