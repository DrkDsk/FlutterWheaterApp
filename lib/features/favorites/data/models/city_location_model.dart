import 'package:clima_app/features/favorites/domain/entities/city_location_entity.dart';

class CityLocationModel {
  final String name;
  final double lat;
  final double lon;
  final String country;
  final String state;

  const CityLocationModel({
    required this.name,
    required this.lat,
    required this.lon,
    required this.country,
    required this.state,
  });

  CityLocation toEntity() {
    return CityLocation(
        name: name,
        lat: lat,
        lon: lon,
        country: country,
        state: state
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'lat': lat,
      'lon': lon,
      'country': country,
      'state': state,
    };
  }

  factory CityLocationModel.fromJson(Map<String, dynamic> map) {
    return CityLocationModel(
      name: map['name'] as String,
      lat: map['lat'] as double,
      lon: map['lon'] as double,
      country: map['country'] as String,
      state: map['state'] as String,
    );
  }
}
