import 'package:clima_app/features/city/domain/entities/city_location_entity.dart';
import 'package:clima_app/features/home/domain/entities/city_weather_data.dart';
import 'package:equatable/equatable.dart';

enum CityWeatherStatus {
  initial,
  loading,
  failure,
  success;
}

class CityWeatherState with EquatableMixin {
  final CityWeatherData? cityWeatherData;
  final CityWeatherStatus status;
  final List<CityLocation> cities;
  final String errorMessage;

  const CityWeatherState(
      {this.cityWeatherData,
      this.cities = const [],
      this.status = CityWeatherStatus.initial,
      this.errorMessage = ""});

  CityWeatherState copyWith({
    CityWeatherData? cityWeatherData,
    CityWeatherStatus? status,
    List<CityLocation>? cities,
    String? cityName,
    String? errorMessage,
  }) {
    return CityWeatherState(
      cityWeatherData: cityWeatherData ?? this.cityWeatherData,
      status: status ?? this.status,
      cities: cities ?? this.cities,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }

  @override
  List<Object?> get props => [cityWeatherData, status, cities, errorMessage];
}
