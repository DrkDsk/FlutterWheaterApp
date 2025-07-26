import 'package:clima_app/core/error/failures/failure.dart';
import 'package:clima_app/features/city/domain/repositories/city_repository.dart';
import 'package:clima_app/features/city/domain/entities/search_city_location_response.dart';
import 'package:dartz/dartz.dart';

class SearchCityUseCase {

  final CityRepository repository;

  const SearchCityUseCase({required this.repository});

  Future<Either<Failure, SearchCityLocationResponse>> call({required String query}) async {
    return await repository.searchCity(query: query);
  }
}