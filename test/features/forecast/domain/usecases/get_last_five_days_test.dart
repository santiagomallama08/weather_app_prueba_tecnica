import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:weather_events_app/features/forecast/domain/entities/current_weather.dart';
import 'package:weather_events_app/features/forecast/domain/entities/weather_day.dart';
import 'package:weather_events_app/features/forecast/domain/repositories/forecast_repository.dart';
import 'package:weather_events_app/features/forecast/domain/usecases/get_last_five_days.dart';

class MockForecastRepository extends Mock implements ForecastRepository {}

void main() {
  late MockForecastRepository repository;
  late GetLastFiveDays usecase;

  setUp(() {
    repository = MockForecastRepository();
    usecase = GetLastFiveDays(repository);
  });

  const currentWeather = CurrentWeather(
    locationName: 'Bogotá, Colombia',
    temperature: 18.5,
    humidity: 70,
    windSpeed: 10,
    conditions: 'Parcialmente nublado',
    description: 'Clima actual en Bogotá.',
    latitude: 4.7110,
    longitude: -74.0721,
  );

  final days = [
    WeatherDay(
      date: DateTime(2026, 5, 13),
      temperature: 18,
      maxTemperature: 22,
      minTemperature: 12,
      humidity: 72,
      windSpeed: 9,
      precipitation: 1.2,
      conditions: 'Nublado',
      description: 'Día nublado.',
    ),
    WeatherDay(
      date: DateTime(2026, 5, 14),
      temperature: 19,
      maxTemperature: 23,
      minTemperature: 13,
      humidity: 68,
      windSpeed: 8,
      precipitation: 0.5,
      conditions: 'Lluvia ligera',
      description: 'Posible lluvia ligera.',
    ),
  ];

  test('debe obtener clima actual y últimos días', () async {
    when(
      () => repository.getCurrentWeather('Bogotá, Colombia'),
    ).thenAnswer((_) async => currentWeather);

    when(
      () => repository.getLastFiveDays('Bogotá, Colombia'),
    ).thenAnswer((_) async => days);

    final result = await usecase('Bogotá, Colombia');

    expect(result.current, currentWeather);
    expect(result.days, days);

    verify(
      () => repository.getCurrentWeather('Bogotá, Colombia'),
    ).called(1);

    verify(
      () => repository.getLastFiveDays('Bogotá, Colombia'),
    ).called(1);
  });

  test('debe limpiar espacios antes de consultar', () async {
    when(
      () => repository.getCurrentWeather('Bogotá, Colombia'),
    ).thenAnswer((_) async => currentWeather);

    when(
      () => repository.getLastFiveDays('Bogotá, Colombia'),
    ).thenAnswer((_) async => days);

    final result = await usecase('  Bogotá, Colombia  ');

    expect(result.current, currentWeather);
    expect(result.days.length, 2);

    verify(
      () => repository.getCurrentWeather('Bogotá, Colombia'),
    ).called(1);

    verify(
      () => repository.getLastFiveDays('Bogotá, Colombia'),
    ).called(1);
  });

  test('debe lanzar excepción si la ubicación está vacía', () {
    expect(
      () => usecase('   '),
      throwsException,
    );
  });
}