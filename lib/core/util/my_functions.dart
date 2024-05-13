import 'package:flutter/material.dart';
import 'package:i_watt_app/core/config/storage_keys.dart';
import 'package:i_watt_app/core/services/storage_repository.dart';
import 'package:i_watt_app/core/util/enums/app_theme.dart';

class MyFunctions {
  const MyFunctions._();

  static ThemeMode getThemeMode() {
    final themeMode = StorageRepository.getString(StorageKeys.themeMode);
    if (themeMode == 'light') {
      return ThemeMode.light;
    }
    if (themeMode == 'dark') {
      return ThemeMode.dark;
    }
    if (themeMode == 'system') {
      return ThemeMode.system;
    }
    return ThemeMode.system;
  }

  static AppTheme getAppTheme() {
    final themeMode = StorageRepository.getString(StorageKeys.themeMode);
    if (themeMode == 'light') {
      return AppTheme.light;
    }
    if (themeMode == 'dark') {
      return AppTheme.dark;
    }
    final brightness = WidgetsBinding.instance.platformDispatcher.platformBrightness;
    final theme = brightness == Brightness.light ? AppTheme.light : AppTheme.dark;
    return theme;
  }
}
