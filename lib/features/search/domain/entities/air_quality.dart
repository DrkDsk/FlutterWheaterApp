import 'package:equatable/equatable.dart';

class AirQuality with EquatableMixin {
  AirQuality({
    required this.co,
    required this.no2,
    required this.o3,
    required this.so2,
    required this.pm25,
    required this.pm10,
    required this.usEpaIndex,
    required this.gbDefraIndex,
  });

  final String? co;
  final String? no2;
  final String? o3;
  final String? so2;
  final String? pm25;
  final String? pm10;
  final String? usEpaIndex;
  final String? gbDefraIndex;

  AirQuality copyWith({
    String? co,
    String? no2,
    String? o3,
    String? so2,
    String? pm25,
    String? pm10,
    String? usEpaIndex,
    String? gbDefraIndex,
  }) {
    return AirQuality(
      co: co ?? this.co,
      no2: no2 ?? this.no2,
      o3: o3 ?? this.o3,
      so2: so2 ?? this.so2,
      pm25: pm25 ?? this.pm25,
      pm10: pm10 ?? this.pm10,
      usEpaIndex: usEpaIndex ?? this.usEpaIndex,
      gbDefraIndex: gbDefraIndex ?? this.gbDefraIndex,
    );
  }

  @override
  // TODO: implement props
  List<Object?> get props => [
    co,
    no2,
    o3,
    so2,
    pm25,
    pm10,
    usEpaIndex,
    gbDefraIndex,
  ];
}