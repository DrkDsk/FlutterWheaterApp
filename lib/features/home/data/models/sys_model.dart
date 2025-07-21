import 'package:clima_app/features/home/domain/entities/sys.dart';

class SysModel {
  const SysModel({
    required this.type,
    required this.id,
    required this.country,
    required this.sunrise,
    required this.sunset,
  });

  final int? type;
  final int? id;
  final String? country;
  final int? sunrise;
  final int? sunset;

  factory SysModel.fromJson(Map<String, dynamic> json) {
    return SysModel(
      type: json["type"],
      id: json["id"],
      country: json["country"],
      sunrise: json["sunrise"],
      sunset: json["sunset"],
    );
  }

  Map<String, dynamic> toJson() => {
        "type": type,
        "id": id,
        "country": country,
        "sunrise": sunrise,
        "sunset": sunset,
      };

  Sys tonEntity() {
    return Sys(
        type: type, id: id, country: country, sunrise: sunrise, sunset: sunset);
  }
}
