class Location {
  Location({
    required this.name,
    required this.country,
    required this.region,
    required this.lat,
    required this.lon,
    required this.timezoneId,
    required this.localtime,
    required this.localtimeEpoch,
    required this.utcOffset,
  });

  final String? name;
  final String? country;
  final String? region;
  final String? lat;
  final String? lon;
  final String? timezoneId;
  final String? localtime;
  final int? localtimeEpoch;
  final String? utcOffset;

  Location copyWith({
    String? name,
    String? country,
    String? region,
    String? lat,
    String? lon,
    String? timezoneId,
    String? localtime,
    int? localtimeEpoch,
    String? utcOffset,
  }) {
    return Location(
      name: name ?? this.name,
      country: country ?? this.country,
      region: region ?? this.region,
      lat: lat ?? this.lat,
      lon: lon ?? this.lon,
      timezoneId: timezoneId ?? this.timezoneId,
      localtime: localtime ?? this.localtime,
      localtimeEpoch: localtimeEpoch ?? this.localtimeEpoch,
      utcOffset: utcOffset ?? this.utcOffset,
    );
  }
}