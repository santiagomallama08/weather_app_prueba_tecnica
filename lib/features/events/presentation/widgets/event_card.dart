import 'package:flutter/material.dart';

import '../../domain/entities/weather_event.dart';

class EventCard extends StatelessWidget {
  final WeatherEvent event;
  final VoidCallback onTap;
  final VoidCallback onFavoritePressed;

  const EventCard({
    super.key,
    required this.event,
    required this.onTap,
    required this.onFavoritePressed,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      child: InkWell(
        borderRadius: BorderRadius.circular(18),
        onTap: onTap,
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const CircleAvatar(
                child: Icon(Icons.warning_amber_rounded),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: _EventInfo(event: event),
              ),
              IconButton(
                onPressed: onFavoritePressed,
                icon: Icon(
                  event.isFavorite ? Icons.favorite : Icons.favorite_border,
                  color: event.isFavorite ? Colors.red : null,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _EventInfo extends StatelessWidget {
  final WeatherEvent event;

  const _EventInfo({
    required this.event,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          event.title,
          style: Theme.of(context).textTheme.titleMedium?.copyWith(
                fontWeight: FontWeight.bold,
              ),
        ),
        const SizedBox(height: 4),
        Text(
          event.locationName,
          style: Theme.of(context).textTheme.bodySmall,
        ),
        const SizedBox(height: 8),
        Text(
          event.description,
          maxLines: 2,
          overflow: TextOverflow.ellipsis,
        ),
      ],
    );
  }
}