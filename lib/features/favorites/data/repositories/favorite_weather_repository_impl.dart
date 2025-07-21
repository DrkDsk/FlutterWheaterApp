import 'package:clima_app/core/error/exceptions/unknown_exception.dart';
import 'package:clima_app/core/error/failures/failure.dart';
import 'package:clima_app/features/favorites/data/datasources/favorite_weather_datasource.dart';
import 'package:clima_app/features/favorites/domain/entities/search_city_location_response.dart';
import 'package:clima_app/features/favorites/domain/repository/favorite_weather_repository.dart';
import 'package:clima_app/features/home/domain/entities/get_city_response.dart';
import 'package:dartz/dartz.dart';

class FavoriteWeatherRepositoryImpl implements FavoriteWeatherRepository {

  final FavoriteWeatherDataSource dataSource;

  const FavoriteWeatherRepositoryImpl({required this.dataSource});

  @override
  Future<Either<Failure, SearchCityLocationResponse>> searchCity({required String query}) async {
    try {
      final model = await dataSource.searchCity(query: query);
      return Right(model.toEntity());
    } on UnknownException catch (e) {
      return Left(GenericFailure(e.message));
    }
    catch (_) {
      return Left(GenericFailure("Ha ocurrido un error"));
    }
  }
}