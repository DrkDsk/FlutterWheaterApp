import 'package:clima_app/features/favorites/presentation/blocs/firebase_token_cubit.dart';
import 'package:clima_app/features/favorites/presentation/widgets/favorites_cities_weather_body.dart';
import 'package:clima_app/features/favorites/presentation/widgets/search_city_header.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class FavoritesScreen extends StatefulWidget {
  const FavoritesScreen({super.key});

  @override
  State<FavoritesScreen> createState() => _FavoritesScreenState();
}

class _FavoritesScreenState extends State<FavoritesScreen> {
  late final FirebaseTokenCubit _firebaseTokenCubit;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _firebaseTokenCubit = BlocProvider.of<FirebaseTokenCubit>(context);
    _firebaseTokenCubit.registerToken();
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      backgroundColor: Colors.white10,
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 20),
              SearchCityHeader(),
              SizedBox(height: 10),
              Expanded(
                child: FavoritesCitiesWeatherBody(),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
