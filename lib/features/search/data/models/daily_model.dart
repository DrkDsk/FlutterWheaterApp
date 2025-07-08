import 'package:clima_app/features/search/data/models/feels_like_model.dart';
import 'package:clima_app/features/search/data/models/temperature_model.dart';
import 'package:clima_app/features/search/data/models/weather_model.dart';
import 'package:clima_app/features/search/domain/entities/daily.dart';
import 'package:equatable/equatable.dart';

class DailyModel with EquatableMixin {
  DailyModel(
      {this.dt,
      this.sunrise,
      this.sunset,
      this.moonrise,
      this.moonset,
      this.moonPhase,
      this.summary,
      this.temperature,
      this.feelsLike,
      this.pressure,
      this.humidity,
      this.dewPoint,
      this.windSpeed,
      this.windDeg,
      this.windGust,
      required this.weather,
      this.clouds,
      this.pop,
      this.rain,
      this.uvi});

  final int? dt;
  final int? sunrise;
  final int? sunset;
  final int? moonrise;
  final int? moonset;
  final double? moonPhase;
  final String? summary;
  final TemperatureModel? temperature;
  final FeelsLikeModel? feelsLike;
  final int? pressure;
  final int? humidity;
  final double? dewPoint;
  final double? windSpeed;
  final int? windDeg;
  final double? windGust;
  final List<WeatherModel> weather;
  final int? clouds;
  final double? pop;
  final double? rain;
  final double? uvi;

  factory DailyModel.fromJson(Map<String, dynamic> map) {
    return DailyModel(
      dt: map['dt'] as int?,
      sunrise: map['sunrise'] as int?,
      sunset: map['sunset'] as int?,
      moonrise: map['moonrise'] as int?,
      moonset: map['moonset'] as int?,
      moonPhase: (map['moon_phase'] as num?)?.toDouble(),
      summary: map['summary'] as String,
      temperature: map["temp"] == null
          ? null
          : TemperatureModel.fromJson(map["temp"]),
      feelsLike: map["feels_like"] == null
          ? null
          : FeelsLikeModel.fromJson(map["feels_like"]),
      pressure: map['pressure'] as int?,
      humidity: map['humidity'] as int?,
      dewPoint: (map['dew_point'] as num?)?.toDouble(),
      windSpeed: (map['wind_speed'] as num?)?.toDouble(),
      windDeg: map['wind_deg'] as int?,
      windGust: (map['wind_gust'] as num?)?.toDouble(),
      weather: map["weather"] == null
          ? []
          : List<WeatherModel>.from(
          map["weather"]!.map((x) => WeatherModel.fromJson(x))),
      clouds: map['clouds'] as int?,
      pop: (map['pop'] as num?)?.toDouble(),
      rain: (map['rain'] as num?)?.toDouble(),
      uvi: (map['uvi'] as num?)?.toDouble(),
    );
  }

  Daily toEntity() {
    return Daily(
        dt: dt,
        sunrise: sunrise,
        sunset: sunset,
        moonrise: moonrise,
        moonset: moonset,
        moonPhase: moonPhase,
        summary: summary,
        temperature: temperature?.toEntity(),
        feelsLike: feelsLike?.toEntity(),
        pressure: pressure,
        humidity: humidity,
        dewPoint: dewPoint,
        windSpeed: windSpeed,
        windDeg: windDeg,
        windGust: windGust,
        weather: weather.map((element) => element.toEntity()).toList(),
        clouds: clouds,
        pop: pop,
        rain: rain,
        uvi: uvi
    );
  }

  Map<String, dynamic> toJson() => {
        "dt": dt,
        "sunrise": sunrise,
        "sunset": sunset,
        "moonrise": moonrise,
        "moonset": moonset,
        "moon_phase": moonPhase,
        "summary": summary,
        "temp": temperature?.toJson(),
        "feels_like": feelsLike?.toJson(),
        "pressure": pressure,
        "humidity": humidity,
        "dew_point": dewPoint,
        "wind_speed": windSpeed,
        "wind_deg": windDeg,
        "wind_gust": windGust,
        "weather": weather.map((x) => (x).toJson()).toList(),
        "clouds": clouds,
        "pop": pop,
        "rain": rain,
        "uvi": uvi,
      };

  @override
  // TODO: implement props
  List<Object?> get props => [
        dt,
        sunrise,
        sunset,
        moonrise,
        moonset,
        moonPhase,
        summary,
        temperature,
        feelsLike,
        pressure,
        humidity,
        dewPoint,
        windSpeed,
        windDeg,
        windGust,
        weather,
        clouds,
        pop,
        rain,
        uvi
      ];
}
