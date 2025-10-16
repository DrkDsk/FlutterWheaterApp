import 'package:bloc/bloc.dart';
import 'package:clima_app/core/error/exceptions/network_exception.dart';
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
    print("called");
    final either = await _repository.fetchAll();

    emit(state.copyWith(status: FavoriteFetchStatus.loading));

    await either.fold((error) {
      emit(state.copyWith(
          message: error.message, status: FavoriteFetchStatus.failure));
    }, (result) async {
      try {
        List<CityLocation> cities = [];

        if (result.isEmpty) {
          final defaultLocation =
              await _locationService.getCityNameFromCoordinates();

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
      } on NoInternetException catch (e) {
        emit(state.copyWith(
            message: e.message, status: FavoriteFetchStatus.failure));
      }
    });
  }
}
