import 'package:clima_app/features/search/data/models/feels_like_model.dart';
import 'package:clima_app/features/search/data/models/temperature_model.dart';
import 'package:clima_app/features/search/data/models/weather_model.dart';
import 'package:clima_app/features/search/domain/entities/daily.dart';
import 'package:clima_app/features/search/domain/entities/weather.dart';
import 'package:equatable/equatable.dart';

class DailyModel extends Daily with EquatableMixin {
  DailyModel(
      {required super.dt,
      required super.sunrise,
      required super.sunset,
      required super.moonrise,
      required super.moonset,
      required super.moonPhase,
      required super.summary,
      required super.temperature,
      required super.feelsLike,
      required super.pressure,
      required super.humidity,
      required super.dewPoint,
      required super.windSpeed,
      required super.windDeg,
      required super.windGust,
      required super.weather,
      required super.clouds,
      required super.pop,
      required super.rain,
      required super.uvi});

  factory DailyModel.fromJson(Map<String, dynamic> json) {
    return DailyModel(
      dt: json["dt"],
      sunrise: json["sunrise"],
      sunset: json["sunset"],
      moonrise: json["moonrise"],
      moonset: json["moonset"],
      moonPhase: json["moon_phase"],
      summary: json["summary"],
      temperature:
          json["temp"] == null ? null : TemperatureModel.fromJson(json["temp"]),
      feelsLike: json["feels_like"] == null
          ? null
          : FeelsLikeModel.fromJson(json["feels_like"]),
      pressure: json["pressure"],
      humidity: json["humidity"],
      dewPoint: json["dew_point"],
      windSpeed: json["wind_speed"],
      windDeg: json["wind_deg"],
      windGust: json["wind_gust"],
      weather: json["weather"] == null
          ? []
          : List<Weather>.from(
              json["weather"]!.map((x) => WeatherModel.fromJson(x))),
      clouds: json["clouds"],
      pop: json["pop"],
      rain: json["rain"],
      uvi: json["uvi"],
    );
  }

  Map<String, dynamic> toJson() => {
        "dt": dt,
        "sunrise": sunrise,
        "sunset": sunset,
        "moonrise": moonrise,
        "moonset": moonset,
        "moon_phase": moonPhase,
        "summary": summary,
        "temp": (temperature as TemperatureModel).toJson(),
        "feels_like": (feelsLike as FeelsLikeModel).toJson(),
        "pressure": pressure,
        "humidity": humidity,
        "dew_point": dewPoint,
        "wind_speed": windSpeed,
        "wind_deg": windDeg,
        "wind_gust": windGust,
        "weather": weather.map((x) => (x as WeatherModel).toJson()).toList(),
        "clouds": clouds,
        "pop": pop,
        "rain": rain,
        "uvi": uvi,
      };

  @override
  // TODO: implement props
  List<Object?> get props => [
        dt,
        sunrise,
        sunset,
        moonrise,
        moonset,
        moonPhase,
        summary,
        temperature,
        feelsLike,
        pressure,
        humidity,
        dewPoint,
        windSpeed,
        windDeg,
        windGust,
        weather,
        clouds,
        pop,
        rain,
        uvi
      ];
}
