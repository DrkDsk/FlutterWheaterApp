
import 'package:flutter/material.dart';

@immutable
sealed class FavoriteEvent {
  const FavoriteEvent();
}

final class StoreCityEvent extends FavoriteEvent {
  final int cityId;
  final double latitude;
  final double longitude;

  const StoreCityEvent({required this.cityId, required this.latitude, required this.longitude});
}

final class GetFavoritesCitiesEvent extends FavoriteEvent {
  const GetFavoritesCitiesEvent();
}
