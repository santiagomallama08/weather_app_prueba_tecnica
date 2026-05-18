import 'package:flutter/material.dart';

import '../../domain/entities/current_weather.dart';

class CurrentWeatherCard extends StatelessWidget {
  final CurrentWeather weather;

  const CurrentWeatherCard({
    super.key,
    required this.weather,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(18),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              weather.locationName,
              style: Theme.of(context).textTheme.titleLarge?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
            ),
            const SizedBox(height: 12),
            Row(
              children: [
                const Icon(Icons.thermostat, size: 42),
                const SizedBox(width: 12),
                Text(
                  '${weather.temperature.toStringAsFixed(1)} °C',
                  style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                ),
              ],
            ),
            const SizedBox(height: 12),
            Text(weather.conditions),
            const SizedBox(height: 12),
            _InfoRow(
              icon: Icons.water_drop,
              label: 'Humedad',
              value: '${weather.humidity.toStringAsFixed(0)}%',
            ),
            _InfoRow(
              icon: Icons.air,
              label: 'Viento',
              value: '${weather.windSpeed.toStringAsFixed(1)} km/h',
            ),
            _InfoRow(
              icon: Icons.location_on,
              label: 'Coordenadas',
              value:
                  '${weather.latitude.toStringAsFixed(4)}, ${weather.longitude.toStringAsFixed(4)}',
            ),
          ],
        ),
      ),
    );
  }
}

class _InfoRow extends StatelessWidget {
  final IconData icon;
  final String label;
  final String value;

  const _InfoRow({
    required this.icon,
    required this.label,
    required this.value,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 8),
      child: Row(
        children: [
          Icon(icon, size: 20),
          const SizedBox(width: 8),
          Text('$label: '),
          Expanded(
            child: Text(
              value,
              style: const TextStyle(fontWeight: FontWeight.w600),
            ),
          ),
        ],
      ),
    );
  }
}