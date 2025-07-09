import 'package:clima_app/core/dio_client.dart';
import 'package:clima_app/features/search/data/datasources/location_datasource_impl.dart';
import 'package:clima_app/features/search/data/datasources/search_weather_datasource_impl.dart';
import 'package:clima_app/features/search/data/datasources/weather_description_local_datasource.dart';
import 'package:clima_app/features/search/data/repositories/location_repository_impl.dart';
import 'package:clima_app/features/search/data/repositories/search_weather_repository_impl.dart';
import 'package:clima_app/features/search/data/repositories/weather_description_repository_impl.dart';
import 'package:clima_app/features/search/domain/repositories/search_weather_repository.dart';
import 'package:clima_app/features/search/domain/usecases/get_current_location_usecase.dart';
import 'package:clima_app/features/search/presentation/blocs/cubits/background_weather_cubit.dart';
import 'package:clima_app/features/search/presentation/blocs/weather_cubit.dart';
import 'package:clima_app/features/search/presentation/dto/weather_mapper.dart';
import 'package:clima_app/src/my_app.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'core/helpers/timezone_config.dart';
import 'features/search/presentation/blocs/cubits/theme_cubit.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  TimeZoneConfig.initTimeZone();

  final dioClient = DioClient();
  final repositoriesProviders = [
    RepositoryProvider<SearchWeatherRepository>(
      create: (context) => SearchRepositoryImpl(
        datasource: SearchWeatherDatasourceImpl(dio: dioClient.dio),
      ),
    ),
    RepositoryProvider<GetCurrentLocationUseCase>(
        create: (context) => GetCurrentLocationUseCase(
            LocationRepositoryImpl(LocationDataSourceImpl()))),
    RepositoryProvider(
        create: (context) => WeatherMapper(WeatherDescriptionRepositoryImpl(
            dataSource: WeatherDescriptionLocalDataSource())))
  ];

  final blocsProviders = [
    BlocProvider<WeatherCubit>(
      create: (context) => WeatherCubit(
        mapper: context.read<WeatherMapper>(),
        repository: context.read<SearchWeatherRepository>(),
        useCase: context.read<GetCurrentLocationUseCase>(),
      )..getWeather(),
    ),
    BlocProvider(create: (context) => ThemeCubit()),
    BlocProvider<BackgroundWeatherCubit>(
      create: (context) => BackgroundWeatherCubit(context.read<WeatherCubit>()),
    ),
  ];

  runApp(
    MultiRepositoryProvider(
      providers: repositoriesProviders,
      child: MultiBlocProvider(
        providers: blocsProviders,
        child: const MyApp(),
      ),
    ),
  );
}
