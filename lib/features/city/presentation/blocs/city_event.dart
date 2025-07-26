abstract class CityEvent {
  const CityEvent();
}

class SearchCityEvent extends CityEvent {
  final String query;

  const SearchCityEvent({required this.query});
}

class GetSelectedCityEvent extends CityEvent {
  final double latitude;
  final double longitude;

  const GetSelectedCityEvent({required this.latitude, required this.longitude});
}
