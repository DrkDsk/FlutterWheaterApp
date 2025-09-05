import 'package:clima_app/features/favorites/presentation/fetch/cubits/favorite_fetch_cubit.dart';
import 'package:clima_app/features/favorites/presentation/fetch/cubits/favorite_fetch_state.dart';
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
    return BlocBuilder<FavoriteFetchCubit, FavoriteFetchState>(
      builder: (context, state) {
        return FavoritesCitiesScrollIndicatorWidget(
            currentPage: currentPage, length: state.items.length);
      },
    );
  }
}
