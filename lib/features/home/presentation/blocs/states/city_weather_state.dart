import 'package:clima_app/features/city/domain/entities/city_location_entity.dart';
import 'package:clima_app/features/home/domain/entities/weather_state_data.dart';
import 'package:equatable/equatable.dart';

enum CityWeatherStatus {
  initial,
  loading,
  failure,
  success;
}

class CityWeatherState with EquatableMixin {
  final WeatherData? weatherData;
  final CityWeatherStatus status;
  final List<CityLocation> cities;
  final String cityName;
  final String errorMessage;

  const CityWeatherState(
      {this.weatherData,
      this.cities = const [],
      this.status = CityWeatherStatus.initial,
      this.cityName = "",
      this.errorMessage = ""});

  CityWeatherState copyWith({
    WeatherData? weatherData,
    CityWeatherStatus? status,
    List<CityLocation>? cities,
    String? cityName,
    String? errorMessage,
  }) {
    return CityWeatherState(
      weatherData: weatherData ?? this.weatherData,
      status: status ?? this.status,
      cities: cities ?? this.cities,
      cityName: cityName ?? this.cityName,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }

  @override
  List<Object?> get props =>
      [weatherData, status, cities, cityName, errorMessage];
}
