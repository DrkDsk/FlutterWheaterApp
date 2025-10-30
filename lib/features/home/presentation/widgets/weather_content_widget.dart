import 'package:clima_app/core/extensions/color_extension.dart';
import 'package:clima_app/core/extensions/weather/current_weather_extension.dart';
import 'package:clima_app/core/shared/ui/widgets/lottie_viewer.dart';
import 'package:clima_app/features/home/domain/entities/city_weather_data.dart';
import 'package:clima_app/features/home/presentation/blocs/events/city_weather_event.dart';
import 'package:clima_app/features/home/presentation/blocs/states/city_weather_state.dart';
import 'package:clima_app/features/home/presentation/blocs/city_weather_bloc.dart';
import 'package:clima_app/features/home/presentation/widgets/daily_list_weather_widget.dart';
import 'package:clima_app/features/home/presentation/widgets/detail_weather_grid_widget.dart';
import 'package:clima_app/features/home/presentation/widgets/header_weather_widget.dart';
import 'package:clima_app/features/home/presentation/widgets/hourly_list_weather_widget.dart';
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
  late CityWeatherBloc _cityWeatherBloc;

  @override
  void initState() {
    super.initState();
    final latitude = widget.latitude;
    final longitude = widget.longitude;
    _cityWeatherBloc = context.read<CityWeatherBloc>();

    if (latitude != null && longitude != null) {
      _cityWeatherBloc.add(FetchWeatherEvent(
        latitude: latitude,
        longitude: longitude,
      ));
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CityWeatherBloc, CityWeatherState>(
        builder: (context, state) {
      final backgroundWeather = state.backgroundWeather;
      final backgroundColor = backgroundWeather.color;
      final lottiePath = backgroundWeather.lottiePath;

      final CityWeatherData? cityWeatherData = state.cityWeatherData;

      if (state.status != CityWeatherStatus.success ||
          cityWeatherData == null) {
        return Container(
          color: backgroundColor,
          child: const Center(
            child: CircularProgressIndicator(),
          ),
        );
      }

      final forecast = cityWeatherData.forecast;
      final currentWeather = forecast.current;
      final dailyResume = forecast.daily;
      final hourlyResume = forecast.hourly;
      final summaryDescription = dailyResume.first.summary ?? "";

      return Stack(
        children: [
          Positioned.fill(
            child: LottieViewer(
              path: lottiePath,
              backgroundColor: backgroundColor,
            ),
          ),
          SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 10),
                HeaderWeatherWidget(
                  city: cityWeatherData.city,
                  translatedWeather: cityWeatherData.translatedWeather,
                  temp: currentWeather.tempCelsiusText,
                ),
                const SizedBox(height: 10),
                const IAContentWidget(),
                const SizedBox(height: 10),
                if (summaryDescription.isNotEmpty) ...[
                  Container(
                    padding: const EdgeInsets.all(20),
                    height: 150,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(24),
                      color: backgroundColor.customOpacity(0.30),
                    ),
                    child: SingleChildScrollView(
                      child: Text(summaryDescription),
                    ),
                  ),
                  const SizedBox(height: 10),
                ],
                HourlyListWeatherWidget(
                  hourly: hourlyResume,
                  backgroundColor: backgroundColor,
                ),
                const SizedBox(height: 10),
                DailyListWeatherWidget(
                  daily: dailyResume,
                  backgroundColor: backgroundColor,
                ),
                const SizedBox(height: 10),
                DetailWeatherGridWidget(
                  weather: currentWeather,
                  backgroundColor: backgroundColor,
                ),
                const SizedBox(height: 10),
              ],
            ),
          )
        ],
      );
    });
  }
}
