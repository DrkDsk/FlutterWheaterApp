abstract class WeatherEvent {
  const WeatherEvent();
}

class CurrentWeatherEvent extends WeatherEvent {

  final double? latitude;
  final double? longitude;

  const CurrentWeatherEvent({this.latitude, this.longitude});
}

class GetSelectedCityEvent extends WeatherEvent {

  final double latitude;
  final double longitude;

  const GetSelectedCityEvent({required this.latitude, required this.longitude});

}