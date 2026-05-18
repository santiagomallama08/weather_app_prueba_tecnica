import 'dart:async';

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/di/injection_container.dart';
import '../../../../core/utils/constants.dart';
import '../../../../router/routes.dart';
import '../../domain/location_suggestion.dart';
import '../../domain/search_locations.dart';
import '../../domain/usecases/get_current_location_usecase.dart';

class LocationInputScreen extends StatefulWidget {
  const LocationInputScreen({super.key});

  @override
  State<LocationInputScreen> createState() => _LocationInputScreenState();
}

class _LocationInputScreenState extends State<LocationInputScreen> {
  final _locationController = TextEditingController(
    text: AppConstants.defaultLocation,
  );

  Timer? _debounce;
  bool _isLoadingLocation = false;
  bool _isSearching = false;
  List<LocationSuggestion> _suggestions = [];

  @override
  void initState() {
    super.initState();

    _locationController.addListener(_onLocationChanged);
  }

  @override
  void dispose() {
    _debounce?.cancel();
    _locationController.removeListener(_onLocationChanged);
    _locationController.dispose();
    super.dispose();
  }

  void _onLocationChanged() {
    _debounce?.cancel();

    _debounce = Timer(const Duration(milliseconds: 600), () {
      _searchSuggestions(_locationController.text);
    });
  }

  Future<void> _searchSuggestions(String query) async {
    if (query.trim().length < 3) {
      if (!mounted) return;
      setState(() {
        _suggestions = [];
      });
      return;
    }

    setState(() {
      _isSearching = true;
    });

    try {
      final results = await sl<SearchLocations>().call(query);

      if (!mounted) return;

      setState(() {
        _suggestions = results;
      });
    } catch (_) {
      if (!mounted) return;

      setState(() {
        _suggestions = [];
      });
    } finally {
      if (mounted) {
        setState(() {
          _isSearching = false;
        });
      }
    }
  }

  void _selectSuggestion(LocationSuggestion suggestion) {
    _debounce?.cancel();

    setState(() {
      _locationController.text = suggestion.displayName;
      _suggestions = [];
    });
  }

  void _goToEvents() {
    final location = _locationController.text.trim();

    if (location.isEmpty) {
      _showMessage('Ingresa una ubicación válida.');
      return;
    }

    context.push(
      Routes.events,
      extra: location,
    );
  }

  void _goToForecast() {
    final location = _locationController.text.trim();

    if (location.isEmpty) {
      _showMessage('Ingresa una ubicación válida.');
      return;
    }

    context.push(
      Routes.forecast,
      extra: location,
    );
  }

  Future<void> _useCurrentLocation() async {
    setState(() {
      _isLoadingLocation = true;
    });

    try {
      final location = await sl<GetCurrentLocationUseCase>().call();

      if (!mounted) return;

      _locationController.text = location;
      _suggestions = [];

      _showMessage('Ubicación obtenida correctamente.');
    } catch (e) {
      if (!mounted) return;

      _showMessage(e.toString());
    } finally {
      if (mounted) {
        setState(() {
          _isLoadingLocation = false;
        });
      }
    }
  }

  void _showMessage(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Weather Events'),
      ),
      body: ListView(
        padding: const EdgeInsets.all(18),
        children: [
          Container(
            padding: const EdgeInsets.all(22),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(22),
              gradient: LinearGradient(
                colors: [
                  theme.colorScheme.primary,
                  theme.colorScheme.primaryContainer,
                ],
              ),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Icon(
                  Icons.cloud_queue,
                  color: Colors.white,
                  size: 42,
                ),
                const SizedBox(height: 18),
                Text(
                  'Consulta el clima por ubicación',
                  style: theme.textTheme.headlineSmall?.copyWith(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  'Busca una ciudad, municipio o país para consultar eventos meteorológicos y el pronóstico de los últimos 5 días.',
                  style: theme.textTheme.bodyMedium?.copyWith(
                    color: Colors.white,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 22),
          Text(
            'Ubicación',
            style: theme.textTheme.titleMedium?.copyWith(
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 10),
          TextField(
            controller: _locationController,
            textInputAction: TextInputAction.search,
            onSubmitted: (_) => _goToForecast(),
            decoration: InputDecoration(
              hintText: 'Ej: Bogotá, Colombia',
              prefixIcon: const Icon(Icons.search),
              suffixIcon: _isSearching
                  ? const Padding(
                      padding: EdgeInsets.all(14),
                      child: SizedBox(
                        width: 18,
                        height: 18,
                        child: CircularProgressIndicator(strokeWidth: 2),
                      ),
                    )
                  : null,
            ),
          ),
          if (_suggestions.isNotEmpty) ...[
            const SizedBox(height: 8),
            Card(
              margin: EdgeInsets.zero,
              child: Column(
                children: _suggestions.map((suggestion) {
                  return ListTile(
                    leading: const Icon(Icons.place_outlined),
                    title: Text(
                      suggestion.displayName,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                    subtitle: Text(
                      '${suggestion.latitude.toStringAsFixed(4)}, ${suggestion.longitude.toStringAsFixed(4)}',
                    ),
                    onTap: () => _selectSuggestion(suggestion),
                  );
                }).toList(),
              ),
            ),
          ],
          const SizedBox(height: 18),
          FilledButton.icon(
            onPressed: _goToForecast,
            icon: const Icon(Icons.calendar_month),
            label: const Text('Ver últimos 5 días'),
          ),
          const SizedBox(height: 10),
          FilledButton.tonalIcon(
            onPressed: _goToEvents,
            icon: const Icon(Icons.warning_amber_rounded),
            label: const Text('Buscar eventos'),
          ),
          const SizedBox(height: 10),
          OutlinedButton.icon(
            onPressed: _isLoadingLocation ? null : _useCurrentLocation,
            icon: _isLoadingLocation
                ? const SizedBox(
                    width: 18,
                    height: 18,
                    child: CircularProgressIndicator(strokeWidth: 2),
                  )
                : const Icon(Icons.my_location),
            label: Text(
              _isLoadingLocation
                  ? 'Obteniendo ubicación...'
                  : 'Usar ubicación actual',
            ),
          ),
          const SizedBox(height: 22),
          Card(
            margin: EdgeInsets.zero,
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Row(
                children: [
                  Icon(
                    Icons.verified_outlined,
                    color: theme.colorScheme.primary,
                  ),
                  const SizedBox(width: 12),
                  const Expanded(
                    child: Text(
                      'Resultados en español, sistema métrico y consulta por ubicación personalizada.',
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}