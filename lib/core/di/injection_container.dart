import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';

import '../../features/events/data/datasources/events_api.dart';
import '../../features/events/data/datasources/events_local_storage.dart';
import '../../features/events/data/repositories/events_repository_impl.dart';
import '../../features/events/domain/repositories/events_repository.dart';
import '../../features/events/domain/usecases/get_events.dart';
import '../../features/events/domain/usecases/toggle_favorite.dart';
import '../../features/forecast/data/datasources/forecast_api.dart';
import '../../features/forecast/data/datasources/forecast_local_storage.dart';
import '../../features/forecast/data/repositories/forecast_repository_impl.dart';
import '../../features/forecast/domain/repositories/forecast_repository.dart';
import '../../features/forecast/domain/usecases/get_last_five_days.dart';
import '../../features/location/domain/search_locations.dart';
import '../../features/location/domain/usecases/get_current_location_usecase.dart';
import '../config/app_config.dart';
import '../network/dio_client.dart';
import '../network/network_info.dart';

final sl = GetIt.instance;

Future<void> initDependencies(AppConfig config) async {
  sl.registerSingleton<AppConfig>(config);

  sl.registerLazySingleton<Connectivity>(
    () => Connectivity(),
  );

  sl.registerLazySingleton<NetworkInfo>(
    () => NetworkInfoImpl(sl<Connectivity>()),
  );

  sl.registerLazySingleton<Dio>(
    () => DioClient(config: sl<AppConfig>()).build(),
  );

  sl.registerLazySingleton<EventsApi>(
    () => EventsApi(sl<Dio>()),
  );

  sl.registerLazySingleton<EventsLocalStorage>(
    () => EventsLocalStorage(),
  );

  sl.registerLazySingleton<EventsRepository>(
    () => EventsRepositoryImpl(
      api: sl<EventsApi>(),
      localStorage: sl<EventsLocalStorage>(),
      networkInfo: sl<NetworkInfo>(),
    ),
  );

  sl.registerLazySingleton<GetEvents>(
    () => GetEvents(sl<EventsRepository>()),
  );

  sl.registerLazySingleton<ToggleFavorite>(
    () => ToggleFavorite(sl<EventsRepository>()),
  );

  sl.registerLazySingleton<ForecastApi>(
    () => ForecastApi(sl<Dio>()),
  );

  sl.registerLazySingleton<ForecastLocalStorage>(
    () => ForecastLocalStorage(),
  );

  sl.registerLazySingleton<ForecastRepository>(
    () => ForecastRepositoryImpl(
      api: sl<ForecastApi>(),
      localStorage: sl<ForecastLocalStorage>(),
      networkInfo: sl<NetworkInfo>(),
    ),
  );

  sl.registerLazySingleton<GetLastFiveDays>(
    () => GetLastFiveDays(sl<ForecastRepository>()),
  );

  sl.registerLazySingleton<GetCurrentLocationUseCase>(
    () => GetCurrentLocationUseCase(),
  );

  sl.registerLazySingleton<SearchLocations>(
    () => SearchLocations(sl<Dio>()),
  );
}