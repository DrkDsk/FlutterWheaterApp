import 'package:clima_app/core/theme/dark_theme.dart';
import 'package:clima_app/core/theme/light_theme.dart';
import 'package:clima_app/features/search/presentation/blocs/cubits/theme_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ThemeHelper {

  static ThemeData getThemeData({required BuildContext context}) {

    final isDarkMode = context.select((ThemeCubit cubit) => cubit.state.isDarkMode);

    if (isDarkMode) return darkTheme;

    return lightTheme;
  }

}