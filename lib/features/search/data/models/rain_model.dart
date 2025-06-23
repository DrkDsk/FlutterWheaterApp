import 'package:clima_app/features/search/domain/entities/rain.dart';

class RainModel extends Rain {
  RainModel({
    required super.the1H,
  });

  factory RainModel.fromJson(Map<String, dynamic> json){
    return RainModel(
      the1H: json["1h"],
    );
  }

  Map<String, dynamic> toJson() => {
    "1h": the1H,
  };
}