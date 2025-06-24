import 'package:clima_app/features/search/data/models/current_model.dart';
import 'package:clima_app/features/search/data/models/daily_model.dart';
import 'package:clima_app/features/search/data/models/hourly_model.dart';

class WeatherResponse {
  WeatherResponse({
    required this.latitude,
    required this.longitude,
    required this.timeZone,
    required this.timezoneOffset,
    required this.current,
    this.hourly,
    this.daily
  });

  final double latitude;
  final double longitude;
  final String timeZone;
  final int timezoneOffset;
  final CurrentModel current;
  final List<HourlyModel>? hourly;
  final List<DailyModel>? daily;

  WeatherResponse copyWith({
    double? latitude,
    double? longitude,
    String? timeZone,
    int? timezoneOffset,
    CurrentModel? current,
    List<HourlyModel>? hourly,
    List<DailyModel>? daily
  }) {
    return WeatherResponse(
      latitude: latitude ?? this.latitude,
      longitude: longitude ?? this.longitude,
      timeZone: timeZone ?? this.timeZone,
      timezoneOffset: timezoneOffset ?? this.timezoneOffset,
      current: current ?? this.current,
      hourly: hourly ?? this.hourly,
      daily: daily ?? this.daily
    );
  }
}
