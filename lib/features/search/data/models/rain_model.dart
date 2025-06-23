import 'package:clima_app/features/search/domain/entities/rain.dart';
import 'package:equatable/equatable.dart';

class RainModel extends Rain with EquatableMixin {
  RainModel({
    super.the1H,
  });

  factory RainModel.fromJson(Map<String, dynamic> json){
    return RainModel(
      the1H: (json["1h"] as num).toDouble(),
    );
  }

  Map<String, dynamic> toJson() => {
    "1h": the1H,
  };

  @override
  // TODO: implement props
  List<Object?> get props => [the1H];
}