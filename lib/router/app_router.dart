import 'package:go_router/go_router.dart';

import '../features/events/domain/entities/weather_event.dart';
import '../features/events/presentation/screens/event_detail_screen.dart';
import '../features/events/presentation/screens/events_screen.dart';
import '../features/events/presentation/screens/favorites_screen.dart';
import '../features/forecast/presentation/screens/forecast_screen.dart';
import '../features/location/presentation/screens/location_input_screen.dart';
import '../features/location/presentation/screens/map_screen.dart';
import 'routes.dart';

final appRouter = GoRouter(
  initialLocation: Routes.locationInput,
  routes: [
    GoRoute(
      path: Routes.locationInput,
      name: 'locationInput',
      builder: (context, state) {
        return const LocationInputScreen();
      },
    ),
    GoRoute(
      path: Routes.events,
      name: 'events',
      builder: (context, state) {
        final location = state.extra as String? ?? 'Pasto, Colombia';

        return EventsScreen(location: location);
      },
    ),
    GoRoute(
      path: Routes.eventDetail,
      name: 'eventDetail',
      builder: (context, state) {
        final event = state.extra as WeatherEvent;

        return EventDetailScreen(event: event);
      },
    ),
    GoRoute(
      path: Routes.favorites,
      name: 'favorites',
      builder: (context, state) {
        return const FavoritesScreen();
      },
    ),
    GoRoute(
      path: Routes.forecast,
      name: 'forecast',
      builder: (context, state) {
        final location = state.extra as String? ?? 'Pasto, Colombia';

        return ForecastScreen(location: location);
      },
    ),
    GoRoute(
      path: Routes.map,
      name: 'map',
      builder: (context, state) {
        final data = state.extra as Map<String, dynamic>;

        return MapScreen(
          title: data['title'] as String,
          locationName: data['locationName'] as String,
          latitude: data['latitude'] as double,
          longitude: data['longitude'] as double,
        );
      },
    ),
  ],
);