abstract class WeatherEvent {
  const WeatherEvent();
}

class LoadCurrentWeatherForCityEvent extends WeatherEvent {

  final double? latitude;
  final double? longitude;
  final int? cityId;

  const LoadCurrentWeatherForCityEvent({this.latitude, this.longitude, this.cityId});
}