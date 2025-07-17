import 'package:clima_app/features/home/domain/entities/translated/translated_weather.dart';

abstract class WeatherDescriptionRepository {
  Future<TranslatedWeather> getDescription(String code);
}