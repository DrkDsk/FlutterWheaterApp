import 'package:bloc/bloc.dart';
import 'package:clima_app/features/search/presentation/blocs/events/favorites/favorite_weather_event.dart';
import 'package:clima_app/features/search/presentation/blocs/events/favorites/favorite_weather_state.dart';
import 'package:clima_app/features/search/presentation/blocs/events/favorites/search_favority_weather_event.dart';

class FavoriteWeatherBloc extends Bloc<FavoriteWeatherEvent, FavoriteWeatherState> {
  FavoriteWeatherBloc() : super(FavoriteWeatherInitial()) {
    on<SearchFavoriteWeatherEvent>(_searchWeatherEvent);
  }

  Future<void> _searchWeatherEvent(FavoriteWeatherEvent event, Emitter<FavoriteWeatherState> emit) async {

  }
}
