import 'package:clima_app/features/home/domain/entities/translated/translated_weather.dart';
import 'package:equatable/equatable.dart';

import 'forecast.dart';

class CityWeatherData with EquatableMixin {
  final Forecast forecast;
  final String city;
  final TranslatedWeather translatedWeather;

  CityWeatherData({
    required this.forecast,
    required this.city,
    required this.translatedWeather,
  });

  @override
  List<Object?> get props => [forecast, city, translatedWeather];
}
