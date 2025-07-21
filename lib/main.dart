import 'package:clima_app/core/dio_client.dart';
import 'package:clima_app/features/city/data/repositories/city_repository_impl.dart';
import 'package:clima_app/features/city/domain/usecases/get_city_usecase.dart';
import 'package:clima_app/features/city/infrastructure/datasources/city_datasource_impl.dart';
import 'package:clima_app/features/home/infrastructure/datasources/location_datasource_impl.dart';
import 'package:clima_app/features/home/infrastructure/datasources/search_weather_datasource_impl.dart';
import 'package:clima_app/features/home/infrastructure/datasources/weather_description_local_datasource_impl.dart';
import 'package:clima_app/features/home/data/repositories/location_repository_impl.dart';
import 'package:clima_app/features/home/data/repositories/search_weather_repository_impl.dart';
import 'package:clima_app/features/home/data/repositories/weather_description_repository_impl.dart';
import 'package:clima_app/features/home/domain/services/location_service.dart';
import 'package:clima_app/features/home/domain/usecases/get_weather_use_case.dart';
import 'package:clima_app/features/home/presentation/blocs/cubits/background_weather_cubit.dart';
import 'package:clima_app/features/home/presentation/blocs/weather_bloc.dart';
import 'package:clima_app/features/home/presentation/blocs/events/weather_event.dart';
import 'package:clima_app/features/home/presentation/dto/weather_mapper.dart';
import 'package:clima_app/src/my_app.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'core/helpers/timezone_config.dart';
import 'features/home/presentation/blocs/cubits/theme_cubit.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  TimeZoneConfig.initTimeZone();

  final dioClient = DioClient();
  final repositoriesProviders = [
    RepositoryProvider(
      create: (context) => GetCityUseCase(
        repository: CityRepositoryImpl(
          dataSource: CityDataSourceImpl(dio: dioClient.dio)
        )
      ),
    ),
    RepositoryProvider<GetWeatherUseCase>(
        create: (context) => GetWeatherUseCase(
            locationService: LocationService(
                LocationRepositoryImpl(LocationDataSourceImpl())
            ),
            repository: SearchWeatherRepositoryImpl(
              datasource: SearchWeatherDatasourceImpl(dio: dioClient.dio),
            )
        )
    ),
    RepositoryProvider(
        create: (context) => WeatherMapper(
            WeatherDescriptionRepositoryImpl(
                dataSource: WeatherDescriptionLocalDataSourceImpl()
            )
        )
    )
  ];

  final blocsProviders = [
    BlocProvider<WeatherBloc>(
      create: (context) => WeatherBloc(
        useCase: context.read<GetWeatherUseCase>(),
        mapper: context.read<WeatherMapper>())..add(const CurrentWeatherEvent()),
    ),
    BlocProvider(create: (context) => ThemeCubit()),
    BlocProvider<BackgroundWeatherCubit>(
      create: (context) => BackgroundWeatherCubit(context.read<WeatherBloc>()),
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
