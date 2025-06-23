import 'package:clima_app/features/search/data/models/current_model.dart';
import 'package:clima_app/features/search/data/models/hourly_model.dart';
import 'package:clima_app/features/search/domain/entities/hourly.dart';
import 'package:clima_app/features/search/domain/entities/weather_response.dart';
import 'package:equatable/equatable.dart';

class WeatherResponseModel extends WeatherResponse with EquatableMixin {
  WeatherResponseModel({
    required super.latitude,
    required super.longitude,
    required super.timeZone,
    required super.timezoneOffset,
    required super.current,
    required super.hourly
  });

  factory WeatherResponseModel.fromJson(Map<String, dynamic> json){
    return WeatherResponseModel(
      latitude: (json["lat"] as num).toDouble(),
      longitude:( json["lon"] as num).toDouble(),
      timeZone: json["timezone"],
      timezoneOffset: (json["timezone_offset"] as num).toInt(),
      current: json["current"] == null ? null : CurrentModel.fromJson(json["current"]),
      hourly: json["hourly"] == null
          ? []
          : List<Hourly>.from(
          json["hourly"]!.map((x) => HourlyModel.fromJson(x))),
    );
  }

  Map<String, dynamic> toJson() => {
    "lat" : latitude,
    "lon" : longitude,
    "timezone" : timeZone,
    "timezone_offset" : timezoneOffset,
    "current": (current as CurrentModel).toJson(),
    "hourly" : hourly?.map((x) => (x as HourlyModel).toJson()).toList(),
  };

  @override
  List<Object?> get props => [latitude, longitude, timeZone, timezoneOffset, current, hourly];
}