import 'package:clima_app/features/search/domain/entities/temperature.dart';
import 'package:equatable/equatable.dart';

class TemperatureModel extends Temperature with EquatableMixin {
  TemperatureModel(
      {required super.day,
      required super.min,
      required super.max,
      required super.night,
      required super.eve,
      required super.morn});

  factory TemperatureModel.fromJson(Map<String, dynamic> json) {
    return TemperatureModel(
      day: json["day"],
      min: json["min"],
      max: json["max"],
      night: json["night"],
      eve: json["eve"],
      morn: json["morn"],
    );
  }

  Map<String, dynamic> toJson() => {
        "day": day,
        "min": min,
        "max": max,
        "night": night,
        "eve": eve,
        "morn": morn,
      };

  @override
  // TODO: implement props
  List<Object?> get props => [day, min, max, night, eve, morn];
}
