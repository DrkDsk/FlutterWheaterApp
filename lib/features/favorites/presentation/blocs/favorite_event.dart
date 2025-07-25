
import 'package:flutter/material.dart';

@immutable
sealed class FavoriteEvent {}

final class StoreCityEvent extends FavoriteEvent {
  final int cityId;
  final double latitude;
  final double longitude;

  StoreCityEvent({required this.cityId, required this.latitude, required this.longitude});

}
