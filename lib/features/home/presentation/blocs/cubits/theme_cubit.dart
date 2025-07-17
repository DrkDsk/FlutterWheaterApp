import 'dart:ui';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'theme_state.dart';

class ThemeCubit extends Cubit<ThemeState> {
  ThemeCubit()
      : super(ThemeState(
            isDarkMode: PlatformDispatcher.instance.platformBrightness ==
                Brightness.dark));

  void toggleTheme() {
    emit(state.copyWith(isDarkMode: !state.isDarkMode));
  }
}
