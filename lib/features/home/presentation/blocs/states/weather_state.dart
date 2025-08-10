import 'package:clima_app/features/city/domain/entities/city_location_entity.dart';
import 'package:clima_app/features/home/domain/entities/current.dart';
import 'package:clima_app/features/home/domain/entities/daily.dart';
import 'package:clima_app/features/home/domain/entities/hourly.dart';
import 'package:clima_app/features/home/domain/entities/translated/translated_weather.dart';
import 'package:clima_app/features/home/domain/entities/weather_state_data.dart';

sealed class WeatherState {
  final List<CityLocation>? previousResults;
  const WeatherState({this.previousResults});
}

final class WeatherSuccessState extends WeatherState {

  final WeatherStateData weatherData;

  WeatherSuccessState({required this.weatherData}) ;

  WeatherState copyWith({
    Current? currentWeather,
    TranslatedWeather? translatedWeather,
    List<Hourly>? hourly,
    List<Daily>? daily,
    String? city,
    int? cityId,
    double? latitude,
    double? longitude
  }) {
    return WeatherSuccessState(
      weatherData: WeatherStateData(
          currentWeather: currentWeather ?? weatherData.currentWeather,
          translatedWeather: translatedWeather ?? weatherData.translatedWeather,
          hourly: hourly ?? weatherData.hourly,
          daily: daily ?? weatherData.daily,
          city: city ?? weatherData.city,
          cityId: cityId ?? weatherData.cityId,
          latitude: latitude ?? weatherData.latitude,
          longitude: longitude ?? weatherData.longitude
      ),
    );
  }
}

final class WeatherInitialState extends WeatherState {
  const WeatherInitialState();
}

final class WeatherLoadingState extends WeatherState {
  const WeatherLoadingState();
}

final class WeatherErrorState extends WeatherState {
  final String message;

  WeatherErrorState({required this.message});
}

final class CityInitialState extends WeatherState {
  const CityInitialState();
}

final class SearchErrorCityState extends WeatherState {

  final String message;

  const SearchErrorCityState({
    required this.message
  });
}

final class SuccessResultCities extends WeatherState {

  final List<CityLocation> data;

  const SuccessResultCities({required this.data}) : super(previousResults: data);
}

final class CitySelectedState extends WeatherState {
  final int? cityId;
  final double latitude;
  final double longitude;

  CitySelectedState({
    required this.cityId,
    required this.latitude,
    required this.longitude,
    List<CityLocation>? previousResults,
  }) : super(previousResults: previousResults ?? []);
}
