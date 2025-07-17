import 'package:bloc/bloc.dart';
import 'package:clima_app/features/favorites/presentation/blocs/favorite_weather_event.dart';
import 'package:clima_app/features/favorites/presentation/blocs/favorite_weather_state.dart';
import 'package:clima_app/features/favorites/presentation/blocs/search_favority_weather_event.dart';

class FavoriteWeatherBloc extends Bloc<FavoriteWeatherEvent, FavoriteWeatherState> {
  FavoriteWeatherBloc() : super(FavoriteWeatherInitial()) {
    on<SearchFavoriteWeatherEvent>(_searchWeatherEvent);
  }

  Future<void> _searchWeatherEvent(SearchFavoriteWeatherEvent event, Emitter<FavoriteWeatherState> emit) async {

  }
}
