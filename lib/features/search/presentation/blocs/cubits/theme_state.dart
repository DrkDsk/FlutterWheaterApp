part of 'theme_cubit.dart';

class ThemeState extends Equatable {

  final bool isDarkMode;

  const ThemeState({required this.isDarkMode});

  ThemeState copyWith({bool? isDarkMode}) {
    return ThemeState(isDarkMode: isDarkMode ?? this.isDarkMode);
  }

  @override
  List<Object> get props => [isDarkMode];
}
