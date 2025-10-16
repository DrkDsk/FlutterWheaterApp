import 'package:clima_app/features/favorites/presentation/fetch/cubits/favorite_fetch_cubit.dart';
import 'package:clima_app/features/favorites/presentation/fetch/cubits/favorite_fetch_state.dart';
import 'package:clima_app/features/home/presentation/blocs/home_page_navigation_cubit.dart';
import 'package:clima_app/features/home/presentation/widgets/weather_content_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class FavoritesPageBuilder extends StatefulWidget {
  const FavoritesPageBuilder({super.key, required this.initialPage});

  final int initialPage;

  @override
  State<FavoritesPageBuilder> createState() => _FavoritesPageBuilderState();
}

class _FavoritesPageBuilderState extends State<FavoritesPageBuilder> {
  late final PageController pageController;
  late final HomePageNavigationCubit homePageNavigationCubit;

  @override
  @override
  void initState() {
    super.initState();
    pageController = PageController(initialPage: widget.initialPage);
    homePageNavigationCubit = BlocProvider.of<HomePageNavigationCubit>(context);
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<FavoriteFetchCubit, FavoriteFetchState>(
      builder: (context, state) {
        final cities = state.cities;

        if (cities.isEmpty) {
          return const Center(child: Text("No tienes ciudades guardadas."));
        }

        return PageView.builder(
          controller: pageController,
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
