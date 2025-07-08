import 'package:clima_app/features/search/presentation/blocs/cubits/background_weather_cubit.dart';
import 'package:clima_app/features/search/presentation/blocs/cubits/theme_cubit.dart';
import 'package:clima_app/features/search/presentation/blocs/state/weather_state.dart';
import 'package:clima_app/features/search/presentation/blocs/weather_cubit.dart';
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
  late BackgroundWeatherCubit backgroundWeatherCubit;

  @override
  void initState() {
    super.initState();
    backgroundWeatherCubit = context.read<BackgroundWeatherCubit>();
  }

  @override
  Widget build(BuildContext context) {
    final themeCubit = context.watch<ThemeCubit>();
    final theme = Theme.of(context);

    return Scaffold(
      body: Container(
        color: backgroundWeatherCubit.state,
        child: Stack(
          children: [
            Column(
              children: [
                Expanded(
                  child: Container(
                    width: double.infinity,
                  ),
                ),
              ],
            ),
            Positioned(
                child: SafeArea(
                    child: SizedBox(
              width: MediaQuery.of(context).size.width,
              child: Padding(
                padding: const EdgeInsets.only(left: 16.0, right: 16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        BlocBuilder<WeatherCubit, WeatherState>(
                          builder: (context, state) {
                            if (state.city == null) {
                              return const SizedBox.shrink();
                            }
                            return Expanded(
                              flex: 1,
                              child: Text(
                                state.city ?? "",
                                style: theme.textTheme.bodyLarge,
                              ),
                            );
                          },
                        ),
                        IconButton(
                          icon: Icon(themeCubit.state.isDarkMode
                              ? Icons.nightlight
                              : Icons.sunny),
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
                    BlocBuilder<WeatherCubit, WeatherState>(
                      builder: (context, state) {
                        return HeaderWeatherWidget(
                            temp: state.currentWeather?.tempCelsiusText ?? "");
                      },
                    ),
                    const SizedBox(height: 20),
                    BlocBuilder<WeatherCubit, WeatherState>(
                      builder: (context, state) {
                        switch (state.fetchWeatherStatus) {
                          case FetchWeatherStatus.isLoading:
                            return const Center(
                                child: CircularProgressIndicator());
                          case FetchWeatherStatus.error:
                            return const Text("Ha ocurrido un error");
                          case FetchWeatherStatus.success:
                            return HourlyListWeatherWidget(
                                hourly: state.hourly);
                        }
                      },
                    ),
                    const SizedBox(height: 20),
                    BlocBuilder<WeatherCubit, WeatherState>(
                      builder: (context, state) {
                        switch (state.fetchWeatherStatus) {
                          case FetchWeatherStatus.isLoading:
                            return const Center(
                                child: CircularProgressIndicator());
                          case FetchWeatherStatus.error:
                            return const Text("Ha ocurrido un error");
                          case FetchWeatherStatus.success:
                            return DailyListWeatherWidget(daily: state.daily);
                        }
                      },
                    ),
                    const SizedBox(height: 20)
                  ],
                ),
              ),
            )))
          ],
        ),
      ),
    );
  }
}
