import 'package:clima_app/features/home/domain/entities/coordinate.dart';

class CoordinateModel {

  final double latitude;
  final double longitude;

  const CoordinateModel({required this.latitude, required this.longitude});

  factory CoordinateModel.fromJson(Map<String, dynamic> json){
    return CoordinateModel(
      longitude: json["lon"],
      latitude: json["lat"],
    );
  }

  Map<String, dynamic> toJson() => {
    "lon": longitude,
    "lat": latitude,
  };

  Coordinate toEntity() {
    return Coordinate(latitude: latitude, longitude: longitude);
  }
}