import 'package:clima_app/features/search/domain/entities/feels_like.dart';
import 'package:equatable/equatable.dart';

class FeelsLikeModel extends FeelsLike with EquatableMixin {
  FeelsLikeModel(
      {required super.day,
      required super.night,
      required super.eve,
      required super.morn});

  factory FeelsLikeModel.fromJson(Map<String, dynamic> json) {
    return FeelsLikeModel(
      day: json["day"],
      night: json["night"],
      eve: json["eve"],
      morn: json["morn"],
    );
  }

  Map<String, dynamic> toJson() => {
        "day": day,
        "night": night,
        "eve": eve,
        "morn": morn,
      };

  @override
  // TODO: implement props
  List<Object?> get props => [day, night, eve, morn];
}
