import 'package:clima_app/features/search/presentation/blocs/cubits/theme_cubit.dart';
import 'package:clima_app/src/my_app.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'features/search/presentation/blocs/cubits/background_weather_cubit.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();

  runApp(
    MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => ThemeCubit()),
        BlocProvider(create: (context) => BackgroundWeatherCubit())
      ],
      child: const MyApp()
    )
  );
}
