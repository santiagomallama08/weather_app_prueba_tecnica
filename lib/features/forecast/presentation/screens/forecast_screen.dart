import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../../router/routes.dart';
import '../notifiers/forecast_notifier.dart';
import '../widgets/current_weather_card.dart';
import '../widgets/weather_day_card.dart';

class ForecastScreen extends ConsumerStatefulWidget {
  final String location;

  const ForecastScreen({
    super.key,
    required this.location,
  });

  @override
  ConsumerState<ForecastScreen> createState() => _ForecastScreenState();
}

class _ForecastScreenState extends ConsumerState<ForecastScreen> {
  @override
  void initState() {
    super.initState();

    Future.microtask(() {
      ref.read(forecastNotifierProvider.notifier).loadForecast(widget.location);
    });
  }

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(forecastNotifierProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Últimos 5 días'),
      ),
      body: RefreshIndicator(
        onRefresh: () {
          return ref
              .read(forecastNotifierProvider.notifier)
              .loadForecast(widget.location);
        },
        child: _buildContent(context, state),
      ),
    );
  }

  Widget _buildContent(BuildContext context, ForecastState state) {
    if (state.isLoading) {
      return const Center(
        child: CircularProgressIndicator(),
      );
    }

    if (state.errorMessage != null) {
      return ListView(
        padding: const EdgeInsets.all(24),
        children: [
          const SizedBox(height: 100),
          Icon(
            Icons.error_outline,
            size: 52,
            color: Theme.of(context).colorScheme.error,
          ),
          const SizedBox(height: 16),
          Text(
            state.errorMessage!,
            textAlign: TextAlign.center,
            style: Theme.of(context).textTheme.titleMedium,
          ),
          const SizedBox(height: 16),
          FilledButton(
            onPressed: () {
              ref
                  .read(forecastNotifierProvider.notifier)
                  .loadForecast(widget.location);
            },
            child: const Text('Reintentar'),
          ),
        ],
      );
    }

    if (state.currentWeather == null) {
      return ListView(
        padding: const EdgeInsets.all(24),
        children: const [
          SizedBox(height: 100),
          Icon(
            Icons.cloud_off,
            size: 52,
          ),
          SizedBox(height: 16),
          Text(
            'No hay información de pronóstico.',
            textAlign: TextAlign.center,
          ),
        ],
      );
    }

    final weather = state.currentWeather!;

    return ListView(
      padding: const EdgeInsets.only(bottom: 16),
      children: [
        if (state.isOffline)
          Container(
            width: double.infinity,
            margin: const EdgeInsets.fromLTRB(16, 12, 16, 4),
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: Colors.orange.shade100,
              borderRadius: BorderRadius.circular(12),
            ),
            child: const Row(
              children: [
                Icon(Icons.wifi_off_rounded),
                SizedBox(width: 10),
                Expanded(
                  child: Text(
                    'Sin conexión. Mostrando la última información guardada.',
                  ),
                ),
              ],
            ),
          ),
        CurrentWeatherCard(weather: weather),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: OutlinedButton.icon(
            onPressed: () {
              context.push(
                Routes.map,
                extra: {
                  'title': 'Clima actual',
                  'locationName': weather.locationName,
                  'latitude': weather.latitude,
                  'longitude': weather.longitude,
                },
              );
            },
            icon: const Icon(Icons.map),
            label: const Text('Ver ubicación en mapa'),
          ),
        ),
        Padding(
          padding: const EdgeInsets.fromLTRB(16, 20, 16, 8),
          child: Text(
            'Pronóstico diario',
            style: Theme.of(context).textTheme.titleLarge?.copyWith(
                  fontWeight: FontWeight.bold,
                ),
          ),
        ),
        ...state.days.map(
          (day) => WeatherDayCard(day: day),
        ),
      ],
    );
  }
}