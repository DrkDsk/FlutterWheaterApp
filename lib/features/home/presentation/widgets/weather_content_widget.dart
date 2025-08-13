import 'package:clima_app/features/home/domain/entities/weather_state_data.dart';
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
        _cityWeatherBloc
            .add(FetchWeatherEvent(latitude: latitude, longitude: longitude));
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8),
        child: BlocBuilder<CityWeatherBloc, CityWeatherState>(
          builder: (context, state) {
            if (state is FetchWeatherSuccessState) {
              final WeatherData weatherData = state.weatherData;

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
                    HourlyListWeatherWidget(hourly: weatherData.hourly),
                    const SizedBox(height: 20),
                    DailyListWeatherWidget(daily: weatherData.daily),
                    const SizedBox(height: 20),
                    Row(
                      children: [
                        Expanded(
                          child: SegmentWeatherWidget(
                              title: "Sensación térmica️",
                              emoji: "🌡",
                              value: weatherData
                                  .currentWeather.feelsLikeCelsiusText),
                        ),
                        const SizedBox(
                          width: 10,
                        ),
                        Expanded(
                          child: SegmentWeatherWidget(
                              title: "Humedad",
                              emoji: "💧",
                              value: "${weatherData.currentWeather.humidity}%"),
                        )
                      ],
                    ),
                    const SizedBox(height: 10),
                    Row(
                      children: [
                        Expanded(
                          child: SegmentWeatherWidget(
                              title: "Viento",
                              emoji: "💨",
                              value:
                                  weatherData.currentWeather.windDirectionText),
                        ),
                        const SizedBox(
                          width: 10,
                        ),
                        Expanded(
                          child: SegmentWeatherWidget(
                              title: "Índice UV:",
                              emoji: "☀️",
                              value: "${weatherData.currentWeather.uvi}"),
                        )
                      ],
                    ),
                  ],
                ),
              );
            }

            return const SizedBox.shrink();
          },
        ),
      ),
    );
  }
}

class SegmentWeatherWidget extends StatelessWidget {
  const SegmentWeatherWidget(
      {super.key, required this.title, required this.emoji, required this.value});

  final String title;
  final String value;
  final String emoji;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 180,
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
      decoration: BoxDecoration(
          color: Colors.grey.withOpacity(0.15),
          borderRadius: BorderRadius.circular(12)),
      child: DefaultTextStyle(
        style: const TextStyle(
          fontSize: 25,
          fontFamily: 'Outfit',
          fontWeight: FontWeight.w700
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(title),
            Text(emoji),
            Text(value)
          ],
        )
      ),
    );
  }
}
