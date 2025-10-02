import 'package:clima_app/core/extensions/weather/current_weather_extension.dart';
import 'package:clima_app/features/favorites/presentation/widgets/city_results_content_widget.dart';
import 'package:clima_app/features/favorites/presentation/widgets/search_city_header.dart';
import 'package:clima_app/features/home/presentation/blocs/states/city_weather_state.dart';
import 'package:clima_app/features/home/presentation/blocs/city_weather_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class WeatherListFavorites extends StatelessWidget {
  const WeatherListFavorites({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocSelector<CityWeatherBloc, CityWeatherState, Color>(
      selector: (state) {
        return state.backgroundColor;
      },
      builder: (context, backgroundColor) {
        return const Scaffold(
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
        );
      },
    );
  }
}
