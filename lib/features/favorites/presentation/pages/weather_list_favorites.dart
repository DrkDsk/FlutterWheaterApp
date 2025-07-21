import 'package:clima_app/features/city/presentation/blocs/city_bloc.dart';
import 'package:clima_app/features/city/presentation/blocs/city_state.dart';
import 'package:clima_app/features/favorites/presentation/widgets/city_search_results_list_widget.dart';
import 'package:clima_app/features/favorites/presentation/widgets/saved_favorite_cities_list_widget.dart';
import 'package:clima_app/features/favorites/presentation/widgets/search_city_header.dart';
import 'package:clima_app/features/home/presentation/blocs/states/weather_loading_state.dart';
import 'package:clima_app/features/home/presentation/blocs/states/weather_state.dart';
import 'package:clima_app/features/home/presentation/blocs/states/weather_success_state.dart';
import 'package:clima_app/features/home/presentation/blocs/weather_bloc.dart';
import 'package:clima_app/features/home/presentation/pages/home_weather_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class WeatherListFavorites extends StatelessWidget {
  const WeatherListFavorites({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return BlocListener<WeatherBloc, WeatherState>(
      listener: (context, state) {
        if (state is WeatherLoadingState) {
          showDialog(
              barrierColor: Colors.white12,
              context: context,
              builder: (context) =>
                  const Center(child: CircularProgressIndicator()));
        }

        if (state is WeatherSuccessState) {
          Navigator.of(context).pushAndRemoveUntil(
            MaterialPageRoute(builder: (context) => const HomeWeatherPage()),
            (route) => false,
          );
        }
      },
      child: SafeArea(
        child: Scaffold(
          backgroundColor: Colors.white10,
          body: Container(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 20),
                const SearchCityHeader(),
                const SizedBox(height: 20),
                BlocBuilder<CityBloc, CityState>(
                  builder: (context, state) {
                    if (state is SuccessSearchCity) {
                      final result = state.data;
                      return Expanded(
                        child: CitySearchResultsListWidget(
                          result: result
                        ),
                      );
                    }

                    if (state is SearchErrorCityState) {
                      return Text(state.message,
                          style: theme.textTheme.bodyMedium);
                    }

                    return Expanded(
                      child: SavedFavoriteCitiesListWidget(theme: theme),
                    );
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
