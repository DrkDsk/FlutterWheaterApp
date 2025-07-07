import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class BackgroundWeatherCubit extends Cubit<Color?>{

  BackgroundWeatherCubit() : super(Colors.blue[300]);

  void setBackgroundColor(Color color) {
    emit(color);
  }

}