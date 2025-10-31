import 'package:clima_app/features/home/domain/entities/translated/translated_weather.dart';
import 'package:equatable/equatable.dart';

import 'forecast.dart';

class CityWeatherData with EquatableMixin {
  final Forecast forecast;
  final TranslatedWeather translatedWeather;

  CityWeatherData({
    required this.forecast,
    required this.translatedWeather,
  });

  @override
  List<Object?> get props => [forecast, translatedWeather];
}
