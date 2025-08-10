abstract class CityWeatherEvent {
  const CityWeatherEvent();
}

class LoadCurrentWeatherForCityEvent extends CityWeatherEvent {

  final double? latitude;
  final double? longitude;
  final int? cityId;

  const LoadCurrentWeatherForCityEvent({this.latitude, this.longitude, this.cityId});
}

class SearchCityEvent extends CityWeatherEvent {
  final String query;

  const SearchCityEvent({required this.query});
}

class GetSelectedCityEvent extends CityWeatherEvent {
  final double latitude;
  final double longitude;

  const GetSelectedCityEvent({required this.latitude, required this.longitude});
}