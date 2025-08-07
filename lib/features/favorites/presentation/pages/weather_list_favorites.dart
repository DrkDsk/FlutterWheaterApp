import 'package:clima_app/core/router/app_router.dart';
import 'package:clima_app/features/favorites/presentation/widgets/city_results_content_widget.dart';
import 'package:clima_app/features/favorites/presentation/widgets/search_city_header.dart';
import 'package:clima_app/features/favorites/presentation/widgets/show_weather_bottom_sheet_widget.dart';
import 'package:clima_app/features/home/presentation/blocs/states/weather_state.dart';
import 'package:clima_app/features/home/presentation/blocs/weather_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class WeatherListFavorites extends StatelessWidget {
  const WeatherListFavorites({super.key});

  @override
  Widget build(BuildContext context) {

    return BlocListener<WeatherBloc, WeatherState>(
      listener: (context, state) {
        if (state is WeatherLoadingState) {
          showDialog(
              context: context,
              builder: (context) =>
                  const Center(child: CircularProgressIndicator()));
        }

        if (state is WeatherSuccessState) {
          final String cityName = state.weatherData.city;
          final double? latitude = state.weatherData.latitude;
          final double? longitude = state.weatherData.longitude;

          AppRouter.of(context).pop();

          if (latitude != null && longitude != null) {
            showModalBottomSheet(
              context: context,
              isScrollControlled: true,
              builder: (context) => ShowWeatherBottomSheetWidget(
                cityName: cityName,
                latitude: latitude,
                longitude: longitude
              ),
            );
          }
        }
      },
      child: SafeArea(
        child: Scaffold(
          backgroundColor: Colors.white10,
          body: Container(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: const Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: 20),
                SearchCityHeader(),
                SizedBox(height: 20),
                Expanded(
                  child: CityResultsContentWidget(),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
