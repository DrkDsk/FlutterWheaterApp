import 'package:clima_app/core/colors/weather_colors.dart';
import 'package:clima_app/core/enum/time_of_day_type_enum.dart';
import 'package:clima_app/core/helpers/datetime_helper.dart';
import 'package:clima_app/features/home/domain/entities/translated/translated_weather.dart';
import 'package:equatable/equatable.dart';

import 'forecast.dart';

class CityWeatherData with EquatableMixin {
  final Forecast forecast;
  final String city;
  final TranslatedWeather translatedWeather;

  CityWeatherData(
      {required this.forecast,
      required this.city,
      required this.translatedWeather});

  String getBackgroundLottie() {
    final mainTranslatedWeatherDescription = translatedWeather.main;
    if (mainTranslatedWeatherDescription == null) {
      return "assets/lottie/loading_splash.json";
    }

    final currentWeather = forecast.current;

    final isNightTime = DateTimeTimeHelper.isNight(
      DateTime.now(),
      currentWeather.sunrise,
      currentWeather.sunset,
    );

    final timeType = isNightTime ? TimeOfDayType.night : TimeOfDayType.day;
    return WeatherColors.getWeatherLottie(
        mainTranslatedWeatherDescription, timeType);
  }

  @override
  List<Object?> get props => [forecast, city, translatedWeather];
}
