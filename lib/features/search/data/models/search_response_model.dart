import 'package:clima_app/features/search/data/models/current_model.dart';
import 'package:clima_app/features/search/data/models/location_model.dart';
import 'package:clima_app/features/search/data/models/request_model.dart';
import 'package:clima_app/features/search/domain/entities/search_response.dart';
import 'package:equatable/equatable.dart';

class SearchResponseModel extends SearchResponse with EquatableMixin {
  SearchResponseModel({
    required super.request,
    required super.location,
    required super.current,
  });

  factory SearchResponseModel.fromJson(Map<String, dynamic> json){
    return SearchResponseModel(
      request: json["request"] == null ? null : RequestModel.fromJson(json["request"]),
      location: json["location"] == null ? null : LocationModel.fromJson(json["location"]),
      current: json["current"] == null ? null : CurrentModel.fromJson(json["current"]),
    );
  }

  Map<String, dynamic> toJson() => {
    "request": (request as RequestModel).toJson(),
    "location": (location as LocationModel).toJson(),
    "current": (current as CurrentModel).toJson(),
  };

  @override
  List<Object?> get props => [request, location, current];
}