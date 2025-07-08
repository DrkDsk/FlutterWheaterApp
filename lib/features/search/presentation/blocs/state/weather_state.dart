import 'package:clima_app/features/search/domain/entities/daily.dart';
import 'package:clima_app/features/search/domain/entities/hourly.dart';

enum FetchWeatherStatus {
  isLoading,
  error,
  success
}

class WeatherState {

  final double temp;
  final int humidity;
  final FetchWeatherStatus fetchWeatherStatus;
  final List<Hourly> hourly;
  final List<Daily> daily;

  WeatherState({
    this.temp = 0,
    this.humidity = 0,
    this.fetchWeatherStatus = FetchWeatherStatus.isLoading,
    required this.hourly,
    required this.daily
  });

  WeatherState copyWith({
    double? temp,
    int? humidity,
    FetchWeatherStatus? fetchWeatherStatus,
    List<Hourly>? hourly,
    List<Daily>? daily,
  }) {
    return WeatherState(
      temp: temp ?? this.temp,
      humidity: humidity ?? this.humidity,
      fetchWeatherStatus: fetchWeatherStatus ?? this.fetchWeatherStatus,
      hourly: hourly ?? this.hourly,
      daily: daily ?? this.daily,
    );
  }
}