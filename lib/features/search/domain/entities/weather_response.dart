import 'package:clima_app/features/search/domain/entities/current.dart';
import 'package:clima_app/features/search/domain/entities/hourly.dart';

class WeatherResponse {
  WeatherResponse({
    required this.latitude,
    required this.longitude,
    required this.timeZone,
    required this.timezoneOffset,
    required this.current,
    required this.hourly
  });

  final double? latitude;
  final double? longitude;
  final String? timeZone;
  final int? timezoneOffset;
  final Current? current;
  final List<Hourly>? hourly;

  WeatherResponse copyWith({
    double? latitude,
    double? longitude,
    String? timeZone,
    int? timezoneOffset,
    Current? current,
    List<Hourly>? hourly
  }) {
    return WeatherResponse(
      latitude: latitude ?? this.latitude,
      longitude: longitude ?? this.longitude,
      timeZone: timeZone ?? this.timeZone,
      timezoneOffset: timezoneOffset ?? this.timezoneOffset,
      current: current ?? this.current,
      hourly: hourly ?? this.hourly
    );
  }
}
