abstract class CityEvent {
  const CityEvent();
}

class SearchCityEvent extends CityEvent {
  final String query;

  const SearchCityEvent({required this.query});
}

class SaveFavoriteCityEvent extends CityEvent {
  final String cityId;

  const SaveFavoriteCityEvent({required this.cityId});
}