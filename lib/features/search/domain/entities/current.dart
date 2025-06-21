import 'package:clima_app/features/search/domain/entities/air_quality.dart';
import 'package:clima_app/features/search/domain/entities/astro.dart';

class Current {
  Current({
    required this.observationTime,
    required this.temperature,
    required this.weatherCode,
    required this.weatherIcons,
    required this.weatherDescriptions,
    required this.astro,
    required this.airQuality,
    required this.windSpeed,
    required this.windDegree,
    required this.windDir,
    required this.pressure,
    required this.precip,
    required this.humidity,
    required this.cloudcover,
    required this.feelslike,
    required this.uvIndex,
    required this.visibility,
  });

  final String? observationTime;
  final int? temperature;
  final int? weatherCode;
  final List<String> weatherIcons;
  final List<String> weatherDescriptions;
  final Astro? astro;
  final AirQuality? airQuality;
  final int? windSpeed;
  final int? windDegree;
  final String? windDir;
  final int? pressure;
  final int? precip;
  final int? humidity;
  final int? cloudcover;
  final int? feelslike;
  final int? uvIndex;
  final int? visibility;

  Current copyWith({
    String? observationTime,
    int? temperature,
    int? weatherCode,
    List<String>? weatherIcons,
    List<String>? weatherDescriptions,
    Astro? astro,
    AirQuality? airQuality,
    int? windSpeed,
    int? windDegree,
    String? windDir,
    int? pressure,
    int? precip,
    int? humidity,
    int? cloudcover,
    int? feelslike,
    int? uvIndex,
    int? visibility,
  }) {
    return Current(
      observationTime: observationTime ?? this.observationTime,
      temperature: temperature ?? this.temperature,
      weatherCode: weatherCode ?? this.weatherCode,
      weatherIcons: weatherIcons ?? this.weatherIcons,
      weatherDescriptions: weatherDescriptions ?? this.weatherDescriptions,
      astro: astro ?? this.astro,
      airQuality: airQuality ?? this.airQuality,
      windSpeed: windSpeed ?? this.windSpeed,
      windDegree: windDegree ?? this.windDegree,
      windDir: windDir ?? this.windDir,
      pressure: pressure ?? this.pressure,
      precip: precip ?? this.precip,
      humidity: humidity ?? this.humidity,
      cloudcover: cloudcover ?? this.cloudcover,
      feelslike: feelslike ?? this.feelslike,
      uvIndex: uvIndex ?? this.uvIndex,
      visibility: visibility ?? this.visibility,
    );
  }
}
