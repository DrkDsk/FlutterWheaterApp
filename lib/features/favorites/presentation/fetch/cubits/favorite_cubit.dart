import 'package:bloc/bloc.dart';
import 'package:clima_app/features/city/domain/entities/city_location_entity.dart';
import 'package:clima_app/features/favorites/domain/repository/favorite_weather_repository.dart';
import 'package:uuid/uuid.dart';

import './favorite_fetch_state.dart';

class FavoriteCubit extends Cubit<FavoriteState> {
  final FavoriteWeatherRepository _repository;

  FavoriteCubit({
    required FavoriteWeatherRepository repository,
  })  : _repository = repository,
        super(const FavoriteState());

  Future<void> getFavoriteCities() async {
    emit(state.copyWith(status: FavoriteStatus.loading));

    final favoritesResult = await _repository.fetchAll();

    final newState = favoritesResult.fold((error) {
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

  Future<void> store({required CityLocation cityLocation}) async {
    emit(state.copyWith(status: FavoriteStatus.loading));

    final location = cityLocation.copyWith(id: const Uuid().v4());
    final storeResult = await _repository.store(location: location);

    final newState = storeResult.fold((error) {
      return state.copyWith(
        message: error.message,
        status: FavoriteStatus.failure,
      );
    }, (result) {
      state.cities.add(location);

      return state.copyWith(status: FavoriteStatus.success);
    });

    emit(newState);
  }

  Future<void> delete({required String id}) async {
    emit(state.copyWith(status: FavoriteStatus.loading));

    final favoriteId = id;
    final deleteEither = await _repository.delete(id: favoriteId);

    final newState = deleteEither.fold((left) {
      return state.copyWith(
        status: FavoriteStatus.failure,
        message: left.message,
      );
    }, (result) {
      state.cities.removeWhere((element) => element.id == favoriteId);

      return state.copyWith(
        status: FavoriteStatus.success,
      );
    });

    emit(newState);
  }
}
