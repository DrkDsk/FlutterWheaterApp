import 'package:clima_app/features/home/domain/entities/weather_state_data.dart';
import 'package:clima_app/features/home/presentation/blocs/events/city_weather_event.dart';
import 'package:clima_app/features/home/presentation/blocs/states/city_weather_state.dart';
import 'package:clima_app/features/home/presentation/blocs/city_weather_bloc.dart';
import 'package:clima_app/core/extensions/weather/current_weather_extension.dart';
import 'package:clima_app/features/home/presentation/widgets/daily_list_weather_widget.dart';
import 'package:clima_app/features/home/presentation/widgets/detail_weather_grid_widget.dart';
import 'package:clima_app/features/home/presentation/widgets/header_weather_widget.dart';
import 'package:clima_app/features/home/presentation/widgets/hourly_list_weather_widget.dart';
import 'package:clima_app/features/ia/ui/blocs/ia_cubit.dart';
import 'package:clima_app/features/ia/ui/blocs/widgets/ia_content_widget.dart';
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
  late IACubit _iaCubit;

  @override
  void initState() {
    super.initState();
    final latitude = widget.latitude;
    final longitude = widget.longitude;
    _iaCubit = context.read<IACubit>();

    if (latitude != null && longitude != null) {
      context.read<CityWeatherBloc>().add(FetchWeatherEvent(latitude: latitude, longitude: longitude));
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8),
        child: BlocConsumer<CityWeatherBloc, CityWeatherState>(
          listener: (context, state) {
            if (state.status == CityWeatherStatus.success) {
              /*final WeatherData? weatherData = state.weatherData;

              if (weatherData == null) return ;

              _iaCubit.getRecommendation(weatherData: weatherData);*/
            }
          },
          builder: (context, state) {
            if (state.status == CityWeatherStatus.success) {
              final WeatherData? weatherData = state.weatherData;

              if (weatherData == null) {
                return const SizedBox.shrink();
              }

              return SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: 10),
                    HeaderWeatherWidget(
                      city: weatherData.city,
                      translatedWeather: weatherData.translatedWeather,
                      temp: weatherData.currentWeather.tempCelsiusText,
                    ),
                    const SizedBox(height: 10),
                    const IAContentWidget(),
                    const SizedBox(height: 10),
                    HourlyListWeatherWidget(hourly: weatherData.hourly),
                    const SizedBox(height: 10),
                    DailyListWeatherWidget(daily: weatherData.daily),
                    const SizedBox(height: 10),
                    DetailWeatherGridWidget(weatherData: weatherData)
                  ],
                ),
              );
            }

            return const Center(child: CircularProgressIndicator());
          },
        ),
      ),
    );
  }
}
