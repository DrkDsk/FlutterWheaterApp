abstract class FavoriteCityEvent {
  const FavoriteCityEvent();
}

class SearchFavoriteCityEvent extends FavoriteCityEvent {
  final String query;

  const SearchFavoriteCityEvent({required this.query});
}

class SaveFavoriteCityEvent extends FavoriteCityEvent {
  final String cityId;

  const SaveFavoriteCityEvent({required this.cityId});
}