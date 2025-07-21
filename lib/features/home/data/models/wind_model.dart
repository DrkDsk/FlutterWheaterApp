import 'package:clima_app/features/home/domain/entities/wind.dart';

class WindModel {
  const WindModel({
    required this.speed,
    required this.deg,
    required this.gust,
  });

  final double? speed;
  final int? deg;
  final double? gust;

  factory WindModel.fromJson(Map<String, dynamic> json) {
    return WindModel(
      speed: json["speed"],
      deg: json["deg"],
      gust: json["gust"],
    );
  }

  Map<String, dynamic> toJson() => {
        "speed": speed,
        "deg": deg,
        "gust": gust,
      };

  Wind toEntity() {
    return Wind(speed: speed, deg: deg, gust: gust);
  }
}
