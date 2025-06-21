import 'package:clima_app/features/search/data/models/air_quality_model.dart';
import 'package:clima_app/features/search/data/models/astro_model.dart';
import 'package:clima_app/features/search/domain/entities/current.dart';

class CurrentModel extends Current {
  CurrentModel({
    required super.observationTime,
    required super.temperature,
    required super.weatherCode,
    required super.weatherIcons,
    required super.weatherDescriptions,
    required super.astro,
    required super.airQuality,
    required super.windSpeed,
    required super.windDegree,
    required super.windDir,
    required super.pressure,
    required super.precip,
    required super.humidity,
    required super.cloudcover,
    required super.feelslike,
    required super.uvIndex,
    required super.visibility,
  });

  factory CurrentModel.fromJson(Map<String, dynamic> json){
    return CurrentModel(
      observationTime: json["observation_time"],
      temperature: json["temperature"],
      weatherCode: json["weather_code"],
      weatherIcons: json["weather_icons"] == null ? [] : List<String>.from(json["weather_icons"]!.map((x) => x)),
      weatherDescriptions: json["weather_descriptions"] == null ? [] : List<String>.from(json["weather_descriptions"]!.map((x) => x)),
      astro: json["astro"] == null ? null : AstroModel.fromJson(json["astro"]),
      airQuality: json["air_quality"] == null ? null : AirQualityModel.fromJson(json["air_quality"]),
      windSpeed: json["wind_speed"],
      windDegree: json["wind_degree"],
      windDir: json["wind_dir"],
      pressure: json["pressure"],
      precip: json["precip"],
      humidity: json["humidity"],
      cloudcover: json["cloudcover"],
      feelslike: json["feelslike"],
      uvIndex: json["uv_index"],
      visibility: json["visibility"],
    );
  }

  Map<String, dynamic> toJson() => {
    "observation_time": observationTime,
    "temperature": temperature,
    "weather_code": weatherCode,
    "weather_icons": weatherIcons.map((x) => x).toList(),
    "weather_descriptions": weatherDescriptions.map((x) => x).toList(),
    "astro": (astro as AstroModel).toJson(),
    "air_quality": (airQuality as AirQualityModel).toJson(),
    "wind_speed": windSpeed,
    "wind_degree": windDegree,
    "wind_dir": windDir,
    "pressure": pressure,
    "precip": precip,
    "humidity": humidity,
    "cloudcover": cloudcover,
    "feelslike": feelslike,
    "uv_index": uvIndex,
    "visibility": visibility,
  };
}
