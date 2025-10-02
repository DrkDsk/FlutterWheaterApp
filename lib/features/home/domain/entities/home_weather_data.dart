import 'package:clima_app/features/home/domain/entities/forecast.dart';
import 'package:clima_app/features/home/domain/entities/translated/translated_weather.dart';

class HomeWeatherData {
  final Forecast forecast;
  final String cityName;
  final TranslatedWeather translatedWeather;

  HomeWeatherData(
      {required this.forecast,
      required this.cityName,
      required this.translatedWeather});
}
