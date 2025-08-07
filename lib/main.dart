import 'package:clima_app/core/helpers/injection_helper.dart';
import 'package:clima_app/features/favorites/presentation/blocs/favorite_bloc.dart';
import 'package:clima_app/features/favorites/presentation/blocs/favorite_event.dart';
import 'package:clima_app/features/home/presentation/blocs/cubits/background_weather_cubit.dart';
import 'package:clima_app/features/home/presentation/blocs/cubits/theme_cubit.dart';
import 'package:clima_app/features/home/presentation/blocs/events/weather_event.dart';
import 'package:clima_app/features/home/presentation/blocs/weather_bloc.dart';
import 'package:clima_app/src/my_app.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'core/helpers/timezone_config.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  TimeZoneConfig.initTimeZone();

  await initDependencies();

  runApp(
    MultiRepositoryProvider(
      providers: [
        BlocProvider(create: (_) => getIt<FavoriteBloc>()..add(const GetFavoritesCitiesEvent())),
        BlocProvider(create: (_) => getIt<WeatherBloc>()..add(const LoadCurrentWeatherForCityEvent())),
        BlocProvider(create: (_) => getIt<ThemeCubit>()),
        BlocProvider(create: (_) => getIt<BackgroundWeatherCubit>()),
      ],
      child:const MyApp(),
    ),
  );
}
