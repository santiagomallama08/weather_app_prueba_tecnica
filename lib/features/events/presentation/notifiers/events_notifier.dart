import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/di/injection_container.dart';
import '../../../../core/network/network_info.dart';
import '../../domain/entities/weather_event.dart';
import '../../domain/usecases/get_events.dart';

final eventsNotifierProvider =
    StateNotifierProvider<EventsNotifier, EventsState>((ref) {
  return EventsNotifier(
    getEvents: sl<GetEvents>(),
    networkInfo: sl<NetworkInfo>(),
  );
});

class EventsState {
  final bool isLoading;
  final bool isOffline;
  final String? errorMessage;
  final String location;
  final List<WeatherEvent> events;

  const EventsState({
    this.isLoading = false,
    this.isOffline = false,
    this.errorMessage,
    this.location = '',
    this.events = const [],
  });

  EventsState copyWith({
    bool? isLoading,
    bool? isOffline,
    String? errorMessage,
    String? location,
    List<WeatherEvent>? events,
  }) {
    return EventsState(
      isLoading: isLoading ?? this.isLoading,
      isOffline: isOffline ?? this.isOffline,
      errorMessage: errorMessage,
      location: location ?? this.location,
      events: events ?? this.events,
    );
  }
}

class EventsNotifier extends StateNotifier<EventsState> {
  final GetEvents getEvents;
  final NetworkInfo networkInfo;

  EventsNotifier({
    required this.getEvents,
    required this.networkInfo,
  }) : super(const EventsState());

  Future<void> loadEvents(String location) async {
    final cleanLocation = location.trim();

    if (cleanLocation.isEmpty) {
      state = state.copyWith(
        errorMessage: 'Ingresa una ubicación válida.',
      );
      return;
    }

    state = state.copyWith(
      isLoading: true,
      errorMessage: null,
      location: cleanLocation,
    );

    try {
      final hasInternet = await networkInfo.isConnected;
      final events = await getEvents(cleanLocation);

      state = state.copyWith(
        isLoading: false,
        isOffline: !hasInternet,
        events: events,
        errorMessage: null,
      );
    } catch (e) {
      state = state.copyWith(
        isLoading: false,
        isOffline: false,
        errorMessage: e.toString(),
      );
    }
  }

  void updateEventFavorite(
    String eventId, {
    required bool isFavorite,
  }) {
    final updatedEvents = state.events.map((event) {
      if (event.id == eventId) {
        return event.copyWith(isFavorite: isFavorite);
      }

      return event;
    }).toList();

    state = state.copyWith(events: updatedEvents);
  }

  void clearError() {
    state = state.copyWith(errorMessage: null);
  }
}