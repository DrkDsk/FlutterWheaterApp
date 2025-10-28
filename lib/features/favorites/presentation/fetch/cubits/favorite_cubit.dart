import 'package:bloc/bloc.dart';
import 'package:clima_app/core/error/exceptions/network_exception.dart';
import 'package:clima_app/features/city/domain/entities/city_location_entity.dart';
import 'package:clima_app/features/favorites/domain/repository/favorite_weather_repository.dart';
import 'package:clima_app/features/favorites/presentation/useCases/store_favorite_use_case.dart';
import 'package:uuid/uuid.dart';

import './favorite_fetch_state.dart';

class FavoriteCubit extends Cubit<FavoriteFetchState> {
  final FavoriteWeatherRepository _repository;
  final StoreFavoriteUseCase _storeFavoriteUseCase;

  FavoriteCubit(
      {required FavoriteWeatherRepository repository,
      required StoreFavoriteUseCase storeFavoriteUseCase})
      : _repository = repository,
        _storeFavoriteUseCase = storeFavoriteUseCase,
        super(const FavoriteFetchState());

  Future<void> getFavoriteCities() async {
    emit(state.copyWith(status: FavoriteFetchStatus.loading));

    final either = await _repository.fetchAll();

    final newState = either.fold<FavoriteFetchState>(
      (error) => state.copyWith(
        message: error.message,
        status: FavoriteFetchStatus.failure,
      ),
      (result) {
        try {
          return state.copyWith(
            cities: result,
            status: FavoriteFetchStatus.success,
          );
        } on NoInternetException catch (e) {
          return state.copyWith(
            message: e.message,
            status: FavoriteFetchStatus.failure,
          );
        } catch (e) {
          return state.copyWith(
            message: '$e',
            status: FavoriteFetchStatus.failure,
          );
        }
      },
    );

    emit(newState);
  }

  Future<void> store({required CityLocation cityLocation}) async {
    emit(state.copyWith(status: FavoriteFetchStatus.loading));

    final location = cityLocation.copyWith(id: const Uuid().v4());

    final storeUseCaseResult =
        await _storeFavoriteUseCase(cityLocation: location);

    final newState = storeUseCaseResult.fold((error) {
      return state.copyWith(
        message: error.message,
        status: FavoriteFetchStatus.failure,
      );
    }, (result) {
      return state.copyWith(
        cities: result,
        status: FavoriteFetchStatus.success,
      );
    });

    emit(newState);
  }
}
