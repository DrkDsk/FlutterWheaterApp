import 'package:bloc/bloc.dart';
import 'package:clima_app/core/error/exceptions/network_exception.dart';
import 'package:clima_app/features/favorites/domain/repository/favorite_weather_repository.dart';

import './favorite_fetch_state.dart';

class FavoriteFetchCubit extends Cubit<FavoriteFetchState> {
  final FavoriteWeatherRepository _repository;

  FavoriteFetchCubit({required FavoriteWeatherRepository repository})
      : _repository = repository,
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
}
