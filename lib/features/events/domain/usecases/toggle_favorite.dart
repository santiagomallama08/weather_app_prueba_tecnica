import '../entities/weather_event.dart';
import '../repositories/events_repository.dart';

class ToggleFavorite {
  final EventsRepository repository;

  const ToggleFavorite(this.repository);

  Future<void> call(WeatherEvent event) {
    return repository.toggleFavorite(event);
  }
}