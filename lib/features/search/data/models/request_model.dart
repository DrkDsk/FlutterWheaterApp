import 'package:clima_app/features/search/domain/entities/request.dart';

class RequestModel extends Request {
  RequestModel({
    required super.type,
    required super.query,
    required super.language,
    required super.unit
  });

  factory RequestModel.fromJson(Map<String, dynamic> json) {
    return RequestModel(
      type: json["type"],
      query: json["query"],
      language: json["language"],
      unit: json["unit"],
    );
  }

  Map<String, dynamic> toJson() => {
        "type": type,
        "query": query,
        "language": language,
        "unit": unit,
      };
}
