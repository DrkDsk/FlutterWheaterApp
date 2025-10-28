import 'package:clima_app/core/error/failures/failure.dart';
import 'package:clima_app/features/city/domain/entities/city_location_entity.dart';
import 'package:clima_app/features/favorites/domain/repository/favorite_weather_repository.dart';
import 'package:dartz/dartz.dart';
import 'package:uuid/uuid.dart';

class StoreFavoriteUseCase {
  final FavoriteWeatherRepository _repository;

  const StoreFavoriteUseCase({
    required FavoriteWeatherRepository repository,
  }) : _repository = repository;

  Future<Either<Failure, List<CityLocation>>> call(
      {required CityLocation cityLocation}) async {
    final location = cityLocation.copyWith(id: const Uuid().v4());

    final storeResult = await _repository.store(location: location);

    if (storeResult.isLeft()) {
      return Left(storeResult.swap().getOrElse(() => GenericFailure()));
    }

    final favoritesResult = await _repository.fetchAll();

    return favoritesResult.fold(
      (failure) => Left(failure),
      (favorites) {
        return Right(favorites);
      },
    );
  }
}
