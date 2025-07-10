import 'package:clima_app/features/search/presentation/blocs/cubits/background_weather_cubit.dart';
import 'package:clima_app/features/search/presentation/blocs/cubits/theme_cubit.dart';
import 'package:clima_app/features/search/presentation/blocs/weather_bloc.dart';
import 'package:clima_app/features/search/presentation/blocs/weather_event.dart';
import 'package:clima_app/features/search/presentation/blocs/weather_state.dart';
import 'package:clima_app/features/search/presentation/extensions/current_weather_extension.dart';
import 'package:clima_app/features/search/presentation/widgets/daily_list_weather_widget.dart';
import 'package:clima_app/features/search/presentation/widgets/header_weather_widget.dart';
import 'package:clima_app/features/search/presentation/widgets/hourly_list_weather_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomeWeatherPage extends StatefulWidget {
  const HomeWeatherPage({super.key});

  @override
  State<HomeWeatherPage> createState() => _HomeWeatherPageState();
}

class _HomeWeatherPageState extends State<HomeWeatherPage> {
  late WeatherBloc weatherCubit;
  late ThemeCubit themeCubit;

  @override
  void initState() {
    super.initState();
    weatherCubit = context.read<WeatherBloc>();
    themeCubit = context.read<ThemeCubit>();
    Future.microtask(() {
      weatherCubit.add(const CurrentWeatherEvent());
    });
  }

  @override
  Widget build(BuildContext context) {
    final backgroundWeatherCubit = context.watch<BackgroundWeatherCubit>();
    final theme = Theme.of(context);

    return Scaffold(
      body: Container(
        color: backgroundWeatherCubit.state,
        child: SafeArea(
            child: SizedBox(
          width: MediaQuery.of(context).size.width,
          child: Padding(
            padding: const EdgeInsets.only(left: 16.0, right: 16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(
                  height: 12,
                ),
                Row(
                  children: [
                    BlocBuilder<WeatherBloc, WeatherState>(
                      builder: (context, state) {
                        if (state is WeatherSuccessState) {
                          return Expanded(
                            flex: 1,
                            child: Text(
                              state.city,
                              style: theme.textTheme.bodyLarge,
                            ),
                          );
                        }

                        if (state is WeatherErrorState) {
                          return Text(state.message);
                        }

                        return const Center(child: CircularProgressIndicator());
                      },
                    ),
                    IconButton(
                      icon: Icon(themeCubit.state.isDarkMode
                          ? Icons.sunny
                          : Icons.nightlight),
                      color: theme.colorScheme.onPrimary,
                      onPressed: () {
                        themeCubit.toggleTheme();
                      },
                    )
                  ],
                ),
                const SizedBox(
                  height: 8,
                ),
                const SizedBox(height: 10),
                BlocBuilder<WeatherBloc, WeatherState>(
                  builder: (context, state) {
                    if (state is WeatherErrorState) {
                      return Text(state.message);
                    }

                    if (state is WeatherSuccessState) {
                      return HeaderWeatherWidget(
                          translatedWeather: state.translatedWeather,
                          temp: state.currentWeather.tempCelsiusText);
                    }

                    return const Center(child: CircularProgressIndicator());
                  },
                ),
                const SizedBox(height: 20),
                BlocBuilder<WeatherBloc, WeatherState>(
                  builder: (context, state) {

                    if (state is WeatherErrorState) {
                      return Text(state.message);
                    }

                    if (state is WeatherSuccessState) {
                      return HourlyListWeatherWidget(hourly: state.hourly);
                    }

                    return const Center(child: CircularProgressIndicator());
                  },
                ),
                const SizedBox(height: 20),
                BlocBuilder<WeatherBloc, WeatherState>(
                  builder: (context, state) {
                    if (state is WeatherErrorState) {
                      return Text(state.message);
                    }

                    if (state is WeatherSuccessState) {
                      return DailyListWeatherWidget(daily: state.daily);
                    }

                    return const Center(child: CircularProgressIndicator());
                  },
                ),
                const SizedBox(height: 20)
              ],
            ),
          ),
        )),
      ),
    );
  }
}
