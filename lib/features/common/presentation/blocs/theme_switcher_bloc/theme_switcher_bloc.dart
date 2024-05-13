import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:i_watt_app/core/config/storage_keys.dart';
import 'package:i_watt_app/core/services/storage_repository.dart';
import 'package:i_watt_app/core/util/enums/app_theme.dart';
import 'package:i_watt_app/core/util/my_functions.dart';

part 'theme_switcher_event.dart';
part 'theme_switcher_state.dart';

class ThemeSwitcherBloc extends Bloc<ThemeSwitcherEvent, ThemeSwitcherState> {
  ThemeSwitcherBloc() : super(ThemeSwitcherState(MyFunctions.getThemeMode(), MyFunctions.getAppTheme())) {
    final window = WidgetsBinding.instance.platformDispatcher;
    window.onPlatformBrightnessChanged = () {
      WidgetsBinding.instance.handlePlatformBrightnessChanged();
      final isSystemTheme = StorageRepository.getString(StorageKeys.themeMode) == 'system';
      if (isSystemTheme) {
        add(const SwitchThemeModeEvent(ThemeMode.system));
      }
    };
    on<SwitchThemeModeEvent>((event, emit) async {
      if (event.themeMode == ThemeMode.light) {
        emit(state.copyWith(event.themeMode, AppTheme.light));
        await StorageRepository.putString(StorageKeys.themeMode, 'light');
      }
      if (event.themeMode == ThemeMode.dark) {
        emit(state.copyWith(event.themeMode, AppTheme.dark));
        await StorageRepository.putString(StorageKeys.themeMode, 'dark');
      }
      if (event.themeMode == ThemeMode.system) {
        final brightness = WidgetsBinding.instance.platformDispatcher.platformBrightness;
        final theme = brightness == Brightness.light ? AppTheme.light : AppTheme.dark;
        emit(state.copyWith(event.themeMode, theme));
        await StorageRepository.putString(StorageKeys.themeMode, 'system');
      }
    });
  }
}
