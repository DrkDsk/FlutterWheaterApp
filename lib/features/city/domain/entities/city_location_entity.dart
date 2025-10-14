import 'package:equatable/equatable.dart';

class CityLocation with EquatableMixin {
  final String? id;
  final String city;
  final double latitude;
  final double longitude;
  final String country;
  final String state;

  CityLocation(
      {this.id,
      required this.city,
      required this.latitude,
      required this.longitude,
      required this.country,
      required this.state});

  @override
  List<Object?> get props => [id, city, latitude, longitude, country, state];
}
