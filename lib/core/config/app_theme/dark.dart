import 'package:flutter/material.dart';
import 'package:i_watt_app/core/config/app_colors.dart';
import 'package:i_watt_app/core/config/app_theme/theme_extensions/themed_colors.dart';

abstract class DarkTheme {
  static ThemeData theme() => ThemeData(
        useMaterial3: true,
        textSelectionTheme: const TextSelectionThemeData(
          cursorColor: AppColors.cyprus,
          // selectionColor: mainButtonColor,
          // selectionHandleColor: mainButtonColor,
        ),
        pageTransitionsTheme: const PageTransitionsTheme(
          builders: <TargetPlatform, PageTransitionsBuilder>{
            TargetPlatform.android: CupertinoPageTransitionsBuilder(),
            TargetPlatform.iOS: CupertinoPageTransitionsBuilder(),
          },
        ),
        scaffoldBackgroundColor: AppColors.black,
        fontFamily: 'Inter',
        appBarTheme: AppBarTheme(
          titleSpacing: 0,
          backgroundColor: AppColors.white,
          surfaceTintColor: AppColors.white,
          shadowColor: AppColors.baliHai.withOpacity(0.2),
          titleTextStyle: headlineLarge,
          toolbarTextStyle: headlineLarge,
        ),
        splashColor: Colors.transparent,
        dividerColor: AppColors.zircon,
        highlightColor: Colors.transparent,
        progressIndicatorTheme: const ProgressIndicatorThemeData(color: AppColors.darkTurquoise, refreshBackgroundColor: AppColors.white),
        textTheme: const TextTheme(
          displayLarge: displayLarge,
          displayMedium: displayMedium,
          displaySmall: displaySmall,
          headlineLarge: headlineLarge,
          headlineMedium: headlineMedium,
          headlineSmall: headlineSmall,
          titleLarge: titleLarge,
          bodyLarge: bodyLarge,
          bodyMedium: bodyMedium,
          bodySmall: bodySmall,
          titleMedium: titleMedium,
          titleSmall: titleSmall,
          labelLarge: labelLarge,
          labelMedium: labelMedium,
          labelSmall: labelSmall,
        ),
        colorScheme: ColorScheme(
          background: AppColors.white,
          brightness: Brightness.light,
          primary: AppColors.darkTurquoise,
          secondary: AppColors.white,
          error: AppColors.amaranth,
          surface: AppColors.white,
          onPrimary: AppColors.white,
          onSecondary: AppColors.black.withOpacity(0.08),
          onBackground: AppColors.white,
          onError: AppColors.cyprus,
          onSurface: AppColors.black.withOpacity(0.05),
        ),
        extensions: {
          ThemedColors(),
        },
      );

  static const displayLarge = TextStyle(
    fontSize: 20,
    fontWeight: FontWeight.w700,
    color: AppColors.cyprus,
  );
  static const displayMedium = TextStyle(
    fontSize: 18,
    fontWeight: FontWeight.w700,
    color: AppColors.cyprus,
  );
  static const displaySmall = TextStyle(
    fontSize: 16,
    fontWeight: FontWeight.w700,
    color: AppColors.cyprus,
  );
  static const headlineLarge = TextStyle(
    fontSize: 16,
    fontWeight: FontWeight.w600,
    color: AppColors.cyprus,
  );
  static const headlineMedium = TextStyle(
    fontSize: 14,
    fontWeight: FontWeight.w600,
    color: AppColors.cyprus,
  );
  static const headlineSmall = TextStyle(
    fontSize: 14,
    fontWeight: FontWeight.w500,
    color: AppColors.cyprus,
  );
  static const bodyLarge = TextStyle(
    fontSize: 14,
    fontWeight: FontWeight.w600,
    color: AppColors.cyprus,
  );
  static const bodyMedium = TextStyle(
    fontSize: 16,
    fontWeight: FontWeight.w500,
    color: AppColors.cyprus,
  );
  static const bodySmall = TextStyle(
    fontSize: 15,
    fontWeight: FontWeight.w600,
    color: AppColors.cyprus,
  );
  static const titleLarge = TextStyle(
    fontSize: 14,
    fontWeight: FontWeight.w400,
    color: AppColors.cyprus,
  );
  static const titleMedium = TextStyle(
    fontSize: 11,
    fontWeight: FontWeight.w500,
    color: AppColors.cyprus,
  );
  static const titleSmall = TextStyle(
    fontSize: 14,
    fontWeight: FontWeight.w400,
    color: AppColors.blueBayoux,
  );
  static const labelLarge = TextStyle(
    fontSize: 12,
    fontWeight: FontWeight.w600,
    color: AppColors.white,
  );
  static const labelMedium = TextStyle(
    fontSize: 12,
    fontWeight: FontWeight.w400,
    color: AppColors.white,
  );
  static const labelSmall = TextStyle(
    fontSize: 10,
    fontWeight: FontWeight.w400,
    color: AppColors.blueBayoux,
    letterSpacing: 0,
  );
}
