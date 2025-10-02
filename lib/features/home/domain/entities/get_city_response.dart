import 'package:clima_app/features/home/domain/entities/clouds.dart';
import 'package:clima_app/features/home/domain/entities/coordinate.dart';
import 'package:clima_app/features/home/domain/entities/main.dart';
import 'package:clima_app/features/home/domain/entities/sys.dart';
import 'package:clima_app/features/home/domain/entities/weather_condition.dart';
import 'package:clima_app/features/home/domain/entities/wind.dart';

class GetCityWeatherResponse {
  GetCityWeatherResponse({
    required this.coordinate,
    required this.weather,
    required this.base,
    required this.main,
    required this.visibility,
    required this.wind,
    required this.clouds,
    required this.dt,
    required this.sys,
    required this.timezone,
    required this.id,
    required this.name,
    required this.cod,
  });

  final Coordinate? coordinate;
  final List<WeatherCondition> weather;
  final String? base;
  final Main? main;
  final int? visibility;
  final Wind? wind;
  final Clouds? clouds;
  final int? dt;
  final Sys? sys;
  final int? timezone;
  final int? id;
  final String? name;
  final int? cod;

  GetCityWeatherResponse copyWith({
    Coordinate? coordinate,
    List<WeatherCondition>? weather,
    String? base,
    Main? main,
    int? visibility,
    Wind? wind,
    Clouds? clouds,
    int? dt,
    Sys? sys,
    int? timezone,
    int? id,
    String? name,
    int? cod,
  }) {
    return GetCityWeatherResponse(
      coordinate: coordinate ?? this.coordinate,
      weather: weather ?? this.weather,
      base: base ?? this.base,
      main: main ?? this.main,
      visibility: visibility ?? this.visibility,
      wind: wind ?? this.wind,
      clouds: clouds ?? this.clouds,
      dt: dt ?? this.dt,
      sys: sys ?? this.sys,
      timezone: timezone ?? this.timezone,
      id: id ?? this.id,
      name: name ?? this.name,
      cod: cod ?? this.cod,
    );
  }
}
