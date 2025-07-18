import 'package:clima_app/features/favorites/presentation/blocs/favorite_city_bloc.dart';
import 'package:clima_app/features/favorites/presentation/blocs/favorite_city_event.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SearchCityWidget extends StatelessWidget {
  const SearchCityWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return CupertinoTextField(
      onChanged: (value) => context
          .read<FavoriteCityBloc>()
          .add(SearchFavoriteCityEvent(query: value)),
      prefix: Padding(
        padding: const EdgeInsets.only(left: 8),
        child: Icon(
          CupertinoIcons.search,
          color: CupertinoColors.systemGrey.withOpacity(0.5),
        ),
      ),
      suffix: Padding(
        padding: const EdgeInsets.only(right: 8),
        child: Icon(
          CupertinoIcons.mic,
          color: CupertinoColors.systemGrey.withOpacity(0.5),
        ),
      ),
      decoration: BoxDecoration(
          color: CupertinoColors.systemGrey.withOpacity(0.5),
          borderRadius: BorderRadius.circular(12)),
      padding: const EdgeInsets.symmetric(
          horizontal: 10, vertical: 10),
      placeholder: 'Search for a city or a airport',
    );
  }
}