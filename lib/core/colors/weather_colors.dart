import 'package:clima_app/core/enum/time_of_day_type_enum.dart';

class WeatherColors {
  static Map<String, Map<TimeOfDayType, String>> weatherColors = {
    "Clear": {
      TimeOfDayType.day: "assets/lottie/clear_day.json",
      TimeOfDayType.night: "assets/lottie/clear_night.json",
    },
    "Clouds": {
      TimeOfDayType.day: "assets/lottie/sunny.json",
      TimeOfDayType.night: "assets/lottie/cloudy.json",
    },
    "Rain": {
      TimeOfDayType.day: "assets/lottie/rain_day.json",
      TimeOfDayType.night: "assets/lottie/rain_night.json",
    },
    "Snow": {
      TimeOfDayType.day: "assets/lottie/sunny.json",
      TimeOfDayType.night: "assets/lottie/cloudy.json",
    },
    "Thunderstorm": {
      TimeOfDayType.day: "assets/lottie/thunder_day.json",
      TimeOfDayType.night: "assets/lottie/cloudy.json",
    },
    "Drizzle": {
      TimeOfDayType.day: "assets/lottie/sunny.json",
      TimeOfDayType.night: "assets/lottie/cloudy.json",
    },
    "Atmosphere": {
      TimeOfDayType.day: "assets/lottie/sunny.json",
      TimeOfDayType.night: "assets/lottie/cloudy.json",
    },
  };

  static String getWeatherLottie(String weatherType, TimeOfDayType time) {
    return weatherColors[weatherType]?[time] ??
        "assets/lottie/loading_splash.json";
  }
}
