import 'package:clima_app/features/search/domain/entities/air_quality.dart';

class AirQualityModel extends AirQuality {
  AirQualityModel({
    required super.co,
    required super.no2,
    required super.o3,
    required super.so2,
    required super.pm25,
    required super.pm10,
    required super.usEpaIndex,
    required super.gbDefraIndex,
  });

  factory AirQualityModel.fromJson(Map<String, dynamic> json) {
    return AirQualityModel(
      co: json["co"],
      no2: json["no2"],
      o3: json["o3"],
      so2: json["so2"],
      pm25: json["pm2_5"],
      pm10: json["pm10"],
      usEpaIndex: json["us-epa-index"],
      gbDefraIndex: json["gb-defra-index"],
    );
  }

  Map<String, dynamic> toJson() => {
        "co": co,
        "no2": no2,
        "o3": o3,
        "so2": so2,
        "pm2_5": pm25,
        "pm10": pm10,
        "us-epa-index": usEpaIndex,
        "gb-defra-index": gbDefraIndex,
      };
}
