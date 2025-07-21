import 'package:clima_app/features/home/data/models/clouds_model.dart';
import 'package:clima_app/features/home/data/models/coordinate_model.dart';
import 'package:clima_app/features/home/data/models/main_model.dart';
import 'package:clima_app/features/home/data/models/sys_model.dart';
import 'package:clima_app/features/home/data/models/weather_model.dart';
import 'package:clima_app/features/home/data/models/wind_model.dart';
import 'package:clima_app/features/home/domain/entities/get_city_response.dart';

class GetCityWeatherResponseModel {
  GetCityWeatherResponseModel({
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

  final CoordinateModel? coordinate;
  final List<WeatherModel> weather;
  final String? base;
  final MainModel? main;
  final int? visibility;
  final WindModel? wind;
  final CloudsModel? clouds;
  final int? dt;
  final SysModel? sys;
  final int? timezone;
  final int? id;
  final String? name;
  final int? cod;

  factory GetCityWeatherResponseModel.fromJson(Map<String, dynamic> json) {
    return GetCityWeatherResponseModel(
      coordinate: json["coord"] == null
          ? null
          : CoordinateModel.fromJson(json["coord"]),
      weather: json["weather"] == null
          ? []
          : List<WeatherModel>.from(
              json["weather"]!.map((x) => WeatherModel.fromJson(x))),
      base: json["base"],
      main: json["main"] == null ? null : MainModel.fromJson(json["main"]),
      visibility: json["visibility"],
      wind: json["wind"] == null ? null : WindModel.fromJson(json["wind"]),
      clouds:
          json["clouds"] == null ? null : CloudsModel.fromJson(json["clouds"]),
      dt: json["dt"],
      sys: json["sys"] == null ? null : SysModel.fromJson(json["sys"]),
      timezone: json["timezone"],
      id: json["id"],
      name: json["name"],
      cod: json["cod"],
    );
  }

  Map<String, dynamic> toJson() => {
        "coord": coordinate?.toJson(),
        "weather": weather.map((x) => x.toJson()).toList(),
        "base": base,
        "main": main?.toJson(),
        "visibility": visibility,
        "wind": wind?.toJson(),
        "clouds": clouds?.toJson(),
        "dt": dt,
        "sys": sys?.toJson(),
        "timezone": timezone,
        "id": id,
        "name": name,
        "cod": cod,
      };

  GetCityWeatherResponse toEntity() {
    return GetCityWeatherResponse(
        coordinate: coordinate?.toEntity(),
        weather: weather.map((x) => x.toEntity()).toList(),
        base: base,
        main: main?.toEntity(),
        visibility: visibility,
        wind: wind?.toEntity(),
        clouds: clouds?.toEntity(),
        dt: dt,
        sys: sys?.tonEntity(),
        timezone: timezone,
        id: id,
        name: name,
        cod: cod);
  }
}
