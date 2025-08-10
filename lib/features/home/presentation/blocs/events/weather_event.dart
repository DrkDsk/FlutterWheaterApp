abstract class WeatherEvent {
  const WeatherEvent();
}

class LoadCurrentWeatherForCityEvent extends WeatherEvent {

  final double? latitude;
  final double? longitude;
  final int? cityId;

  const LoadCurrentWeatherForCityEvent({this.latitude, this.longitude, this.cityId});
}

class SearchCityEvent extends WeatherEvent {
  final String query;

  const SearchCityEvent({required this.query});
}

class GetSelectedCityEvent extends WeatherEvent {
  final double latitude;
  final double longitude;

  const GetSelectedCityEvent({required this.latitude, required this.longitude});
}