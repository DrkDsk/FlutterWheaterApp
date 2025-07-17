import 'package:clima_app/features/home/domain/entities/weather.dart';
import 'package:equatable/equatable.dart';

class WeatherModel with EquatableMixin {
  WeatherModel({this.description, this.id, this.main, this.icon});

  final int? id;
  final String? main;
  final String? description;
  final String? icon;

  factory WeatherModel.fromJson(Map<String, dynamic> map) {
    return WeatherModel(
      id: (map['id'] as num?)?.toInt(),
      main: map['main'] as String?,
      description: map['description'] as String?,
      icon: map['icon'] as String?,
    );
  }

  Weather toEntity() {
    return Weather(id: id, main: main, description: description, icon: icon);
  }

  Map<String, dynamic> toJson() => {
        "id": id,
        "main": main,
        "description": description,
        "icon": icon,
      };

  @override
  // TODO: implement props
  List<Object?> get props => [id, main, description, icon];
}
