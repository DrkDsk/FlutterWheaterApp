import 'package:clima_app/features/search/domain/entities/current.dart';
import 'package:clima_app/features/search/domain/entities/daily.dart';
import 'package:clima_app/features/search/domain/entities/hourly.dart';
import 'package:clima_app/features/search/domain/entities/translated/translated_weather.dart';
import 'package:clima_app/features/search/domain/entities/weather_state_data.dart';
import 'package:clima_app/features/search/presentation/blocs/states/weather_state.dart';

class WeatherSuccessState extends WeatherState {

  final WeatherStateData weatherData;

  WeatherSuccessState({required this.weatherData});

  WeatherState copyWith({
    Current? currentWeather,
    TranslatedWeather? translatedWeather,
    List<Hourly>? hourly,
    List<Daily>? daily,
    String? city,
  }) {
    return WeatherSuccessState(
      weatherData: WeatherStateData(
        currentWeather: currentWeather ?? weatherData.currentWeather,
        translatedWeather: translatedWeather ?? weatherData.translatedWeather,
        hourly: hourly ?? weatherData.hourly,
        daily: daily ?? weatherData.daily,
        city: city ?? weatherData.city,
      ),
    );
  }
}