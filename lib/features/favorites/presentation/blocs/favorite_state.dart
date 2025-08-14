import 'package:clima_app/features/favorites/domain/entities/favorite_location.dart';
import 'package:flutter/material.dart';

enum CrudStatus { initial, loading, success, failure }

@immutable
sealed class FavoriteState {
  const FavoriteState();
}

final class FavoriteInitial extends FavoriteState {}

final class FavoriteLoadingState extends FavoriteState {

  const FavoriteLoadingState();
}

final class SuccessFavoriteState extends FavoriteState {
  final int lastCitiStoredIndex;

  const SuccessFavoriteState({required this.lastCitiStoredIndex});
}

final class ErrorFavoriteState extends FavoriteState {
  final String message;

  const ErrorFavoriteState({required this.message});
}

final class FavoritesCitiesState extends FavoriteState {
  final List<FavoriteLocation> cities;

  const FavoritesCitiesState({required this.cities});
}


