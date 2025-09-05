import 'package:clima_app/core/extensions/color_extension.dart';
import 'package:clima_app/features/home/presentation/widgets/favorites_cities_scroll_indicator_builder.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

class BottomAppBarWidget extends StatelessWidget {
  const BottomAppBarWidget(
      {super.key,
      required this.currentPage,
      required this.navigateToFavorites,
      this.backgroundColor});

  final Color? backgroundColor;
  final int currentPage;
  final void Function()? navigateToFavorites;

  @override
  Widget build(BuildContext context) {
    return BottomAppBar(
      color: backgroundColor,
      clipBehavior: Clip.antiAlias,
      child: Row(
        children: [
          const Expanded(child: SizedBox.shrink()),
          Expanded(
            child:
                FavoritesCitiesScrollIndicatorBuilder(currentPage: currentPage),
          ),
          IconButton(
            color: Colors.white.customOpacity(0.8),
            icon: const Icon(CupertinoIcons.line_horizontal_3),
            onPressed: navigateToFavorites,
          ),
        ],
      ),
    );
  }
}
