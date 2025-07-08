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
      day: (json["day"] as num).toDouble(),
      min: (json["min"] as num).toDouble(),
      max: (json["max"] as num).toDouble(),
      night: (json["night"] as num).toDouble(),
      eve: (json["eve"] as num).toDouble(),
      morn: (json["morn"] as num).toDouble(),
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
