import 'package:clima_app/core/di/di.dart';
import 'package:clima_app/features/favorites/presentation/blocs/favorite_bloc.dart';
import 'package:clima_app/features/favorites/presentation/blocs/favorite_event.dart';
import 'package:clima_app/features/home/presentation/blocs/city_weather_bloc.dart';
import 'package:clima_app/features/ia/ui/blocs/ia_cubit.dart';
import 'package:clima_app/src/my_app.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'core/helpers/timezone_config.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  TimeZoneConfig.initTimeZone();
  await dotenv.load(fileName: ".env");

  await initDependencies();

  runApp(
    MultiBlocProvider(
      providers: [
        BlocProvider(create: (_) => getIt<FavoriteBloc>()..add(const GetFavoritesCitiesEvent())),
        BlocProvider(create: (_) => getIt<CityWeatherBloc>()),
        BlocProvider(create: (_) => getIt<IACubit>()),
      ],
      child:const MyApp(),
    ),
  );
}
