import 'package:clima_app/features/search/data/models/current_model.dart';
import 'package:clima_app/features/search/data/models/daily_model.dart';
import 'package:clima_app/features/search/data/models/hourly_model.dart';
import 'package:clima_app/features/search/domain/entities/daily.dart';
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
    super.hourly,
    super.daily,
  });

  factory WeatherResponseModel.fromJson(Map<String, dynamic> json){
    return WeatherResponseModel(
      latitude: (json["lat"] as num).toDouble(),
      longitude:( json["lon"] as num).toDouble(),
      timeZone: json["timezone"],
      timezoneOffset: (json["timezone_offset"] as num).toInt(),
      current: CurrentModel.fromJson(json["current"]),
      hourly: json["hourly"] == null
          ? null
          : List<Hourly>.from(
          json["hourly"]!.map((x) => HourlyModel.fromJson(x))),
      daily: json["daily"] == null ? null
        : List<Daily>.from(
        json["daily"]!.map((x) => DailyModel.fromJson(x))
      )
    );
  }

  Map<String, dynamic> toJson() => {
    "lat" : latitude,
    "lon" : longitude,
    "timezone" : timeZone,
    "timezone_offset" : timezoneOffset,
    "current": (current as CurrentModel).toJson(),
    "hourly" : hourly?.map((x) => (x as HourlyModel).toJson()).toList(),
    "daily" : daily?.map((x) => (x as DailyModel).toJson()).toList()
  };

  @override
  List<Object?> get props => [latitude, longitude, timeZone, timezoneOffset, current, hourly, daily];
}

extension MapCleaner on Map<String, dynamic> {
  Map<String, dynamic> cleanNulls() {
    final cleaned = <String, dynamic>{};
    forEach((key, value) {
      if (value == null) return;

      if (value is Map<String, dynamic>) {
        final nestedClean = value.cleanNulls();
        if (nestedClean.isNotEmpty) {
          cleaned[key] = nestedClean;
        }
      }

      else if (value is List) {
        final cleanedList = value.map((item) {
          if (item is Map<String, dynamic>) {
            return item.cleanNulls();
          }
          return item;
        }).where((item) {
          if (item == null) return false;
          if (item is Map && item.isEmpty) return false;
          return true;
        }).toList();

        if (cleanedList.isNotEmpty) {
          cleaned[key] = cleanedList;
        }
      }

      else {
        cleaned[key] = value;
      }
    });
    return cleaned;
  }
}