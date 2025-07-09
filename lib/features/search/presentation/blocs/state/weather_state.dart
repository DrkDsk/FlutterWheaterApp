import 'package:clima_app/features/search/domain/entities/current.dart';
import 'package:clima_app/features/search/domain/entities/daily.dart';
import 'package:clima_app/features/search/domain/entities/hourly.dart';
import 'package:clima_app/features/search/domain/entities/translated/translated_weather.dart';

enum FetchWeatherStatus {
  isLoading,
  error,
  success
}

class WeatherState {

  final Current? currentWeather;
  final TranslatedWeather? translatedWeather;
  final FetchWeatherStatus fetchWeatherStatus;
  final List<Hourly> hourly;
  final List<Daily> daily;
  final String city;

  WeatherState({
    this.currentWeather,
    this.translatedWeather,
    this.fetchWeatherStatus = FetchWeatherStatus.isLoading,
    required this.hourly,
    required this.daily,
    this.city = "",
  });

  WeatherState copyWith({
    Current? currentWeather,
    TranslatedWeather? translatedWeather,
    FetchWeatherStatus? fetchWeatherStatus,
    List<Hourly>? hourly,
    List<Daily>? daily,
    String? city,
  }) {
    return WeatherState(
      currentWeather: currentWeather ?? this.currentWeather,
      translatedWeather: translatedWeather ?? this.translatedWeather,
      fetchWeatherStatus: fetchWeatherStatus ?? this.fetchWeatherStatus,
      hourly: hourly ?? this.hourly,
      daily: daily ?? this.daily,
      city: city ?? this.city,
    );
  }
}