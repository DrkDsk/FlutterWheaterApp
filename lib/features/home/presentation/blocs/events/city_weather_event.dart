abstract class CityWeatherEvent {
  const CityWeatherEvent();
}

class FetchWeatherEvent extends CityWeatherEvent {
  final double? latitude;
  final double? longitude;

  const FetchWeatherEvent({this.latitude, this.longitude});
}

class LoadWeatherModalEvent extends CityWeatherEvent {
  final double latitude;
  final double longitude;
  final String cityName;

  const LoadWeatherModalEvent(
      {required this.latitude,
      required this.longitude,
      required this.cityName});
}

class CitySearchEvent extends CityWeatherEvent {
  final String query;

  const CitySearchEvent({required this.query});
}
