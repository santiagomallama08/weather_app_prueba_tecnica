import '../entities/weather_event.dart';
import '../repositories/events_repository.dart';

class GetEvents {
  final EventsRepository repository;

  const GetEvents(this.repository);

  Future<List<WeatherEvent>> call(String location) {
    final cleanLocation = location.trim();

    if (cleanLocation.isEmpty) {
      throw Exception('La ubicación no puede estar vacía');
    }

    return repository.getEventsByLocation(cleanLocation);
  }
}