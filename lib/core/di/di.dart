import 'package:clima_app/core/shared/services/network_service.dart';
import 'package:clima_app/core/shared/ui/cubits/network_cubit.dart';
import 'package:clima_app/features/city/data/datasources/city_datasource.dart';
import 'package:clima_app/features/city/data/repositories/city_repository_impl.dart';
import 'package:clima_app/features/city/domain/repositories/city_repository.dart';
import 'package:clima_app/features/city/data/datasources/city_datasource_impl.dart';
import 'package:clima_app/features/favorites/data/datasources/favorite_weather_datasource.dart';
import 'package:clima_app/features/favorites/data/repositories/favorite_weather_repository_impl.dart';
import 'package:clima_app/features/favorites/domain/repository/favorite_weather_repository.dart';
import 'package:clima_app/features/favorites/data/datasources/favorite_weather_datasource_impl.dart';
import 'package:clima_app/features/favorites/presentation/delete/cubits/favorite_delete_cubit.dart';
import 'package:clima_app/features/favorites/presentation/fetch/cubits/favorite_cubit.dart';
import 'package:clima_app/features/favorites/presentation/useCases/store_favorite_use_case.dart';
import 'package:clima_app/features/home/data/datasources/search_weather_datasource.dart';
import 'package:clima_app/features/home/data/repositories/location_repository_impl.dart';
import 'package:clima_app/features/home/data/repositories/search_weather_repository_impl.dart';
import 'package:clima_app/features/home/data/repositories/weather_description_repository_impl.dart';
import 'package:clima_app/features/home/domain/repositories/location_repository.dart';
import 'package:clima_app/features/home/domain/repositories/search_weather_repository.dart';
import 'package:clima_app/features/home/domain/repositories/weather_description_repository.dart';
import 'package:clima_app/features/home/domain/services/location_service.dart';
import 'package:clima_app/features/home/domain/usecases/get_weather_use_case.dart';
import 'package:clima_app/core/shared/data/datasources/location_datasource_impl.dart';
import 'package:clima_app/features/home/data/datasources/search_weather_datasource_impl.dart';
import 'package:clima_app/core/shared/data/datasources/weather_description_local_datasource_impl.dart';
import 'package:clima_app/features/home/presentation/blocs/city_weather_bloc.dart';
import 'package:clima_app/features/home/presentation/blocs/home_page_navigation_cubit.dart';
import 'package:clima_app/features/home/presentation/dto/weather_mapper.dart';
import 'package:clima_app/features/ia/data/datasources/ia_datasource.dart';
import 'package:clima_app/features/ia/data/datasources/ia_datasource_impl.dart';
import 'package:clima_app/features/ia/data/repositories/ia_repository_impl.dart';
import 'package:clima_app/features/ia/domain/repositories/ia_repository.dart';
import 'package:clima_app/features/ia/ui/blocs/ia_cubit.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:get_it/get_it.dart';
import 'package:clima_app/core/dio_client.dart';
import 'package:clima_app/core/helpers/hive_initializer.dart';

final getIt = GetIt.instance;

Future<void> initDependencies() async {
  // Core
  final appId = dotenv.env["WEATHER_APP_ID"] ?? "";
  final appUrl = dotenv.env["WEATHER_API_URL"] ?? "";

  final dioClient = DioClient(apiKey: appId, url: appUrl);
  final box = await HiveInitializer.init();
  getIt.registerSingleton(dioClient);
  getIt.registerSingleton(box);
  getIt.registerSingleton<Connectivity>(Connectivity());
  getIt.registerLazySingleton(
      () => NetworkService(connectivity: getIt<Connectivity>()));

  // Helpers
  getIt.registerLazySingleton(() => WeatherMapper(getIt()));

  // Services
  getIt.registerLazySingleton(() => LocationService(getIt()));

  // DataSources
  getIt.registerLazySingleton<IADatasource>(() => IADatasourceImpl());
  getIt.registerLazySingleton<CityDataSource>(
      () => CityDataSourceImpl(dio: dioClient.dio));
  getIt.registerLazySingleton<SearchWeatherDataSource>(
      () => SearchWeatherDatasourceImpl(dio: dioClient.dio));
  getIt.registerLazySingleton(
      () => LocationDataSourceImpl(networkService: getIt<NetworkService>()));
  getIt.registerLazySingleton(() => WeatherDescriptionLocalDataSourceImpl());
  getIt.registerLazySingleton<FavoriteWeatherDataSource>(
      () => FavoriteWeatherDataSourceImpl(box: box));

  // Repositories
  getIt.registerLazySingleton<IARepository>(
      () => IaRepositoryImpl(datasource: getIt()));

  getIt.registerLazySingleton<CityRepository>(
    () => CityRepositoryImpl(dataSource: getIt()),
  );

  getIt.registerLazySingleton<SearchWeatherRepository>(
    () => SearchWeatherRepositoryImpl(datasource: getIt()),
  );

  getIt.registerLazySingleton<FavoriteWeatherRepository>(
    () => FavoriteWeatherRepositoryImpl(
        dataSource: getIt(), locationService: getIt<LocationService>()),
  );

  getIt.registerLazySingleton<WeatherDescriptionRepository>(
    () => WeatherDescriptionRepositoryImpl(dataSource: getIt()),
  );

  getIt.registerLazySingleton<LocationRepository>(
      () => LocationRepositoryImpl(getIt()));

  getIt.registerLazySingleton(() => GetWeatherUseCase(
      repository: getIt<SearchWeatherRepository>(),
      locationService: getIt<LocationService>(),
      mapper: getIt<WeatherMapper>()));

  // Blocs / Cubits
  getIt.registerFactory<NetworkCubit>(
      () => NetworkCubit(networkService: getIt<NetworkService>()));

  getIt.registerFactory<IACubit>(
      () => IACubit(repository: getIt<IARepository>()));

  final favoriteWeatherRepository = getIt<FavoriteWeatherRepository>();
  getIt.registerLazySingleton<StoreFavoriteUseCase>(
      () => StoreFavoriteUseCase(repository: favoriteWeatherRepository));

  final storeFavoriteUseCase = getIt<StoreFavoriteUseCase>();

  getIt.registerFactory<FavoriteCubit>(() => FavoriteCubit(
      repository: favoriteWeatherRepository,
      storeFavoriteUseCase: storeFavoriteUseCase));

  getIt.registerFactory<FavoriteDeleteCubit>(
      () => FavoriteDeleteCubit(repository: favoriteWeatherRepository));

  getIt.registerFactory<CityWeatherBloc>(() => CityWeatherBloc(
        getWeatherUseCase: getIt<GetWeatherUseCase>(),
        cityRepository: getIt<CityRepository>(),
      ));

  getIt.registerFactory<HomePageNavigationCubit>(
      () => HomePageNavigationCubit());
}
