import 'package:clima_app/features/favorites/presentation/widgets/search_city_widget.dart';
import 'package:flutter/material.dart';

class SearchCityHeader extends StatelessWidget {
  const SearchCityHeader({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text("Weather", style: theme.textTheme.titleSmall),
        const SizedBox(height: 10),
        const SearchCityWidget(),
        const SizedBox(height: 10)
      ],
    );
  }
}