import 'package:bloc/bloc.dart';
import 'package:clima_app/features/city/domain/entities/city_location_entity.dart';
import 'package:clima_app/features/favorites/domain/repository/favorite_weather_repository.dart';
import 'package:clima_app/features/home/domain/services/location_service.dart';

import './favorite_fetch_state.dart';

class FavoriteFetchCubit extends Cubit<FavoriteFetchState> {
  final FavoriteWeatherRepository _repository;
  final LocationService _locationService;

  FavoriteFetchCubit(
      {required FavoriteWeatherRepository repository,
      required LocationService locationService})
      : _repository = repository,
        _locationService = locationService,
        super(const FavoriteFetchState());

  Future<void> getFavoritesCities() async {
    final either = await _repository.fetchAll();

    emit(state.copyWith(status: FavoriteFetchStatus.loading));

    await either.fold((error) {
      emit(state.copyWith(
          message: error.message, status: FavoriteFetchStatus.failure));
    }, (result) async {
      List<CityLocation> cities = [];

      if (result.isEmpty) {
        final coordinate = await _locationService.getCurrentLocation();

        if (coordinate == null) {
          emit(state.copyWith(
              message: "No se obtuvo la ubicación",
              status: FavoriteFetchStatus.failure));
          return;
        }

        final defaultLocation =
            await _locationService.getCityNameFromCoordinates(
                coordinate.latitude, coordinate.longitude);

        if (defaultLocation != null) {
          cities.add(defaultLocation);
        }

        emit(state.copyWith(
          cities: cities,
          status: FavoriteFetchStatus.success,
        ));

        return;
      }

      cities.addAll(result);

      emit(state.copyWith(
        cities: cities,
        status: FavoriteFetchStatus.success,
      ));
    });
  }
}
