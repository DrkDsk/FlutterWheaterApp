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

class GetSelectedCityEvent extends CityEvent {

  final double latitude;
  final double longitude;

  const GetSelectedCityEvent({required this.latitude, required this.longitude});

}