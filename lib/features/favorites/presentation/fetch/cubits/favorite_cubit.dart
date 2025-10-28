import 'package:bloc/bloc.dart';
import 'package:clima_app/core/error/exceptions/network_exception.dart';
import 'package:clima_app/features/city/domain/entities/city_location_entity.dart';
import 'package:clima_app/features/favorites/domain/repository/favorite_weather_repository.dart';
import 'package:clima_app/features/favorites/presentation/useCases/store_favorite_use_case.dart';
import 'package:uuid/uuid.dart';

import './favorite_fetch_state.dart';

class FavoriteCubit extends Cubit<FavoriteState> {
  final FavoriteWeatherRepository _repository;
  final StoreFavoriteUseCase _storeFavoriteUseCase;

  FavoriteCubit(
      {required FavoriteWeatherRepository repository,
      required StoreFavoriteUseCase storeFavoriteUseCase})
      : _repository = repository,
        _storeFavoriteUseCase = storeFavoriteUseCase,
        super(const FavoriteState());

  Future<void> getFavoriteCities() async {
    emit(state.copyWith(status: FavoriteStatus.loading));

    final either = await _repository.fetchAll();

    final newState = either.fold<FavoriteState>(
      (error) => state.copyWith(
        message: error.message,
        status: FavoriteStatus.failure,
      ),
      (result) {
        try {
          return state.copyWith(
            cities: result,
            status: FavoriteStatus.success,
          );
        } on NoInternetException catch (e) {
          return state.copyWith(
            message: e.message,
            status: FavoriteStatus.failure,
          );
        } catch (e) {
          return state.copyWith(
            message: '$e',
            status: FavoriteStatus.failure,
          );
        }
      },
    );

    emit(newState);
  }

  Future<void> store({required CityLocation cityLocation}) async {
    emit(state.copyWith(status: FavoriteStatus.loading));

    final location = cityLocation.copyWith(id: const Uuid().v4());

    final storeUseCaseResult =
        await _storeFavoriteUseCase(cityLocation: location);

    final newState = storeUseCaseResult.fold((error) {
      return state.copyWith(
        message: error.message,
        status: FavoriteStatus.failure,
      );
    }, (result) {
      return state.copyWith(
        cities: result,
        status: FavoriteStatus.success,
      );
    });

    emit(newState);
  }
}
