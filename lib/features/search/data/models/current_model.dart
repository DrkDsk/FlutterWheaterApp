import 'package:clima_app/features/search/data/models/rain_model.dart';
import 'package:clima_app/features/search/data/models/weather_model.dart';
import 'package:clima_app/features/search/domain/entities/current.dart';
import 'package:equatable/equatable.dart';

class CurrentModel extends Current with EquatableMixin {
  CurrentModel({
    super.visibility,
    super.dt,
    super.sunrise,
    super.sunset,
    super.temp,
    super.feelsLike,
    super.pressure,
    super.humidity,
    super.dewPoint,
    super.uvi,
    super.clouds,
    super.windSpeed,
    super.windDeg,
    super.windGust,
    required super.weather,
    super.rain,
  });

  factory CurrentModel.fromJson(Map<String, dynamic> json) {
    return CurrentModel(
      dt: (json["dt"] as num).toInt(),
      sunrise: (json["sunrise"] as num).toInt(),
      sunset: (json["sunset"] as num).toInt(),
      temp: (json["temp"] as num).toDouble(),
      feelsLike:( json["feels_like"] as num).toDouble(),
      pressure:( json["pressure"] as num).toInt(),
      humidity: (json["humidity"] as num).toInt(),
      dewPoint: (json["dew_point"] as num).toDouble(),
      uvi: (json["uvi"] as num).toDouble(),
      clouds:( json["clouds"] as num).toInt(),
      visibility: (json["visibility"] as num).toInt(),
      windSpeed: (json["wind_speed"] as num).toDouble(),
      windDeg: (json["wind_deg"] as num).toInt(),
      windGust: (json["wind_gust"] as num).toDouble(),
      weather: json["weather"] == null
          ? []
          : List<WeatherModel>.from(
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
        "weather": weather.map((x) => x.toJson()).toList(),
        "rain": rain?.toJson(),
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
