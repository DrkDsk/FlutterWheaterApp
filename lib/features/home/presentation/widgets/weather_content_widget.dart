import 'package:clima_app/features/home/presentation/blocs/cubits/background_weather_cubit.dart';
import 'package:clima_app/features/home/presentation/blocs/events/weather_event.dart';
import 'package:clima_app/features/home/presentation/blocs/states/weather_state.dart';
import 'package:clima_app/features/home/presentation/blocs/weather_bloc.dart';
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

  late WeatherBloc _weatherBloc;
  late BackgroundWeatherCubit _backgroundWeatherCubit;

  @override
  void initState() {
    super.initState();
    final latitude = widget.latitude;
    final longitude = widget.longitude;

    if (latitude != null && longitude != null) {
      _weatherBloc = context.read<WeatherBloc>();
      _backgroundWeatherCubit = context.read<BackgroundWeatherCubit>();
      Future.microtask(() {
        _weatherBloc.add(LoadCurrentWeatherForCityEvent(
            latitude: latitude, longitude: longitude));
      });
    }
  }

  void _onWeatherUpdated(BuildContext context, WeatherState state) {
    if (state is WeatherSuccessState) {
      _backgroundWeatherCubit.updateFromWeatherData(weatherStateData: state.weatherData);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 4),
      width: MediaQuery.of(context).size.width,
      child: BlocConsumer<WeatherBloc, WeatherState>(
        listener: _onWeatherUpdated,
        builder: (context, state) {
          if (state is WeatherSuccessState) {
            return Column(
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
            );
          }

          return const SizedBox.shrink();
        },
      ),
    );
  }
}
