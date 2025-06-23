import 'package:clima_app/features/search/data/models/current_model.dart';
import 'package:clima_app/features/search/domain/entities/weather_response.dart';
import 'package:equatable/equatable.dart';

class WeatherResponseModel extends WeatherResponse with EquatableMixin {
  WeatherResponseModel({
    required super.latitude,
    required super.longitude,
    required super.timeZone,
    required super.timezoneOffset,
    required super.current
  });

  factory WeatherResponseModel.fromJson(Map<String, dynamic> json){
    return WeatherResponseModel(
      latitude: json["lat"],
      longitude: json["lon"],
      timeZone: json["timezone"],
      timezoneOffset: json["timezone_offset"],
      current: json["current"] == null ? null : CurrentModel.fromJson(json["current"])
    );
  }

  Map<String, dynamic> toJson() => {
    "lat" : latitude,
    "lon" : longitude,
    "timezone" : timeZone,
    "timezone_offset" : timezoneOffset,
    "current": (current as CurrentModel).toJson(),
  };

  @override
  List<Object?> get props => [latitude, longitude, timeZone, timezoneOffset, current];
}