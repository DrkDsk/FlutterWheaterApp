enum FetchWeatherStatus {
  isLoading,
  error,
  success
}

class WeatherState {

  final double temp;
  final int humidity;
  final FetchWeatherStatus fetchWeatherStatus;

  const WeatherState({
    this.temp = 0,
    this.humidity = 0,
    this.fetchWeatherStatus = FetchWeatherStatus.isLoading
  });

  WeatherState copyWith({
    double? temp,
    int? humidity,
    FetchWeatherStatus? fetchWeatherStatus,
  }) {
    return WeatherState(
      temp: temp ?? this.temp,
      humidity: humidity ?? this.humidity,
      fetchWeatherStatus: fetchWeatherStatus ?? this.fetchWeatherStatus,
    );
  }
}