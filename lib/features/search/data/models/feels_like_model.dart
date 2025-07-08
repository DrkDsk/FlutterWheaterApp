import 'package:clima_app/features/search/domain/entities/feels_like.dart';
import 'package:equatable/equatable.dart';

class FeelsLikeModel with EquatableMixin {
  FeelsLikeModel({this.day, this.night, this.eve, this.morn});

  final double? day;
  final double? night;
  final double? eve;
  final double? morn;

  factory FeelsLikeModel.fromJson(Map<String, dynamic> map) {
    return FeelsLikeModel(
      day: map['day'] as double?,
      night: map['night'] as double?,
      eve: map['eve'] as double?,
      morn: map['morn'] as double?,
    );
  }

  FeelsLike toEntity() {
    return FeelsLike(day: day, night: night, eve: eve, morn: morn);
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
