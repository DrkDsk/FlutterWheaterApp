import 'package:clima_app/features/search/domain/entities/temperature.dart';
import 'package:equatable/equatable.dart';

class TemperatureModel with EquatableMixin {
  TemperatureModel(
      {this.day, this.min, this.max, this.night, this.eve, this.morn});

  final double? day;
  final double? min;
  final double? max;
  final double? night;
  final double? eve;
  final double? morn;

  factory TemperatureModel.fromJson(Map<String, dynamic> map) {
    return TemperatureModel(
      day: map['day'] as double?,
      min: map['min'] as double?,
      max: map['max'] as double?,
      night: map['night'] as double?,
      eve: map['eve'] as double?,
      morn: map['morn'] as double?,
    );
  }

  Temperature toEntity() {
    return Temperature(
        day: day, min: min, max: max, night: night, eve: eve, morn: morn);
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
