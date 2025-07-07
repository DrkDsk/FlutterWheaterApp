import 'package:clima_app/core/dio_client.dart';
import 'package:clima_app/features/search/data/datasources/search_weather_datasource_impl.dart';
import 'package:clima_app/features/search/data/repositories/search_weather_repository_impl.dart';
import 'package:clima_app/features/search/domain/repositories/search_weather_repository.dart';
import 'package:clima_app/features/search/presentation/blocs/cubits/background_weather_cubit.dart';
import 'package:clima_app/features/search/presentation/blocs/weather_cubit.dart';
import 'package:clima_app/src/my_app.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'features/search/presentation/blocs/cubits/theme_cubit.dart';


void main() {
  WidgetsFlutterBinding.ensureInitialized();

  final dioClient = DioClient();

  runApp(
    MultiRepositoryProvider(
      providers: [
        RepositoryProvider<SearchWeatherRepository>(
          create: (context) => SearchRepositoryImpl(
            datasource: SearchWeatherDatasourceImpl(dio: dioClient.dio),
          ),
        ),
      ],
      child: MultiBlocProvider(
        providers: [
          BlocProvider(create: (context) => ThemeCubit()),
          BlocProvider(create: (context) => BackgroundWeatherCubit()),
          BlocProvider(create: (context) => WeatherCubit(repository: context.read<SearchWeatherRepository>())..getWeather())
        ],
        child: const MyApp(),
      ),
    ),
  );
}
