import 'package:clima_app/features/search/domain/entities/rain.dart';
import 'package:clima_app/features/search/domain/entities/weather.dart';

class Current {
  Current({
    required this.dt,
    required this.sunrise,
    required this.sunset,
    required this.temp,
    required this.feelsLike,
    required this.pressure,
    required this.humidity,
    required this.dewPoint,
    required this.uvi,
    required this.clouds,
    required this.visibility,
    required this.windSpeed,
    required this.windDeg,
    required this.windGust,
    required this.weather,
    required this.rain,
  });

  final int? dt;
  final int? sunrise;
  final int? sunset;
  final double? temp;
  final double? feelsLike;
  final int? pressure;
  final int? humidity;
  final double? dewPoint;
  final double? uvi;
  final int? clouds;
  final int? visibility;
  final double? windSpeed;
  final int? windDeg;
  final double? windGust;
  final List<Weather> weather;
  final Rain? rain;

  Current copyWith({
    int? dt,
    int? sunrise,
    int? sunset,
    double? temp,
    double? feelsLike,
    int? pressure,
    int? humidity,
    double? dewPoint,
    double? uvi,
    int? clouds,
    int? visibility,
    double? windSpeed,
    int? windDeg,
    double? windGust,
    List<Weather>? weather,
    Rain? rain,
  }) {
    return Current(
      dt: dt ?? this.dt,
      sunrise: sunrise ?? this.sunrise,
      sunset: sunset ?? this.sunset,
      temp: temp ?? this.temp,
      feelsLike: feelsLike ?? this.feelsLike,
      pressure: pressure ?? this.pressure,
      humidity: humidity ?? this.humidity,
      dewPoint: dewPoint ?? this.dewPoint,
      uvi: uvi ?? this.uvi,
      clouds: clouds ?? this.clouds,
      visibility: visibility ?? this.visibility,
      windSpeed: windSpeed ?? this.windSpeed,
      windDeg: windDeg ?? this.windDeg,
      windGust: windGust ?? this.windGust,
      weather: weather ?? this.weather,
      rain: rain ?? this.rain,
    );
  }
}
