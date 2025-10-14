import 'package:bloc/bloc.dart';
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

    final CityLocation location = CityLocation(
        id: const Uuid().v4(),
        cityName: cityLocation.cityName,
        latitude: cityLocation.latitude,
        longitude: cityLocation.longitude,
        country: cityLocation.country,
        state: cityLocation.state);

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
