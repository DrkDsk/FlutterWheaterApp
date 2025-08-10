import 'package:clima_app/features/city/domain/entities/city_location_entity.dart';
import 'package:clima_app/features/home/domain/entities/current.dart';
import 'package:clima_app/features/home/domain/entities/daily.dart';
import 'package:clima_app/features/home/domain/entities/hourly.dart';
import 'package:clima_app/features/home/domain/entities/translated/translated_weather.dart';
import 'package:clima_app/features/home/domain/entities/weather_state_data.dart';

sealed class CityWeatherState {
  final List<CityLocation>? previousResults;
  const CityWeatherState({this.previousResults});
}

final class WeatherFetchSuccessState extends CityWeatherState {

  final WeatherStateData weatherData;

  WeatherFetchSuccessState({required this.weatherData}) ;

  CityWeatherState copyWith({
    Current? currentWeather,
    TranslatedWeather? translatedWeather,
    List<Hourly>? hourly,
    List<Daily>? daily,
    String? city,
    int? cityId,
    double? latitude,
    double? longitude
  }) {
    return WeatherFetchSuccessState(
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

final class WeatherInitialState extends CityWeatherState {
  const WeatherInitialState();
}

final class FetchWeatherLoadingState extends CityWeatherState {
  const FetchWeatherLoadingState();
}

final class FetchWeatherErrorState extends CityWeatherState {
  final String message;

  FetchWeatherErrorState({required this.message});
}

final class SearchCityInitialState extends CityWeatherState {
  const SearchCityInitialState();
}

final class SearchCityErrorState extends CityWeatherState {

  final String message;

  const SearchCityErrorState({
    required this.message
  });
}

final class SearchCityResultSuccess extends CityWeatherState {

  final List<CityLocation> data;

  const SearchCityResultSuccess({required this.data}) : super(previousResults: data);
}

final class CitySelectedState extends CityWeatherState {
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
