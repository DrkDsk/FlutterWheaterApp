import 'package:clima_app/features/search/domain/entities/astro.dart';

class AstroModel extends Astro {

  AstroModel({
    required super.sunrise,
    required super.sunset,
    required super.moonrise,
    required super.moonset,
    required super.moonPhase,
    required super.moonIllumination
  });

  factory AstroModel.fromJson(Map<String, dynamic> json){
    return AstroModel(
      sunrise: json["sunrise"],
      sunset: json["sunset"],
      moonrise: json["moonrise"],
      moonset: json["moonset"],
      moonPhase: json["moon_phase"],
      moonIllumination: json["moon_illumination"],
    );
  }

  Map<String, dynamic> toJson() => {
    "sunrise": sunrise,
    "sunset": sunset,
    "moonrise": moonrise,
    "moonset": moonset,
    "moon_phase": moonPhase,
    "moon_illumination": moonIllumination,
  };
}