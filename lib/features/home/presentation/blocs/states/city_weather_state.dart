import 'package:clima_app/features/city/domain/entities/city_location_entity.dart';
import 'package:clima_app/features/home/domain/entities/current.dart';
import 'package:clima_app/features/home/domain/entities/daily.dart';
import 'package:clima_app/features/home/domain/entities/hourly.dart';
import 'package:clima_app/features/home/domain/entities/translated/translated_weather.dart';
import 'package:clima_app/features/home/domain/entities/weather_state_data.dart';

sealed class CityWeatherState {
  final List<CityLocation>? previousCitySearchResults;
  const CityWeatherState({this.previousCitySearchResults});
}

final class CallWeatherFetchEventState extends CityWeatherState {
  final double latitude;
  final double longitude;
  final String cityName;

  const CallWeatherFetchEventState(
      {required this.latitude,
      required this.longitude,
      required this.cityName, super.previousCitySearchResults});
}

final class FetchWeatherSuccessState extends CityWeatherState {
  final WeatherStateData weatherData;

  FetchWeatherSuccessState(
      {required this.weatherData, super.previousCitySearchResults});

  CityWeatherState copyWith(
      {Current? currentWeather,
      TranslatedWeather? translatedWeather,
      List<Hourly>? hourly,
      List<Daily>? daily,
      String? city,
      int? cityId,
      double? latitude,
      double? longitude}) {
    return FetchWeatherSuccessState(
      weatherData: WeatherStateData(
          currentWeather: currentWeather ?? weatherData.currentWeather,
          translatedWeather: translatedWeather ?? weatherData.translatedWeather,
          hourly: hourly ?? weatherData.hourly,
          daily: daily ?? weatherData.daily,
          city: city ?? weatherData.city,
          cityId: cityId ?? weatherData.cityId,
          latitude: latitude ?? weatherData.latitude,
          longitude: longitude ?? weatherData.longitude),
    );
  }
}

final class WeatherInitialState extends CityWeatherState {
  const WeatherInitialState();
}

final class FetchWeatherLoadingState extends CityWeatherState {
  const FetchWeatherLoadingState();
}

final class HideWeatherLoadingState extends CityWeatherState {
  const HideWeatherLoadingState();
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

  const SearchCityErrorState({required this.message});
}

final class SearchCityResultSuccess extends CityWeatherState {
  final List<CityLocation> citySearchResult;

  const SearchCityResultSuccess({required this.citySearchResult})
      : super(previousCitySearchResults: citySearchResult);
}
