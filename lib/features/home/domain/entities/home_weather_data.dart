import 'package:clima_app/features/home/domain/entities/forecast.dart';

class HomeWeatherData {
  final Forecast weatherResponse;
  final String? cityName;

  HomeWeatherData({required this.weatherResponse, required this.cityName});
}
