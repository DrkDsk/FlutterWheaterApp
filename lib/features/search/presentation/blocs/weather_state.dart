import 'package:clima_app/features/search/domain/entities/current.dart';
import 'package:clima_app/features/search/domain/entities/daily.dart';
import 'package:clima_app/features/search/domain/entities/hourly.dart';
import 'package:clima_app/features/search/domain/entities/translated/translated_weather.dart';

abstract class WeatherState {
  const WeatherState();
}

class WeatherLoadingState extends WeatherState {
  const WeatherLoadingState();
}

class WeatherData {
  final Current currentWeather;
  final TranslatedWeather translatedWeather;
  final List<Hourly> hourly;
  final List<Daily> daily;
  final String city;

  WeatherData({
    required this.currentWeather,
    required this.translatedWeather,
    required this.hourly,
    required this.daily,
    required this.city,
  });
}

class WeatherSuccessState extends WeatherState {

  final WeatherData weatherData;

  WeatherSuccessState({required this.weatherData});

  WeatherState copyWith({
    Current? currentWeather,
    TranslatedWeather? translatedWeather,
    List<Hourly>? hourly,
    List<Daily>? daily,
    String? city,
  }) {
    return WeatherSuccessState(
      weatherData: WeatherData(
        currentWeather: currentWeather ?? weatherData.currentWeather,
        translatedWeather: translatedWeather ?? weatherData.translatedWeather,
        hourly: hourly ?? weatherData.hourly,
        daily: daily ?? weatherData.daily,
        city: city ?? weatherData.city,
      ),
    );
  }
}

class WeatherFavoritesState extends WeatherState {
  final List<WeatherData> favorites;

  WeatherFavoritesState({required this.favorites});
}

class WeatherErrorState extends WeatherState {
  final String message;

  WeatherErrorState({required this.message});
}
