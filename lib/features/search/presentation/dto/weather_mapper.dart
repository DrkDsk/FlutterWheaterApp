import 'package:clima_app/features/search/domain/entities/translated/translated_weather.dart';
import 'package:clima_app/features/search/domain/entities/weather.dart';
import 'package:clima_app/features/search/domain/repositories/weather_description_repository.dart';

class WeatherMapper {
  final WeatherDescriptionRepository _repository;

  WeatherMapper(this._repository);

  Future<TranslatedWeather> map(Weather weather) async {
    final translation = await _repository.getDescription(weather.id.toString());

    return translation.copyWith(
      icon: weather.icon,
      main: weather.main
    );
  }
}
