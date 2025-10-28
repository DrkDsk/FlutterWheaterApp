import 'package:clima_app/core/constants/weather_constants.dart';
import 'package:clima_app/core/extensions/color_extension.dart';
import 'package:clima_app/features/city/domain/entities/city_location_entity.dart';
import 'package:clima_app/features/favorites/presentation/fetch/cubits/favorite_cubit.dart';
import 'package:clima_app/features/favorites/presentation/fetch/cubits/favorite_fetch_state.dart';
import 'package:clima_app/features/home/presentation/blocs/home_page_navigation_cubit.dart';
import 'package:clima_app/features/home/presentation/widgets/weather_content_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class FavoritesPageBuilder extends StatefulWidget {
  const FavoritesPageBuilder({super.key, required this.pageController});

  final PageController pageController;

  @override
  State<FavoritesPageBuilder> createState() => _FavoritesPageBuilderState();
}

class _FavoritesPageBuilderState extends State<FavoritesPageBuilder> {
  late final HomePageNavigationCubit homePageNavigationCubit;

  @override
  @override
  void initState() {
    super.initState();
    homePageNavigationCubit = BlocProvider.of<HomePageNavigationCubit>(context);
  }

  @override
  Widget build(BuildContext context) {
    return BlocSelector<FavoriteCubit, FavoriteFetchState, List<CityLocation>>(
      selector: (state) => state.cities,
      builder: (context, cities) {
        if (cities.isEmpty) {
          return Container(
            color: WeatherColorConstants.cloudNight.customOpacity(0.8),
          );
        }

        return PageView.builder(
          controller: widget.pageController,
          itemCount: cities.length,
          onPageChanged: homePageNavigationCubit.updatePageIndex,
          itemBuilder: (context, index) {
            final city = cities[index];

            return WeatherContentWidget(
              latitude: city.latitude,
              longitude: city.longitude,
            );
          },
        );
      },
    );
  }
}
