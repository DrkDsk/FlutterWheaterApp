import 'package:clima_app/features/search/domain/entities/current.dart';

class WeatherResponse {
  WeatherResponse({
    required this.latitude,
    required this.longitude,
    required this.timeZone,
    required this.timezoneOffset,
    required this.current,
  });

  final double? latitude;
  final double? longitude;
  final String? timeZone;
  final int? timezoneOffset;
  final Current? current;

  WeatherResponse copyWith({
    double? latitude,
    double? longitude,
    String? timeZone,
    int? timezoneOffset,
    Current? current,
  }) {
    return WeatherResponse(
      latitude: latitude ?? this.latitude,
      longitude: longitude ?? this.longitude,
      timeZone: timeZone ?? this.timeZone,
      timezoneOffset: timezoneOffset ?? this.timezoneOffset,
      current: current ?? this.current,
    );
  }
}
