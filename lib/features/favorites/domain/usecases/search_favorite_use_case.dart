import 'package:clima_app/core/error/failures/failure.dart';
import 'package:clima_app/features/favorites/domain/entities/search_city_location_response.dart';
import 'package:clima_app/features/favorites/domain/repository/favorite_weather_repository.dart';
import 'package:dartz/dartz.dart';

class SearchCityUseCase {

  final FavoriteWeatherRepository repository;

  const SearchCityUseCase({required this.repository});

  Future<Either<Failure, SearchCityLocationResponse>> call({required String query}) async {
    return await repository.searchCity(query: query);
  }

}