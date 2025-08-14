import 'package:clima_app/features/favorites/domain/entities/favorite_location.dart';
import 'package:clima_app/features/favorites/presentation/blocs/favorite_bloc.dart';
import 'package:clima_app/features/favorites/presentation/blocs/favorite_state.dart';
import 'package:clima_app/features/favorites/presentation/widgets/slidable_favorite_weather_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SavedFavoriteCitiesListWidget extends StatefulWidget {
  const SavedFavoriteCitiesListWidget({super.key, required this.cities});

  final List<FavoriteLocation> cities;

  @override
  State<SavedFavoriteCitiesListWidget> createState() =>
      _SavedFavoriteCitiesListWidgetState();
}

class _SavedFavoriteCitiesListWidgetState
    extends State<SavedFavoriteCitiesListWidget>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(
        seconds: 2,
      )
    );

    _controller.forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<FavoriteBloc, FavoriteLocationsState>(
        builder: (context, state) {
      final citiesLength = widget.cities.length;

      return ListView.separated(
        itemCount: citiesLength,
        separatorBuilder: (context, index) {
          return const SizedBox(height: 14);
        },
        itemBuilder: (context, index) {
          final animation = Tween<Offset>(
            begin: const Offset(0, 0.2),
            end: Offset.zero,
          ).animate(
            CurvedAnimation(
              parent: _controller,
              curve: Interval(
                index / citiesLength,
                1.0,
                curve: Curves.easeOut,
              ),
            ),
          );

          final currentCity = widget.cities[index];

          return FadeTransition(
            opacity: _controller,
            child: SlideTransition(
              position: animation,
              child: SlidableFavoriteWeatherCard(
                  currentCity: currentCity, index: index),
            ),
          );
        },
      );
    });
  }
}
