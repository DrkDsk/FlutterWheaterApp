import 'package:clima_app/core/colors/weather_colors.dart';
import 'package:clima_app/features/favorites/presentation/widgets/city_results_content_widget.dart';
import 'package:clima_app/features/favorites/presentation/widgets/search_city_header.dart';
import 'package:clima_app/features/favorites/presentation/widgets/show_weather_bottom_sheet_widget.dart';
import 'package:clima_app/features/home/presentation/blocs/states/city_weather_state.dart';
import 'package:clima_app/features/home/presentation/blocs/city_weather_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class WeatherListFavorites extends StatelessWidget {
  const WeatherListFavorites({super.key});

  void _showWeatherBottomSheet(BuildContext context, {
    required String cityName,
    required double latitude,
    required double longitude,
  }) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (context) =>
        ShowWeatherBottomSheetWidget(
          cityName: cityName,
          latitude: latitude,
          longitude: longitude,
        ),
    );
  }

  void _onLoadWeather(BuildContext context, CityWeatherState state) {

    final latitude = state.latitude;
    final longitude = state.longitude;

    if (latitude == null || longitude == null || state.status != CityWeatherStatus.initial) {
      return ;
    }

    _showWeatherBottomSheet(
      context,
      cityName: state.cityName,
      latitude: latitude,
      longitude: longitude,
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocSelector<CityWeatherBloc, CityWeatherState, Color?>(
      selector: (state) {

        if (state.status == CityWeatherStatus.success) {
          return state.weatherData?.backgroundColor;
        }

        return WeatherColors.drizzleNight;
      },
      builder: (context, backgroundColor) {
        return BlocListener<CityWeatherBloc, CityWeatherState>(
          listener: (context, state) => _onLoadWeather(context, state),
          child: const Scaffold(
            backgroundColor: Colors.white10,
            body: SafeArea(
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(height: 20),
                    SearchCityHeader(),
                    SizedBox(height: 10),
                    Expanded(
                      child: CityResultsContentWidget(),
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
