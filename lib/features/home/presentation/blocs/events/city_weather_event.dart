abstract class CityWeatherEvent {
  const CityWeatherEvent();
}

class FetchWeatherEvent extends CityWeatherEvent {

  final double? latitude;
  final double? longitude;
  final int? cityId;

  const FetchWeatherEvent({this.latitude, this.longitude, this.cityId});
}

class CitySearchEvent extends CityWeatherEvent {
  final String query;

  const CitySearchEvent({required this.query});
}