import 'package:clima_app/features/search/data/models/rain_model.dart';
import 'package:clima_app/features/search/data/models/weather_model.dart';
import 'package:clima_app/features/search/domain/entities/current.dart';
import 'package:equatable/equatable.dart';

class CurrentModel with EquatableMixin {
  CurrentModel({
    this.visibility,
    this.dt,
    this.sunrise,
    this.sunset,
    this.temp,
    this.feelsLike,
    this.pressure,
    this.humidity,
    this.dewPoint,
    this.uvi,
    this.clouds,
    this.windSpeed,
    this.windDeg,
    this.windGust,
    required this.weather,
    this.rain,
  });

  final int? dt;
  final int? sunrise;
  final int? sunset;
  final double? temp;
  final double? feelsLike;
  final int? pressure;
  final int? humidity;
  final double? dewPoint;
  final double? uvi;
  final int? clouds;
  final int? visibility;
  final double? windSpeed;
  final int? windDeg;
  final double? windGust;
  final List<WeatherModel> weather;
  final RainModel? rain;

  factory CurrentModel.fromJson(Map<String, dynamic> map) {
    return CurrentModel(
      dt: map['dt'] as int?,
      sunrise: map['sunrise'] as int?,
      sunset: map['sunset'] as int?,
      temp: (map['temp'] as num?)?.toDouble(),
      feelsLike: (map['feels_like'] as num?)?.toDouble(),
      pressure: map['pressure'] as int?,
      humidity: map['humidity'] as int?,
      dewPoint: (map['dew_point'] as num?)?.toDouble(),
      uvi: (map['uvi'] as num?)?.toDouble(),
      clouds: map['clouds'] as int?,
      visibility: map['visibility'] as int?,
      windSpeed: (map['wind_speed'] as num?)?.toDouble(),
      windDeg: map['wind_deg'] as int?,
      windGust: (map['wind_gust'] as num?)?.toDouble(),
      weather: map["weather"] == null
          ? []
          : List<WeatherModel>.from(
          map["weather"]!.map((x) => WeatherModel.fromJson(x))),
      rain: map["rain"] == null ? null : RainModel.fromJson(map["rain"]),
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

  Current toEntity() {
    return Current(
        dt: dt,
        sunrise: sunrise,
        sunset: sunset,
        temp: temp,
        feelsLike: feelsLike,
        pressure: pressure,
        humidity: humidity,
        dewPoint: dewPoint,
        uvi: uvi,
        clouds: clouds,
        visibility: visibility,
        windSpeed: windSpeed,
        windDeg: windDeg,
        windGust: windGust,
        weather: weather,
        rain: rain
    );
  }

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
