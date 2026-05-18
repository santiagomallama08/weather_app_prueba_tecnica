import 'package:flutter/material.dart';

import '../../domain/entities/weather_day.dart';

class WeatherDayCard extends StatelessWidget {
  final WeatherDay day;

  const WeatherDayCard({
    super.key,
    required this.day,
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
              _formatDate(day.date),
              style: Theme.of(context).textTheme.titleMedium?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
            ),
            const SizedBox(height: 8),
            Text(day.conditions),
            const SizedBox(height: 12),
            Wrap(
              spacing: 8,
              runSpacing: 8,
              children: [
                _InfoChip(
                  icon: Icons.thermostat,
                  text: '${day.temperature.toStringAsFixed(1)} °C',
                ),
                _InfoChip(
                  icon: Icons.arrow_upward,
                  text: 'Máx ${day.maxTemperature.toStringAsFixed(1)} °C',
                ),
                _InfoChip(
                  icon: Icons.arrow_downward,
                  text: 'Mín ${day.minTemperature.toStringAsFixed(1)} °C',
                ),
                _InfoChip(
                  icon: Icons.water_drop,
                  text: '${day.humidity.toStringAsFixed(0)}%',
                ),
                _InfoChip(
                  icon: Icons.air,
                  text: '${day.windSpeed.toStringAsFixed(1)} km/h',
                ),
                _InfoChip(
                  icon: Icons.grain,
                  text: '${day.precipitation.toStringAsFixed(1)} mm',
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  String _formatDate(DateTime date) {
    final dayText = date.day.toString().padLeft(2, '0');
    final monthText = date.month.toString().padLeft(2, '0');
    final yearText = date.year.toString();

    return '$dayText/$monthText/$yearText';
  }
}

class _InfoChip extends StatelessWidget {
  final IconData icon;
  final String text;

  const _InfoChip({
    required this.icon,
    required this.text,
  });

  @override
  Widget build(BuildContext context) {
    return Chip(
      avatar: Icon(icon, size: 18),
      label: Text(text),
    );
  }
}