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
}
