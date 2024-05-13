part of 'theme_switcher_bloc.dart';

@immutable
abstract class ThemeSwitcherEvent {
  const ThemeSwitcherEvent();
}

class SwitchThemeModeEvent extends ThemeSwitcherEvent {
  final ThemeMode themeMode;

  const SwitchThemeModeEvent(this.themeMode);
}
