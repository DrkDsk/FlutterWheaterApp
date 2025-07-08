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

  WeatherState({
    this.temp = 0,
    this.humidity = 0,
    this.fetchWeatherStatus = FetchWeatherStatus.isLoading,
    required this.hourly
  });

  WeatherState copyWith({
    double? temp,
    int? humidity,
    FetchWeatherStatus? fetchWeatherStatus,
    List<Hourly>? hourly,
  }) {
    return WeatherState(
      temp: temp ?? this.temp,
      humidity: humidity ?? this.humidity,
      fetchWeatherStatus: fetchWeatherStatus ?? this.fetchWeatherStatus,
      hourly: hourly ?? this.hourly,
    );
  }
}