import 'package:clima_app/features/home/domain/entities/weather_response.dart';

class HomeWeatherData {
  final WeatherResponse weatherResponse;
  final String? cityName;

  HomeWeatherData({required this.weatherResponse, required this.cityName});
}
