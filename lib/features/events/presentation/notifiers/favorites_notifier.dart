import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/di/injection_container.dart';
import '../../domain/entities/favorite_event.dart';
import '../../domain/entities/weather_event.dart';
import '../../domain/repositories/events_repository.dart';
import '../../domain/usecases/toggle_favorite.dart';
import 'events_notifier.dart';

final favoritesNotifierProvider =
    StateNotifierProvider<FavoritesNotifier, FavoritesState>((ref) {
  return FavoritesNotifier(
    repository: sl<EventsRepository>(),
    toggleFavorite: sl<ToggleFavorite>(),
    ref: ref,
  );
});

class FavoritesState {
  final bool isLoading;
  final String? errorMessage;
  final String? successMessage;
  final List<FavoriteEvent> favorites;

  const FavoritesState({
    this.isLoading = false,
    this.errorMessage,
    this.successMessage,
    this.favorites = const [],
  });

  FavoritesState copyWith({
    bool? isLoading,
    String? errorMessage,
    String? successMessage,
    List<FavoriteEvent>? favorites,
  }) {
    return FavoritesState(
      isLoading: isLoading ?? this.isLoading,
      errorMessage: errorMessage,
      successMessage: successMessage,
      favorites: favorites ?? this.favorites,
    );
  }
}

class FavoritesNotifier extends StateNotifier<FavoritesState> {
  final EventsRepository repository;
  final ToggleFavorite toggleFavorite;
  final Ref ref;

  FavoritesNotifier({
    required this.repository,
    required this.toggleFavorite,
    required this.ref,
  }) : super(const FavoritesState());

  Future<void> loadFavorites() async {
    state = state.copyWith(
      isLoading: true,
      errorMessage: null,
      successMessage: null,
    );

    try {
      final favorites = await repository.getFavoriteEvents();

      state = state.copyWith(
        isLoading: false,
        favorites: favorites,
        errorMessage: null,
      );
    } catch (_) {
      state = state.copyWith(
        isLoading: false,
        errorMessage: 'No se pudieron cargar los favoritos.',
      );
    }
  }

  Future<void> toggle(WeatherEvent event) async {
    try {
      final wasFavorite = await repository.isFavorite(event.id);

      await toggleFavorite(event);

      ref.read(eventsNotifierProvider.notifier).updateEventFavorite(
            event.id,
            isFavorite: !wasFavorite,
          );

      await loadFavorites();

      state = state.copyWith(
        successMessage: wasFavorite
            ? 'Eliminado de favoritos.'
            : 'Añadido a favoritos.',
      );
    } catch (_) {
      state = state.copyWith(
        errorMessage: 'No se pudo actualizar el favorito.',
      );
    }
  }

  void clearMessages() {
    state = state.copyWith(
      errorMessage: null,
      successMessage: null,
    );
  }
}