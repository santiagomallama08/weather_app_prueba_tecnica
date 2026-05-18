import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:weather_events_app/features/events/domain/entities/favorite_event.dart';
import 'package:weather_events_app/features/events/domain/entities/weather_event.dart';
import 'package:weather_events_app/features/events/domain/repositories/events_repository.dart';
import 'package:weather_events_app/features/events/domain/usecases/get_events.dart';

class MockEventsRepository extends Mock implements EventsRepository {}

void main() {
  late MockEventsRepository repository;
  late GetEvents usecase;

  setUp(() {
    repository = MockEventsRepository();
    usecase = GetEvents(repository);
  });

  final events = [
    WeatherEvent(
      id: '1',
      title: 'Viento fuerte',
      type: 'wind',
      description: 'Evento de viento fuerte reportado.',
      date: DateTime(2026, 5, 17),
      locationName: 'Bogotá, Colombia',
      latitude: 4.7110,
      longitude: -74.0721,
    ),
  ];

  test('debe obtener eventos por ubicación', () async {
    when(
      () => repository.getEventsByLocation('Bogotá, Colombia'),
    ).thenAnswer((_) async => events);

    final result = await usecase('Bogotá, Colombia');

    expect(result, events);
    verify(
      () => repository.getEventsByLocation('Bogotá, Colombia'),
    ).called(1);
  });

  test('debe limpiar espacios antes de consultar', () async {
    when(
      () => repository.getEventsByLocation('Bogotá, Colombia'),
    ).thenAnswer((_) async => events);

    final result = await usecase('  Bogotá, Colombia  ');

    expect(result, events);
    verify(
      () => repository.getEventsByLocation('Bogotá, Colombia'),
    ).called(1);
  });

  test('debe lanzar excepción si la ubicación está vacía', () {
    expect(
      () => usecase('   '),
      throwsException,
    );
  });
}