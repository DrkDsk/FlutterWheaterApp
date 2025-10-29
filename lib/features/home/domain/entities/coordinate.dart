import 'package:equatable/equatable.dart';

class Coordinate with EquatableMixin {
  final double latitude;
  final double longitude;

  Coordinate({required this.latitude, required this.longitude});

  Coordinate copyWith({
    double? longitude,
    double? latitude,
  }) {
    return Coordinate(
      longitude: longitude ?? this.longitude,
      latitude: latitude ?? this.latitude,
    );
  }

  @override
  List<Object?> get props => [latitude, longitude];
}
