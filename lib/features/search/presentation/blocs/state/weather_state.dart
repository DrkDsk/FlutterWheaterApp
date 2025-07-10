import 'package:clima_app/features/search/domain/entities/current.dart';
import 'package:clima_app/features/search/domain/entities/daily.dart';
import 'package:clima_app/features/search/domain/entities/hourly.dart';
import 'package:clima_app/features/search/domain/entities/translated/translated_weather.dart';

abstract class WeatherState {
  const WeatherState();
}

class WeatherLoadingState extends WeatherState {
  const WeatherLoadingState();
}

class WeatherSuccessState extends WeatherState {

  final Current currentWeather;
  final TranslatedWeather translatedWeather;
  final List<Hourly> hourly;
  final List<Daily> daily;
  final String city;

  WeatherSuccessState({
    required this.currentWeather,
    required this.translatedWeather,
    required this.hourly,
    required this.daily,
    required this.city,
  });

  WeatherState copyWith({
    Current? currentWeather,
    TranslatedWeather? translatedWeather,
    List<Hourly>? hourly,
    List<Daily>? daily,
    String? city,
  }) {
    return WeatherSuccessState(
      currentWeather: currentWeather ?? this.currentWeather,
      translatedWeather: translatedWeather ?? this.translatedWeather,
      hourly: hourly ?? this.hourly,
      daily: daily ?? this.daily,
      city: city ?? this.city,
    );
  }
}

class WeatherErrorState extends WeatherState {

  final String message;

  WeatherErrorState({required this.message});
}
