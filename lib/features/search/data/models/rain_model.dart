import 'package:equatable/equatable.dart';

class RainModel with EquatableMixin {
  RainModel({
    this.the1H,
  });

  final double? the1H;

  factory RainModel.fromJson(Map<String, dynamic> json){
    return RainModel(
      the1H: (json["1h"] as num?)?.toDouble(),
    );
  }

  Map<String, dynamic> toJson() => {
    "1h": the1H,
  };

  @override
  List<Object?> get props => [the1H];
}