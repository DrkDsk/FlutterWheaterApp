import 'package:clima_app/features/home/presentation/blocs/events/city_weather_event.dart';
import 'package:clima_app/features/home/presentation/blocs/states/city_weather_state.dart';
import 'package:clima_app/features/home/presentation/blocs/city_weather_bloc.dart';
import 'package:clima_app/core/extensions/weather/current_weather_extension.dart';
import 'package:clima_app/features/home/presentation/widgets/daily_list_weather_widget.dart';
import 'package:clima_app/features/home/presentation/widgets/header_weather_widget.dart';
import 'package:clima_app/features/home/presentation/widgets/hourly_list_weather_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class WeatherContentWidget extends StatefulWidget {
  const WeatherContentWidget({super.key, this.latitude, this.longitude});

  final double? latitude;
  final double? longitude;

  @override
  State<WeatherContentWidget> createState() => _WeatherContentWidgetState();
}

class _WeatherContentWidgetState extends State<WeatherContentWidget> {
  late CityWeatherBloc _cityWeatherBloc;
  @override
  void initState() {
    super.initState();
    final latitude = widget.latitude;
    final longitude = widget.longitude;

    if (latitude != null && longitude != null) {
      _cityWeatherBloc = context.read<CityWeatherBloc>();
      Future.microtask(() {
        _cityWeatherBloc.add(FetchWeatherEvent(
            latitude: latitude, longitude: longitude));
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CityWeatherBloc, CityWeatherState>(
      builder: (context, state) {
        if (state is WeatherFetchSuccessState) {
          return SafeArea(
            child: BlocBuilder<CityWeatherBloc, CityWeatherState>(
              buildWhen: (previous, current) => current is WeatherFetchSuccessState,
              builder: (context, state) {
                if (state is WeatherFetchSuccessState) {
                  return Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const SizedBox(height: 10),
                        HeaderWeatherWidget(
                          city: state.weatherData.city,
                          translatedWeather: state.weatherData.translatedWeather,
                          temp: state.weatherData.currentWeather.tempCelsiusText,
                        ),
                        HourlyListWeatherWidget(hourly: state.weatherData.hourly),
                        const SizedBox(height: 20),
                        DailyListWeatherWidget(daily: state.weatherData.daily),
                        const SizedBox(height: 20),
                      ],
                    ),
                  );
                }
                return const SizedBox.shrink();
              },
            ),
          );
        }
        return const SizedBox.shrink();
      },
    );
  }
}
