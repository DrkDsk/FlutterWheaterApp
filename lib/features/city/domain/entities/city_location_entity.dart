import 'package:equatable/equatable.dart';

class CityLocation with EquatableMixin {
  final String? id;
  final String cityName;
  final double latitude;
  final double longitude;
  final String country;
  final String state;

  CityLocation(
      {this.id,
      required this.cityName,
      required this.latitude,
      required this.longitude,
      required this.country,
      required this.state});

  @override
  List<Object?> get props =>
      [id, cityName, latitude, longitude, country, state];
}
