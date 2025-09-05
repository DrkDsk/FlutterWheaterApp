import 'package:bloc/bloc.dart';
import 'package:clima_app/features/favorites/domain/repository/favorite_weather_repository.dart';
import 'package:uuid/uuid.dart';

import 'package:clima_app/features/favorites/domain/entities/favorite_location.dart';

import './favorite_store_state.dart';

class FavoriteStoreCubit extends Cubit<FavoriteStoreState> {
  final FavoriteWeatherRepository _repository;

  FavoriteStoreCubit({required FavoriteWeatherRepository repository})
      : _repository = repository,
        super(const FavoriteStoreState());

  Future<void> store(
      {required String cityName,
      required double latitude,
      required double longitude}) async {
    emit(state.copyWith(status: FavoriteStoreStatus.initial));

    final FavoriteLocation location = FavoriteLocation(
        id: const Uuid().v4(),
        cityName: cityName,
        latitude: latitude,
        longitude: longitude);

    final resultEither = await _repository.store(location: location);

    resultEither.fold((error) {
      emit(state.copyWith(
        message: error.message,
        status: FavoriteStoreStatus.failure,
      ));
    }, (result) {
      emit(state.copyWith(
          lastCitiStoredIndex: result, status: FavoriteStoreStatus.success));
    });
  }
}
