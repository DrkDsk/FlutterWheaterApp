import 'package:clima_app/features/search/domain/entities/current.dart';
import 'package:clima_app/features/search/domain/entities/daily.dart';
import 'package:clima_app/features/search/domain/entities/hourly.dart';

enum FetchWeatherStatus {
  isLoading,
  error,
  success
}

class WeatherState {

  final Current? currentWeather;
  final FetchWeatherStatus fetchWeatherStatus;
  final List<Hourly> hourly;
  final List<Daily> daily;

  WeatherState({
    this.currentWeather,
    this.fetchWeatherStatus = FetchWeatherStatus.isLoading,
    required this.hourly,
    required this.daily
  });

  WeatherState copyWith({
    Current? currentWeather,
    int? humidity,
    FetchWeatherStatus? fetchWeatherStatus,
    List<Hourly>? hourly,
    List<Daily>? daily,
  }) {
    return WeatherState(
      currentWeather: currentWeather ?? this.currentWeather,
      fetchWeatherStatus: fetchWeatherStatus ?? this.fetchWeatherStatus,
      hourly: hourly ?? this.hourly,
      daily: daily ?? this.daily,
    );
  }
}