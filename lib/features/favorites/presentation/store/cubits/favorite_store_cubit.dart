import 'package:bloc/bloc.dart';
import 'package:clima_app/core/error/exceptions/network_exception.dart';
import 'package:clima_app/features/city/domain/entities/city_location_entity.dart';
import 'package:clima_app/features/favorites/domain/repository/favorite_weather_repository.dart';
import 'package:uuid/uuid.dart';

import './favorite_store_state.dart';

class FavoriteStoreCubit extends Cubit<FavoriteStoreState> {
  final FavoriteWeatherRepository _repository;

  FavoriteStoreCubit({required FavoriteWeatherRepository repository})
      : _repository = repository,
        super(const FavoriteStoreState());

  Future<void> store({required CityLocation cityLocation}) async {
    emit(state.copyWith(status: FavoriteStoreStatus.initial));

    final location = cityLocation.copyWith(id: const Uuid().v4());

    final resultEither = await _repository.store(location: location);

    final newState = resultEither.fold((error) {
      return state.copyWith(
        message: error.message,
        status: FavoriteStoreStatus.failure,
      );
    }, (result) {
      try {
        return state.copyWith(
          status: FavoriteStoreStatus.success,
        );
      } on NoInternetException catch (e) {
        return state.copyWith(
          message: e.message,
          status: FavoriteStoreStatus.failure,
        );
      } catch (e) {
        return state.copyWith(
          message: '$e',
          status: FavoriteStoreStatus.failure,
        );
      }
    });

    emit(newState);
  }
}
