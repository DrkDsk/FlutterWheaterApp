import 'package:bloc/bloc.dart';
import 'package:clima_app/features/favorites/domain/entities/favorite_location.dart';
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

    emit(state.copyWith(status: FavoriteFetchStatus.initial));

    await either.fold((error) {
      emit(state.copyWith(
          message: error.message, status: FavoriteFetchStatus.failure));
    }, (result) async {
      List<FavoriteLocation> cities = [];

      if (result.isEmpty) {
        final coordinate = await _locationService.getCurrentLocation();

        final city = await _locationService.getCityNameFromCoordinates(
            coordinate.latitude, coordinate.longitude);

        final defaultLocation = FavoriteLocation(
            cityName: city ?? "",
            latitude: coordinate.latitude,
            longitude: coordinate.longitude);

        cities.add(defaultLocation);

        emit(state.copyWith(
          items: cities,
          status: FavoriteFetchStatus.success,
        ));

        return;
      }

      cities.addAll(result);

      emit(state.copyWith(
        items: cities,
        status: FavoriteFetchStatus.success,
      ));
    });
  }
}
