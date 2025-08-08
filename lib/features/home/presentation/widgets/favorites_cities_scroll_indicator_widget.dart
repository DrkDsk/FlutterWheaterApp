import 'package:flutter/material.dart';

class FavoritesCitiesScrollIndicatorWidget extends StatelessWidget {
  const FavoritesCitiesScrollIndicatorWidget({
    super.key,
    required this.currentPage,
    required this.length
  });

  final int currentPage;
  final int length;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: length,
        itemBuilder: (context, index) {
          final isActive = currentPage == index;
          return AnimatedContainer(
              width: 10,
              height: 10,
              margin: const EdgeInsets.symmetric(horizontal: 4),
              duration: const Duration(milliseconds: 100),
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: isActive ? Colors.white : Colors.grey,
              )
          );
        }
    );
  }
}