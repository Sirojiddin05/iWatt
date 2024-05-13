part of 'theme_switcher_bloc.dart';

class ThemeSwitcherState extends Equatable {
  final ThemeMode selectedThemeMode;
  final AppTheme appTheme;

  ThemeSwitcherState copyWith(ThemeMode selectedThemeMode, AppTheme appTheme) {
    return ThemeSwitcherState(selectedThemeMode, appTheme);
  }

  const ThemeSwitcherState(this.selectedThemeMode, this.appTheme);

  @override
  List<Object> get props => [selectedThemeMode, appTheme];
}
