import 'package:clima_app/core/helpers/injection_helper.dart';
import 'package:clima_app/features/favorites/presentation/blocs/favorite_bloc.dart';
import 'package:clima_app/features/favorites/presentation/blocs/favorite_event.dart';
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
    MultiBlocProvider(
      providers: [
        BlocProvider(create: (_) => getIt<FavoriteBloc>()..add(const GetFavoritesCitiesEvent())),
        BlocProvider(create: (_) => getIt<WeatherBloc>()),
      ],
      child:const MyApp(),
    ),
  );
}
