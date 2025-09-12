import 'package:clima_app/core/di/di.dart';
import 'package:clima_app/features/favorites/presentation/delete/cubits/favorite_delete_cubit.dart';
import 'package:clima_app/features/favorites/presentation/fetch/cubits/favorite_fetch_cubit.dart';
import 'package:clima_app/features/favorites/presentation/store/cubits/favorite_store_cubit.dart';
import 'package:clima_app/features/home/presentation/blocs/city_weather_bloc.dart';
import 'package:clima_app/features/home/presentation/blocs/home_page_navigation_cubit.dart';
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
        BlocProvider(create: (_) => getIt<FavoriteFetchCubit>()),
        BlocProvider(create: (_) => getIt<FavoriteStoreCubit>()),
        BlocProvider(create: (_) => getIt<FavoriteDeleteCubit>()),
        BlocProvider(create: (_) => getIt<CityWeatherBloc>()),
        BlocProvider(create: (_) => getIt<IACubit>()),
        BlocProvider(create: (_) => getIt<HomePageNavigationCubit>())
      ],
      child: const MyApp(),
    ),
  );
}
