import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../../router/routes.dart';
import '../../domain/entities/weather_event.dart';
import '../notifiers/favorites_notifier.dart';

class EventDetailScreen extends ConsumerStatefulWidget {
  final WeatherEvent event;

  const EventDetailScreen({
    super.key,
    required this.event,
  });

  @override
  ConsumerState<EventDetailScreen> createState() => _EventDetailScreenState();
}

class _EventDetailScreenState extends ConsumerState<EventDetailScreen> {
  @override
  void initState() {
    super.initState();

    Future.microtask(() {
      ref.read(favoritesNotifierProvider.notifier).loadFavorites();
    });
  }

  @override
  Widget build(BuildContext context) {
    final favoritesState = ref.watch(favoritesNotifierProvider);

    ref.listen<FavoritesState>(favoritesNotifierProvider, (previous, next) {
      if (next.successMessage != null) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(next.successMessage!),
          ),
        );

        ref.read(favoritesNotifierProvider.notifier).clearMessages();
      }

      if (next.errorMessage != null) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(next.errorMessage!),
          ),
        );

        ref.read(favoritesNotifierProvider.notifier).clearMessages();
      }
    });

    final hasLoadedFavorites = !favoritesState.isLoading;

    final isFavorite = favoritesState.favorites.any(
          (favorite) => favorite.id == widget.event.id,
        ) ||
        (!hasLoadedFavorites && widget.event.isFavorite);

    final currentEvent = widget.event.copyWith(
      isFavorite: isFavorite,
    );

    return Scaffold(
      appBar: AppBar(
        title: const Text('Detalle del evento'),
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          Card(
            child: Padding(
              padding: const EdgeInsets.all(18),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    currentEvent.title,
                    style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                          fontWeight: FontWeight.bold,
                        ),
                  ),
                  const SizedBox(height: 16),
                  _DetailRow(
                    label: 'Tipo',
                    value: currentEvent.type,
                  ),
                  _DetailRow(
                    label: 'Ubicación',
                    value: currentEvent.locationName,
                  ),
                  _DetailRow(
                    label: 'Fecha',
                    value: _formatDate(currentEvent.date),
                  ),
                  _DetailRow(
                    label: 'Coordenadas',
                    value:
                        '${currentEvent.latitude.toStringAsFixed(4)}, ${currentEvent.longitude.toStringAsFixed(4)}',
                  ),
                  const SizedBox(height: 18),
                  Text(
                    'Descripción',
                    style: Theme.of(context).textTheme.titleMedium?.copyWith(
                          fontWeight: FontWeight.bold,
                        ),
                  ),
                  const SizedBox(height: 8),
                  Text(currentEvent.description),
                  const SizedBox(height: 24),
                  FilledButton.icon(
                    onPressed: () async {
                      await ref
                          .read(favoritesNotifierProvider.notifier)
                          .toggle(currentEvent);
                    },
                    icon: Icon(
                      isFavorite ? Icons.favorite : Icons.favorite_border,
                    ),
                    label: Text(
                      isFavorite
                          ? 'Eliminar de favoritos'
                          : 'Agregar a favoritos',
                    ),
                  ),
                  const SizedBox(height: 12),
                  OutlinedButton.icon(
                    onPressed: () {
                      context.push(
                        Routes.map,
                        extra: {
                          'title': currentEvent.title,
                          'locationName': currentEvent.locationName,
                          'latitude': currentEvent.latitude,
                          'longitude': currentEvent.longitude,
                        },
                      );
                    },
                    icon: const Icon(Icons.map),
                    label: const Text('Ver en mapa'),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  String _formatDate(DateTime date) {
    final day = date.day.toString().padLeft(2, '0');
    final month = date.month.toString().padLeft(2, '0');
    final year = date.year.toString();

    return '$day/$month/$year';
  }
}

class _DetailRow extends StatelessWidget {
  final String label;
  final String value;

  const _DetailRow({
    required this.label,
    required this.value,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            '$label: ',
            style: const TextStyle(fontWeight: FontWeight.bold),
          ),
          Expanded(
            child: Text(value),
          ),
        ],
      ),
    );
  }
}