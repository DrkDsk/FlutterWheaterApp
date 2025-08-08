import 'package:clima_app/features/favorites/presentation/blocs/favorite_bloc.dart';
import 'package:clima_app/features/favorites/presentation/blocs/favorite_state.dart';
import 'package:clima_app/features/home/presentation/widgets/favorites_cities_scroll_indicator_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class FavoritesCitiesScrollIndicatorBuilder extends StatelessWidget {
  const FavoritesCitiesScrollIndicatorBuilder({
    super.key,
    required this.currentPage,
  });

  final int currentPage;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<FavoriteBloc, FavoriteState>(
      buildWhen: (previous, current) => current is FavoritesCitiesState,
      builder: (context, state) {
        if (state is FavoritesCitiesState) {
          return FavoritesCitiesScrollIndicatorWidget(
              currentPage: currentPage,
              length: state.cities.length
          );
        }
        return const SizedBox.shrink();
      },
    );
  }
}