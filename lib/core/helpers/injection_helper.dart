import 'package:clima_app/features/city/data/datasources/city_datasource.dart';
import 'package:clima_app/features/city/data/repositories/city_repository_impl.dart';
import 'package:clima_app/features/city/domain/repositories/city_repository.dart';
import 'package:clima_app/features/city/domain/usecases/get_city_usecase.dart';
import 'package:clima_app/features/city/domain/usecases/search_city_usecase.dart';
import 'package:clima_app/features/city/data/datasources/city_datasource_impl.dart';
import 'package:clima_app/features/favorites/data/datasources/favorite_weather_datasource.dart';
import 'package:clima_app/features/favorites/data/repositories/favorite_weather_repository_impl.dart';
import 'package:clima_app/features/favorites/domain/repository/favorite_weather_repository.dart';
import 'package:clima_app/features/favorites/data/datasources/favorite_weather_datasource_impl.dart';
import 'package:clima_app/features/favorites/presentation/blocs/favorite_bloc.dart';
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
import 'package:clima_app/features/home/presentation/dto/weather_mapper.dart';
import 'package:get_it/get_it.dart';
import 'package:clima_app/core/dio_client.dart';
import 'package:clima_app/core/helpers/hive_initializer.dart';

final getIt = GetIt.instance;

Future<void> initDependencies() async {
  // Core
  final dioClient = DioClient();
  final box = await HiveInitializer.init();
  getIt.registerSingleton(dioClient);
  getIt.registerSingleton(box);

  // DataSources
  getIt.registerLazySingleton<CityDataSource>(() => CityDataSourceImpl(dio: dioClient.dio));
  getIt.registerLazySingleton<SearchWeatherDataSource>(() => SearchWeatherDatasourceImpl(dio: dioClient.dio));
  getIt.registerLazySingleton(() => LocationDataSourceImpl());
  getIt.registerLazySingleton(() => WeatherDescriptionLocalDataSourceImpl());
  getIt.registerLazySingleton<FavoriteWeatherDataSource>(() => FavoriteWeatherDataSourceImpl(box: box));

  // Repositories
  getIt.registerLazySingleton<CityRepository>(
        () => CityRepositoryImpl(dataSource: getIt()),
  );

  getIt.registerLazySingleton<SearchWeatherRepository>(
        () => SearchWeatherRepositoryImpl(datasource: getIt()),
  );

  getIt.registerLazySingleton<FavoriteWeatherRepository>(
        () => FavoriteWeatherRepositoryImpl(dataSource: getIt()),
  );

  getIt.registerLazySingleton<WeatherDescriptionRepository>(
        () => WeatherDescriptionRepositoryImpl(dataSource: getIt()),
  );

  getIt.registerLazySingleton<LocationRepository>(() => LocationRepositoryImpl(getIt()));

  // Services
  getIt.registerLazySingleton(() => LocationService(getIt()));

  // UseCases
  getIt.registerLazySingleton<SearchCityUseCase>(
        () => SearchCityUseCase(repository: getIt<CityRepository>()),
  );
  getIt.registerLazySingleton(() => GetCityUseCase(repository: getIt<CityRepository>()));
  getIt.registerLazySingleton(() => GetWeatherUseCase(
    repository: getIt<SearchWeatherRepository>(),
    locationService: getIt<LocationService>(),
  ));

  // Helpers
  getIt.registerLazySingleton(() => WeatherMapper(getIt()));

  // Blocs / Cubits
  getIt.registerFactory<FavoriteBloc>(() => FavoriteBloc(repository: getIt<FavoriteWeatherRepository>(), locationService:  getIt<LocationService>()));
  getIt.registerFactory<CityWeatherBloc>(() => CityWeatherBloc(getWeatherUseCase: getIt<GetWeatherUseCase>(),searchCityUseCase: getIt<SearchCityUseCase>(), getCityUseCase: getIt<GetCityUseCase>(), mapper: getIt<WeatherMapper>()));
}
