import 'package:clima_app/features/city/presentation/blocs/city_bloc.dart';
import 'package:clima_app/features/city/presentation/blocs/city_state.dart';
import 'package:clima_app/features/favorites/presentation/widgets/city_search_results_list_widget.dart';
import 'package:clima_app/features/favorites/presentation/widgets/saved_favorite_cities_list_widget.dart';
import 'package:clima_app/features/favorites/presentation/widgets/search_city_header.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class WeatherListFavorites extends StatelessWidget {
  const WeatherListFavorites({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return SafeArea(
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

                    if (state is LoadingCityState) {
                      return const CircularProgressIndicator();
                    }

                    if (state is SuccessResultCity) {
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
    );
  }
}
