import 'package:clima_app/core/error/failures/failure.dart';
import 'package:clima_app/features/city/domain/repositories/city_repository.dart';
import 'package:clima_app/features/home/domain/entities/get_city_response.dart';
import 'package:dartz/dartz.dart';

class GetCityUseCase {

  final CityRepository repository;

  const GetCityUseCase({required this.repository});

  Future<Either<Failure, GetCityWeatherResponse>> call({required double lat, required double lon}) async {
    return await repository.getCity(lat: lat, lon: lon);
  }
}