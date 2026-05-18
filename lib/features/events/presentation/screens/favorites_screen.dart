import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/di/injection_container.dart';
import '../../../../core/network/network_info.dart';
import '../../../../router/routes.dart';
import '../../domain/entities/weather_event.dart';
import '../notifiers/favorites_notifier.dart';
import '../widgets/event_card.dart';
import '../widgets/offline_banner.dart';

class FavoritesScreen extends ConsumerStatefulWidget {
  const FavoritesScreen({super.key});

  @override
  ConsumerState<FavoritesScreen> createState() => _FavoritesScreenState();
}

class _FavoritesScreenState extends ConsumerState<FavoritesScreen> {
  bool _isOffline = false;

  @override
  void initState() {
    super.initState();

    Future.microtask(() async {
      final hasInternet = await sl<NetworkInfo>().isConnected;

      if (mounted) {
        setState(() {
          _isOffline = !hasInternet;
        });
      }

      ref.read(favoritesNotifierProvider.notifier).loadFavorites();
    });
  }

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(favoritesNotifierProvider);

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

    return Scaffold(
      appBar: AppBar(
        title: const Text('Favoritos'),
      ),
      body: _buildContent(state),
    );
  }

  Widget _buildContent(FavoritesState state) {
    if (state.isLoading) {
      return const Center(
        child: CircularProgressIndicator(),
      );
    }

    if (state.errorMessage != null) {
      return Center(
        child: Text(state.errorMessage!),
      );
    }

    if (state.favorites.isEmpty) {
      return ListView(
        children: [
          if (_isOffline)
            const OfflineBanner(
              message: 'Sin conexión. Mostrando favoritos guardados.',
            ),
          const SizedBox(height: 120),
          const Icon(
            Icons.favorite_border,
            size: 52,
          ),
          const SizedBox(height: 16),
          const Center(
            child: Text('No tienes eventos favoritos.'),
          ),
        ],
      );
    }

    return ListView.builder(
      padding: const EdgeInsets.only(bottom: 16),
      itemCount: state.favorites.length + (_isOffline ? 1 : 0),
      itemBuilder: (context, index) {
        if (_isOffline && index == 0) {
          return const OfflineBanner(
            message: 'Sin conexión. Mostrando favoritos guardados.',
          );
        }

        final favoriteIndex = _isOffline ? index - 1 : index;
        final favorite = state.favorites[favoriteIndex];

        final event = WeatherEvent(
          id: favorite.id,
          title: favorite.title,
          type: favorite.type,
          description: favorite.description,
          date: favorite.date,
          locationName: favorite.locationName,
          latitude: favorite.latitude,
          longitude: favorite.longitude,
          isFavorite: true,
        );

        return EventCard(
          event: event,
          onTap: () {
            context.push(
              Routes.eventDetail,
              extra: event,
            );
          },
          onFavoritePressed: () async {
            await ref.read(favoritesNotifierProvider.notifier).toggle(event);
          },
        );
      },
    );
  }
}