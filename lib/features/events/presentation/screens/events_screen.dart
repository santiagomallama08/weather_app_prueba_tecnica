import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../../router/routes.dart';
import '../notifiers/events_notifier.dart';
import '../notifiers/favorites_notifier.dart';
import '../widgets/event_card.dart';
import '../widgets/offline_banner.dart';

class EventsScreen extends ConsumerStatefulWidget {
  final String location;

  const EventsScreen({super.key, required this.location});

  @override
  ConsumerState<EventsScreen> createState() => _EventsScreenState();
}

class _EventsScreenState extends ConsumerState<EventsScreen> {
  @override
  void initState() {
    super.initState();

    Future.microtask(() {
      ref.read(eventsNotifierProvider.notifier).loadEvents(widget.location);
      ref.read(favoritesNotifierProvider.notifier).loadFavorites();
    });
  }

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(eventsNotifierProvider);
    ref.listen<FavoritesState>(favoritesNotifierProvider, (previous, next) {
      if (next.successMessage != null) {
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(SnackBar(content: Text(next.successMessage!)));

        ref.read(favoritesNotifierProvider.notifier).clearMessages();
      }

      if (next.errorMessage != null) {
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(SnackBar(content: Text(next.errorMessage!)));

        ref.read(favoritesNotifierProvider.notifier).clearMessages();
      }
    });

    return Scaffold(
      appBar: AppBar(
        title: const Text('Eventos meteorológicos'),
        actions: [
          IconButton(
            tooltip: 'Favoritos',
            onPressed: () {
              context.push(Routes.favorites);
            },
            icon: const Icon(Icons.favorite),
          ),
        ],
      ),
      body: RefreshIndicator(
        onRefresh: () {
          return ref
              .read(eventsNotifierProvider.notifier)
              .loadEvents(widget.location);
        },
        child: _buildContent(context, state),
      ),
    );
  }

  Widget _buildContent(BuildContext context, EventsState state) {
    if (state.isLoading) {
      return const Center(child: CircularProgressIndicator());
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
                  .read(eventsNotifierProvider.notifier)
                  .loadEvents(widget.location);
            },
            child: const Text('Reintentar'),
          ),
        ],
      );
    }

    if (state.events.isEmpty) {
      return ListView(
        padding: const EdgeInsets.all(24),
        children: const [
          SizedBox(height: 100),
          Icon(Icons.cloud_off, size: 52),
          SizedBox(height: 16),
          Text(
            'No se encontraron eventos para esta ubicación.',
            textAlign: TextAlign.center,
          ),
        ],
      );
    }

    return ListView.builder(
      padding: const EdgeInsets.only(bottom: 16),
      itemCount: state.events.length + (state.isOffline ? 1 : 0),
      itemBuilder: (context, index) {
        if (state.isOffline && index == 0) {
          return const OfflineBanner();
        }

        final eventIndex = state.isOffline ? index - 1 : index;
        final event = state.events[eventIndex];

        return EventCard(
          event: event,
          onTap: () {
            context.push(Routes.eventDetail, extra: event);
          },
          onFavoritePressed: () async {
            await ref.read(favoritesNotifierProvider.notifier).toggle(event);
          },
        );
      },
    );
  }
}
