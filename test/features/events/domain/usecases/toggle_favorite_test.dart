import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:weather_events_app/features/events/domain/entities/favorite_event.dart';
import 'package:weather_events_app/features/events/domain/entities/weather_event.dart';
import 'package:weather_events_app/features/events/domain/repositories/events_repository.dart';
import 'package:weather_events_app/features/events/domain/usecases/toggle_favorite.dart';

class MockEventsRepository extends Mock implements EventsRepository {}

void main() {
  late MockEventsRepository repository;
  late ToggleFavorite usecase;

  setUpAll(() {
    registerFallbackValue(
      WeatherEvent(
        id: 'fallback',
        title: 'Evento',
        type: 'wind',
        description: 'Descripción',
        date: DateTime(2026, 5, 17),
        locationName: 'Bogotá, Colombia',
        latitude: 4.7110,
        longitude: -74.0721,
      ),
    );
  });

  setUp(() {
    repository = MockEventsRepository();
    usecase = ToggleFavorite(repository);
  });

  final event = WeatherEvent(
    id: '1',
    title: 'Viento fuerte',
    type: 'wind',
    description: 'Evento de viento fuerte reportado.',
    date: DateTime(2026, 5, 17),
    locationName: 'Bogotá, Colombia',
    latitude: 4.7110,
    longitude: -74.0721,
  );

  test('debe agregar o eliminar un evento favorito', () async {
    when(
      () => repository.toggleFavorite(any()),
    ).thenAnswer((_) async {});

    await usecase(event);

    verify(
      () => repository.toggleFavorite(event),
    ).called(1);
  });
}