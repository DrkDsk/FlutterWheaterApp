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
      dt: (json["dt"] as num).toInt(),
      sunrise: (json["sunrise"] as num).toInt(),
      sunset: (json["sunset"] as num).toInt(),
      moonrise: (json["moonrise"] as num).toInt(),
      moonset: (json["moonset"] as num).toInt(),
      moonPhase: (json["moon_phase"] as num).toDouble(),
      summary: json["summary"],
      temperature:
          json["temp"] == null ? null : TemperatureModel.fromJson(json["temp"]),
      feelsLike: json["feels_like"] == null
          ? null
          : FeelsLikeModel.fromJson(json["feels_like"]),
      pressure: (json["pressure"] as num).toInt(),
      humidity:( json["humidity"] as num).toInt(),
      dewPoint: (json["dew_point"] as num).toDouble(),
      windSpeed: (json["wind_speed"] as num).toDouble(),
      windDeg: (json["wind_deg"] as num).toInt(),
      windGust: (json["wind_gust"] as num).toDouble(),
      weather: json["weather"] == null
          ? []
          : List<Weather>.from(
              json["weather"]!.map((x) => WeatherModel.fromJson(x))),
      clouds: (json["clouds"] as num).toInt(),
      pop: (json["pop"] as num).toDouble(),
      rain: (json["rain"] as num).toDouble(),
      uvi: (json["uvi"] as num).toDouble(),
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
