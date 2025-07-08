import 'package:clima_app/features/search/data/models/rain_model.dart';
import 'package:clima_app/features/search/data/models/weather_model.dart';

class Hourly {
  Hourly({
    required this.dt,
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
    required this.pop,
    required this.rain,
  });

  final int? dt;
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
  final List<WeatherModel> weather;
  final double? pop;
  final RainModel? rain;

  Hourly copyWith({
    int? dt,
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
    List<WeatherModel>? weather,
    double? pop,
    RainModel? rain,
  }) {
    return Hourly(
      dt: dt ?? this.dt,
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
      pop: pop ?? this.pop,
      rain: rain ?? this.rain,
    );
  }
  
  String getHour() {
    final DateTime dateTime = DateTime.fromMillisecondsSinceEpoch((dt ?? 0) * 1000);

    return'${dateTime.hour.toString().padLeft(2, '0')}:${dateTime.minute.toString().padLeft(2, '0')}';
  }

  double get tempCelsius => (temp ?? 0) - 273.15;
  String get tempCelsiusText => (tempCelsius).toStringAsFixed(1);
  double get feelsLikeCelsius => (feelsLike ?? 0) - 273.15;
  String get feelsLikeCelsiusText => (feelsLikeCelsius).toStringAsFixed(1);
  double get dewPointCelsius => (dewPoint ?? 0) - 273.15;
  int get popPercentage => ((pop ?? 0) * 100).round();
  String get popPercentageText => '$popPercentage%';
  double get windSpeedKmH => (windSpeed ?? 0) * 3.6;
  String get windSpeedKmHText => '${windSpeedKmH.toStringAsFixed(1)} km/h';
}
