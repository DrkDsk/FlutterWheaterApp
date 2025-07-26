import 'package:clima_app/features/favorites/data/models/city_location_model.dart';
import 'package:clima_app/features/city/domain/entities/search_city_location_response.dart';

class SearchCityLocationResponseModel {

  final List<CityLocationModel> data;

  const SearchCityLocationResponseModel({required this.data});

  Map<String, dynamic> toMap() {
    return {
      'data': data,
    };
  }

  factory SearchCityLocationResponseModel.fromJson(List<dynamic> jsonList) {
    return SearchCityLocationResponseModel(
      data: jsonList.map((json) => CityLocationModel.fromJson(json)).toList(),
    );
  }

  SearchCityLocationResponse toEntity() {
    return SearchCityLocationResponse(data: data.map((element) => element.toEntity()).toList());
  }
}