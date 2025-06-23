import 'package:clima_app/features/search/domain/entities/weather.dart';
import 'package:equatable/equatable.dart';

class WeatherModel extends Weather with EquatableMixin {

  WeatherModel({
    required super.description,
    required super.id,
    required super.main,
    required super.icon
  });

  factory WeatherModel.fromJson(Map<String, dynamic> json) {
    return WeatherModel(
      id: json["id"],
      main: json["main"],
      description: json["description"],
      icon: json["icon"],
    );
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
