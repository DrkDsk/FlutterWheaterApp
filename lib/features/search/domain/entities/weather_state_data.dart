import 'package:clima_app/features/search/domain/entities/current.dart';
import 'package:clima_app/features/search/domain/entities/daily.dart';
import 'package:clima_app/features/search/domain/entities/hourly.dart';
import 'package:clima_app/features/search/domain/entities/translated/translated_weather.dart';

class WeatherStateData {
  final Current currentWeather;
  final TranslatedWeather translatedWeather;
  final List<Hourly> hourly;
  final List<Daily> daily;
  final String city;

  WeatherStateData({
    required this.currentWeather,
    required this.translatedWeather,
    required this.hourly,
    required this.daily,
    required this.city,
  });
}