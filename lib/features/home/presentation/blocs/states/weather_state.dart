import 'package:clima_app/features/home/domain/entities/current.dart';
import 'package:clima_app/features/home/domain/entities/daily.dart';
import 'package:clima_app/features/home/domain/entities/hourly.dart';
import 'package:clima_app/features/home/domain/entities/translated/translated_weather.dart';
import 'package:clima_app/features/home/domain/entities/weather_state_data.dart';

sealed class WeatherState {
  const WeatherState();
}

final class WeatherSuccessState extends WeatherState {

  final WeatherStateData weatherData;

  WeatherSuccessState({required this.weatherData});

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
