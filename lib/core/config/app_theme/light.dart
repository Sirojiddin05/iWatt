import 'package:flutter/material.dart';
import 'package:i_watt_app/core/config/app_colors.dart';
import 'package:i_watt_app/core/config/app_constants.dart';
import 'package:i_watt_app/core/config/app_icons.dart';
import 'package:i_watt_app/core/config/app_theme/theme_extensions/themed_colors.dart';
import 'package:i_watt_app/core/config/app_theme/theme_extensions/themed_icons.dart';

abstract class LightTheme {
  static ThemeData theme() => ThemeData(
        useMaterial3: true,
        fontFamily: 'Inter',
        scaffoldBackgroundColor: AppColors.solitude,
        splashColor: AppColors.cyprus.withAlpha(30),
        dividerColor: AppColors.zircon,
        disabledColor: AppColors.geyser.withOpacity(0.4),
        unselectedWidgetColor: AppColors.slateGrey.withOpacity(0.4),
        shadowColor: AppColors.black.withOpacity(0.05),
        highlightColor: AppColors.brightSun,
        primaryColor: AppColors.dodgerBlue,
        splashFactory: InkRipple.splashFactory,
        appBarTheme: AppBarTheme(
          titleSpacing: 0,
          backgroundColor: AppColors.white,
          surfaceTintColor: AppColors.white,
          shadowColor: AppColors.baliHai.withOpacity(0.2),
          titleTextStyle: headlineLarge,
          toolbarTextStyle: headlineLarge,
        ),
        progressIndicatorTheme: const ProgressIndicatorThemeData(
          color: AppColors.dodgerBlue,
          refreshBackgroundColor: AppColors.white,
        ),
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
        bottomNavigationBarTheme: BottomNavigationBarThemeData(
          selectedItemColor: AppColors.limeGreen,
          unselectedItemColor: AppColors.zumThor,
          selectedLabelStyle: titleMedium,
          unselectedLabelStyle: titleMedium.copyWith(color: AppColors.taxBreak),
          backgroundColor: AppColors.white,
        ),
        inputDecorationTheme: InputDecorationTheme(
          focusColor: AppColors.white,
          contentPadding: const EdgeInsets.all(12),
          floatingLabelBehavior: FloatingLabelBehavior.always,
          labelStyle: labelMedium.copyWith(color: AppColors.darkGray, fontWeight: FontWeight.w500),
          hintStyle: titleSmall.copyWith(color: AppColors.darkGray, fontSize: 16),
          errorStyle: labelMedium.copyWith(color: AppColors.amaranth, fontWeight: FontWeight.w500),
          focusedErrorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
            borderSide: const BorderSide(width: 1, color: AppColors.amaranth),
          ),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
            borderSide: const BorderSide(width: 1, color: AppColors.fieldBorderZircon),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
            borderSide: const BorderSide(width: 1, color: AppColors.fieldBorderZircon),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
            borderSide: const BorderSide(width: 2, color: AppColors.dodgerBlue),
          ),
          errorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
            borderSide: const BorderSide(width: 1, color: AppColors.amaranth),
          ),
          alignLabelWithHint: true,
          hintFadeDuration: AppConstants.animationDuration,
        ),
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
          surfaceTint: AppColors.white,
          primaryContainer: AppColors.white,
          errorContainer: AppColors.amaranth,
          brightness: Brightness.light,
          primary: AppColors.dodgerBlue,
          secondary: AppColors.white,
          error: AppColors.amaranth,
          surface: AppColors.white,
          onPrimary: AppColors.white,
          onSecondary: AppColors.black.withOpacity(0.08),
          onError: AppColors.cyprus,
          onSurface: AppColors.black.withOpacity(0.05),
        ),
        extensions: {
          ThemedColors(
            cyprusToBlueBayoux: AppColors.cyprus,
            lillyWhiteToTaxBreak: AppColors.lillyWhite,
            whiteToCyprusO8: AppColors.white,
            cyprusToTaxBreak: AppColors.cyprus,
            solitudeToSolitudeO4: AppColors.solitude,
            whiteToWhiteO4: AppColors.white,
            cyprusToWhite: AppColors.cyprus,
            taxBreakToZircon: AppColors.taxBreak,
            whiteToTangaroa2: AppColors.white,
            solitudeToAliceBlueO4: AppColors.solitude,
            blueBayouxToWhite: AppColors.blueBayoux,
            prussianBlueToWhite: AppColors.prussianBlue,
            deepFirToWhite: AppColors.deepFir,
            geyserToZirconO2: AppColors.geyser,
          ),
          ThemedIcons(
            splashLogo: AppIcons.splashLogoLight,
            power: AppIcons.power,
            runner: AppIcons.runner,
            station: AppIcons.station,
            qrScan: AppIcons.qrScan,
            plugAlt: AppIcons.plugAlt,
          ),
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
    letterSpacing: 0,
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
    letterSpacing: 0,
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
    letterSpacing: 0,
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
    letterSpacing: 0,
  );
  static const labelMedium = TextStyle(
    fontSize: 12,
    fontWeight: FontWeight.w400,
    color: AppColors.white,
    letterSpacing: 0,
  );
  static const labelSmall = TextStyle(
    fontSize: 10,
    fontWeight: FontWeight.w400,
    color: AppColors.blueBayoux,
    letterSpacing: 0,
  );
}
