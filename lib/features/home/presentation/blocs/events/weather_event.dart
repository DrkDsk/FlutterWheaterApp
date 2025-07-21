abstract class WeatherEvent {
  const WeatherEvent();
}

class CurrentWeatherEvent extends WeatherEvent {

  final double? latitude;
  final double? longitude;
  final int? cityId;

  const CurrentWeatherEvent({this.latitude, this.longitude, this.cityId});
}

class GetSelectedCityEvent extends WeatherEvent {

  final double latitude;
  final double longitude;

  const GetSelectedCityEvent({required this.latitude, required this.longitude});

}