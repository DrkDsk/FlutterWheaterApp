import 'package:flutter/material.dart';

@immutable
sealed class FavoriteState {}

final class FavoriteInitial extends FavoriteState {}

final class LoadingFavoriteState extends FavoriteState {}

final class SuccessFavoriteState extends FavoriteState {}

final class ErrorFavoriteState extends FavoriteState {
  final String message;

  ErrorFavoriteState({required this.message});
}
