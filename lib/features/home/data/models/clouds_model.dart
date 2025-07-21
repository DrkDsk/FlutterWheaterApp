import 'package:clima_app/features/home/domain/entities/clouds.dart';

class CloudsModel {

  const CloudsModel({
    required this.all,
  });

  final int? all;

  factory CloudsModel.fromJson(Map<String, dynamic> json){
    return CloudsModel(
      all: json["all"],
    );
  }

  Map<String, dynamic> toJson() => {
    "all": all,
  };

  Clouds toEntity() {
    return Clouds(all: all);
  }
}