import 'package:clima_app/features/search/domain/entities/location.dart';

class LocationModel extends Location {
  LocationModel(
      {required super.name,
      required super.country,
      required super.region,
      required super.lat,
      required super.lon,
      required super.timezoneId,
      required super.localtime,
      required super.localtimeEpoch,
      required super.utcOffset});

  factory LocationModel.fromJson(Map<String, dynamic> json) {
    return LocationModel(
      name: json["name"],
      country: json["country"],
      region: json["region"],
      lat: json["lat"],
      lon: json["lon"],
      timezoneId: json["timezone_id"],
      localtime: json["localtime"],
      localtimeEpoch: json["localtime_epoch"],
      utcOffset: json["utc_offset"],
    );
  }

  Map<String, dynamic> toJson() => {
        "name": name,
        "country": country,
        "region": region,
        "lat": lat,
        "lon": lon,
        "timezone_id": timezoneId,
        "localtime": localtime,
        "localtime_epoch": localtimeEpoch,
        "utc_offset": utcOffset,
      };
}
