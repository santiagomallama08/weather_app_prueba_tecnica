import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/di/injection_container.dart';
import '../../../../core/network/network_info.dart';
import '../../domain/entities/current_weather.dart';
import '../../domain/entities/weather_day.dart';
import '../../domain/usecases/get_last_five_days.dart';

final forecastNotifierProvider =
    StateNotifierProvider<ForecastNotifier, ForecastState>((ref) {
  return ForecastNotifier(
    getLastFiveDays: sl<GetLastFiveDays>(),
    networkInfo: sl<NetworkInfo>(),
  );
});

class ForecastState {
  final bool isLoading;
  final bool isOffline;
  final String? errorMessage;
  final String location;
  final CurrentWeather? currentWeather;
  final List<WeatherDay> days;

  const ForecastState({
    this.isLoading = false,
    this.isOffline = false,
    this.errorMessage,
    this.location = '',
    this.currentWeather,
    this.days = const [],
  });

  ForecastState copyWith({
    bool? isLoading,
    bool? isOffline,
    String? errorMessage,
    String? location,
    CurrentWeather? currentWeather,
    List<WeatherDay>? days,
  }) {
    return ForecastState(
      isLoading: isLoading ?? this.isLoading,
      isOffline: isOffline ?? this.isOffline,
      errorMessage: errorMessage,
      location: location ?? this.location,
      currentWeather: currentWeather ?? this.currentWeather,
      days: days ?? this.days,
    );
  }
}

class ForecastNotifier extends StateNotifier<ForecastState> {
  final GetLastFiveDays getLastFiveDays;
  final NetworkInfo networkInfo;

  ForecastNotifier({
    required this.getLastFiveDays,
    required this.networkInfo,
  }) : super(const ForecastState());

  Future<void> loadForecast(String location) async {
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
      final result = await getLastFiveDays(cleanLocation);

      state = state.copyWith(
        isLoading: false,
        isOffline: !hasInternet,
        currentWeather: result.current,
        days: result.days,
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
}