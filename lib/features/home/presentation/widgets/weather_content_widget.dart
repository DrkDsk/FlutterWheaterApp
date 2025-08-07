import 'package:clima_app/features/home/presentation/blocs/events/weather_event.dart';
import 'package:clima_app/features/home/presentation/blocs/states/weather_state.dart';
import 'package:clima_app/features/home/presentation/blocs/weather_bloc.dart';
import 'package:clima_app/features/home/presentation/blocs/states/weather_success_state.dart';
import 'package:clima_app/core/extensions/weather/current_weather_extension.dart';
import 'package:clima_app/features/home/presentation/widgets/daily_list_weather_widget.dart';
import 'package:clima_app/features/home/presentation/widgets/header_weather_widget.dart';
import 'package:clima_app/features/home/presentation/widgets/hourly_list_weather_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class WeatherContentWidget extends StatefulWidget {
  const WeatherContentWidget({
    super.key,
    this.latitude,
    this.longitude
  });

  final double? latitude;
  final double? longitude;

  @override
  State<WeatherContentWidget> createState() => _WeatherContentWidgetState();
}

class _WeatherContentWidgetState extends State<WeatherContentWidget> {
  @override
  void initState() {
    super.initState();
    final latitude = widget.latitude;
    final longitude = widget.longitude;

    if (latitude != null && longitude != null) {
      final WeatherBloc weatherBloc = context.read<WeatherBloc>();
      Future.microtask(() {
        weatherBloc.add(LoadCurrentWeatherForCityEvent(latitude: latitude, longitude: longitude));
      });
    }

  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 4),
      width: MediaQuery.of(context).size.width,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 10),
          BlocBuilder<WeatherBloc, WeatherState>(
            builder: (context, state) {
              if (state is WeatherSuccessState) {
                return HeaderWeatherWidget(
                  city: state.weatherData.city,
                  translatedWeather:
                  state.weatherData.translatedWeather,
                  temp: state.weatherData.currentWeather.tempCelsiusText
                );
              }

              return const SizedBox.shrink();
            },
          ),
          BlocBuilder<WeatherBloc, WeatherState>(
            builder: (context, state) {
              if (state is WeatherSuccessState) {
                return HourlyListWeatherWidget(
                  hourly: state.weatherData.hourly
                );
              }

              return const SizedBox.shrink();
            },
          ),
          const SizedBox(height: 20),
          BlocBuilder<WeatherBloc, WeatherState>(
            builder: (context, state) {
              if (state is WeatherSuccessState) {
                return DailyListWeatherWidget(
                  daily: state.weatherData.daily
                );
              }

              return const SizedBox.shrink();
            },
          ),
          const SizedBox(height: 20)
        ],
      ),
    );
  }
}
