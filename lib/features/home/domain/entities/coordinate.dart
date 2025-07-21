class Coordinate {

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
}