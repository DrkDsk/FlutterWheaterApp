abstract class CityWeatherEvent {
  const CityWeatherEvent();
}

class FetchWeatherEvent extends CityWeatherEvent {
  final double? latitude;
  final double? longitude;

  const FetchWeatherEvent({this.latitude, this.longitude});
}

class CitySearchEvent extends CityWeatherEvent {
  final String query;

  const CitySearchEvent({required this.query});
}
