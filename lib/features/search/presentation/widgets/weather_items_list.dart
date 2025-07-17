import 'package:clima_app/features/search/presentation/blocs/weather_bloc.dart';
import 'package:clima_app/features/search/presentation/blocs/weather_state.dart';
import 'package:clima_app/features/search/presentation/extensions/current_weather_extension.dart';
import 'package:clima_app/features/search/presentation/widgets/daily_list_weather_widget.dart';
import 'package:clima_app/features/search/presentation/widgets/header_weather_widget.dart';
import 'package:clima_app/features/search/presentation/widgets/hourly_list_weather_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class WeatherItemsList extends StatelessWidget {
  const WeatherItemsList({
    super.key,
    required this.theme,
  });

  final ThemeData theme;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: PageView.builder(
          itemCount: 4,
          itemBuilder: (context, index) => Container(
            padding: const EdgeInsets.symmetric(horizontal: 4),
            width: MediaQuery.of(context).size.width,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(
                  height: 12,
                ),
                BlocBuilder<WeatherBloc, WeatherState>(
                  builder: (context, state) {
                    if (state is WeatherSuccessState) {
                      return Text(
                        state.city,
                        style: theme.textTheme.bodyLarge,
                      );
                    }
                    return const SizedBox.shrink();
                  },
                ),
                const SizedBox(
                  height: 8,
                ),
                const SizedBox(height: 10),
                BlocBuilder<WeatherBloc, WeatherState>(
                  builder: (context, state) {
                    if (state is WeatherSuccessState) {
                      return HeaderWeatherWidget(
                          translatedWeather:
                          state.translatedWeather,
                          temp: state
                              .currentWeather.tempCelsiusText);
                    }

                    return const SizedBox.shrink();
                  },
                ),
                const SizedBox(height: 20),
                BlocBuilder<WeatherBloc, WeatherState>(
                  builder: (context, state) {
                    if (state is WeatherSuccessState) {
                      return HourlyListWeatherWidget(
                          hourly: state.hourly);
                    }

                    return const SizedBox.shrink();
                  },
                ),
                const SizedBox(height: 20),
                BlocBuilder<WeatherBloc, WeatherState>(
                  builder: (context, state) {
                    if (state is WeatherSuccessState) {
                      return DailyListWeatherWidget(
                          daily: state.daily);
                    }

                    return const SizedBox.shrink();
                  },
                ),
                const SizedBox(height: 20)
              ],
            ),
          )
      ),
    );
  }
}