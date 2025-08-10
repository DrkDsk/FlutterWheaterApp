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
        const Padding(
          padding: EdgeInsets.symmetric(vertical: 8.0),
          child: SearchCityWidget(),
        ),
      ],
    );
  }
}