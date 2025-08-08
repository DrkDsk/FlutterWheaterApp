import 'package:clima_app/features/home/presentation/blocs/cubits/background_weather_cubit.dart';
import 'package:clima_app/features/home/presentation/widgets/favorites_cities_scroll_indicator_builder.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class BottomAppBarWidget extends StatelessWidget {
  const BottomAppBarWidget({
    super.key,
    required this.currentPage,
    required this.navigateToFavorites
  });

  final int currentPage;
  final void Function()? navigateToFavorites;

  @override
  Widget build(BuildContext context) {
    final backgroundWeatherCubit = context.watch<BackgroundWeatherCubit>();

    return BottomAppBar(
      color: backgroundWeatherCubit.state,
      clipBehavior: Clip.antiAlias,
      child: Row(
        children: [
          const Expanded(child: SizedBox.shrink()),
          Expanded(
            child: FavoritesCitiesScrollIndicatorBuilder(currentPage: currentPage),
          ),
          IconButton(
            color: Colors.white.withOpacity(0.8),
            icon: const Icon(CupertinoIcons.line_horizontal_3),
            onPressed: () => navigateToFavorites,
          ),
        ],
      ),
    );
  }
}