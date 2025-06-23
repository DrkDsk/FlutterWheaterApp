import 'package:clima_app/features/search/data/models/rain_model.dart';
import 'package:clima_app/features/search/data/models/weather_model.dart';
import 'package:clima_app/features/search/domain/entities/current.dart';
import 'package:clima_app/features/search/domain/entities/weather.dart';
import 'package:equatable/equatable.dart';

class CurrentModel extends Current with EquatableMixin {
  CurrentModel({
    required super.visibility,
    required super.dt,
    required super.sunrise,
    required super.sunset,
    required super.temp,
    required super.feelsLike,
    required super.pressure,
    required super.humidity,
    required super.dewPoint,
    required super.uvi,
    required super.clouds,
    required super.windSpeed,
    required super.windDeg,
    required super.windGust,
    required super.weather,
    required super.rain,
  });

  factory CurrentModel.fromJson(Map<String, dynamic> json) {
    return CurrentModel(
      dt: json["dt"],
      sunrise: json["sunrise"],
      sunset: json["sunset"],
      temp: json["temp"],
      feelsLike: json["feels_like"],
      pressure: json["pressure"],
      humidity: json["humidity"],
      dewPoint: json["dew_point"],
      uvi: json["uvi"],
      clouds: json["clouds"],
      visibility: json["visibility"],
      windSpeed: json["wind_speed"],
      windDeg: json["wind_deg"],
      windGust: json["wind_gust"],
      weather: json["weather"] == null
          ? []
          : List<Weather>.from(
              json["weather"]!.map((x) => WeatherModel.fromJson(x))),
      rain: json["rain"] == null ? null : RainModel.fromJson(json["rain"]),
    );
  }

  Map<String, dynamic> toJson() => {
        "dt": dt,
        "sunrise": sunrise,
        "sunset": sunset,
        "temp": temp,
        "feels_like": feelsLike,
        "pressure": pressure,
        "humidity": humidity,
        "dew_point": dewPoint,
        "uvi": uvi,
        "clouds": clouds,
        "visibility": visibility,
        "wind_speed": windSpeed,
        "wind_deg": windDeg,
        "wind_gust": windGust,
        "weather": weather.map((x) => (x as WeatherModel).toJson()).toList(),
        "rain": (rain as RainModel).toJson(),
      };

  @override
  // TODO: implement props
  List<Object?> get props => [
    dt,
    sunrise,
    sunset,
    temp,
    feelsLike,
    pressure,
    humidity,
    dewPoint,
    uvi,
    clouds,
    visibility,
    windSpeed,
    windDeg,
    windGust,
    weather,
    rain
  ];
}
