import 'package:clima_app/features/home/domain/entities/feels_like.dart';
import 'package:clima_app/features/home/domain/entities/temperature.dart';
import 'package:clima_app/features/home/domain/entities/weather_condition.dart';

class Daily {
  Daily({
    required this.dt,
    required this.sunrise,
    required this.sunset,
    required this.moonrise,
    required this.moonset,
    required this.moonPhase,
    required this.summary,
    required this.temperature,
    required this.feelsLike,
    required this.pressure,
    required this.humidity,
    required this.dewPoint,
    required this.windSpeed,
    required this.windDeg,
    required this.windGust,
    required this.weather,
    required this.clouds,
    required this.pop,
    required this.rain,
    required this.uvi,
  });

  final int? dt;
  final int? sunrise;
  final int? sunset;
  final int? moonrise;
  final int? moonset;
  final double? moonPhase;
  final String? summary;
  final Temperature? temperature;
  final FeelsLike? feelsLike;
  final int? pressure;
  final int? humidity;
  final double? dewPoint;
  final double? windSpeed;
  final int? windDeg;
  final double? windGust;
  final List<WeatherCondition> weather;
  final int? clouds;
  final double? pop;
  final double? rain;
  final double? uvi;

  Daily copyWith({
    int? dt,
    int? sunrise,
    int? sunset,
    int? moonrise,
    int? moonset,
    double? moonPhase,
    String? summary,
    Temperature? temperature,
    FeelsLike? feelsLike,
    int? pressure,
    int? humidity,
    double? dewPoint,
    double? windSpeed,
    int? windDeg,
    double? windGust,
    List<WeatherCondition>? weather,
    int? clouds,
    double? pop,
    double? rain,
    double? uvi,
  }) {
    return Daily(
      dt: dt ?? this.dt,
      sunrise: sunrise ?? this.sunrise,
      sunset: sunset ?? this.sunset,
      moonrise: moonrise ?? this.moonrise,
      moonset: moonset ?? this.moonset,
      moonPhase: moonPhase ?? this.moonPhase,
      summary: summary ?? this.summary,
      temperature: temperature ?? this.temperature,
      feelsLike: feelsLike ?? this.feelsLike,
      pressure: pressure ?? this.pressure,
      humidity: humidity ?? this.humidity,
      dewPoint: dewPoint ?? this.dewPoint,
      windSpeed: windSpeed ?? this.windSpeed,
      windDeg: windDeg ?? this.windDeg,
      windGust: windGust ?? this.windGust,
      weather: weather ?? this.weather,
      clouds: clouds ?? this.clouds,
      pop: pop ?? this.pop,
      rain: rain ?? this.rain,
      uvi: uvi ?? this.uvi,
    );
  }
}
