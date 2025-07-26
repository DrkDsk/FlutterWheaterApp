import 'package:clima_app/features/city/domain/entities/city_location_entity.dart';

class SearchCityLocationResponse{
  final List<CityLocation> data;

  const SearchCityLocationResponse({required this.data});

}