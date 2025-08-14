import 'package:equatable/equatable.dart';

class CityLocation with EquatableMixin {
	final String name;
	final double lat;
	final double lon;
	final String country;
	final String? state;

	CityLocation({
		required this.name,
		required this.lat,
		required this.lon,
		required this.country,
		required this.state
	});

  @override
  List<Object?> get props => [name, lat, lon, country, state];
}