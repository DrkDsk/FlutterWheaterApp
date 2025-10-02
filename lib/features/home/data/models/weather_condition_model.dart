import 'package:clima_app/features/home/domain/entities/weather_condition.dart';
import 'package:equatable/equatable.dart';

class WeatherConditionModel with EquatableMixin {
  WeatherConditionModel({this.description, this.id, this.main, this.icon});

  final int? id;
  final String? main;
  final String? description;
  final String? icon;

  factory WeatherConditionModel.fromJson(Map<String, dynamic> map) {
    return WeatherConditionModel(
      id: (map['id'] as num?)?.toInt(),
      main: map['main'] as String?,
      description: map['description'] as String?,
      icon: map['icon'] as String?,
    );
  }

  WeatherCondition toEntity() {
    return WeatherCondition(
        id: id, main: main, description: description, icon: icon);
  }

  Map<String, dynamic> toJson() => {
        "id": id,
        "main": main,
        "description": description,
        "icon": icon,
      };

  @override
  List<Object?> get props => [id, main, description, icon];
}
