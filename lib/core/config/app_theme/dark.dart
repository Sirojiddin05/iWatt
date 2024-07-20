import 'package:flutter/material.dart';
import 'package:i_watt_app/core/config/app_colors.dart';
import 'package:i_watt_app/core/config/app_constants.dart';
import 'package:i_watt_app/core/config/app_icons.dart';
import 'package:i_watt_app/core/config/app_images.dart';
import 'package:i_watt_app/core/config/app_theme/theme_extensions/themed_colors.dart';
import 'package:i_watt_app/core/config/app_theme/theme_extensions/themed_icons.dart';

abstract class DarkTheme {
  static ThemeData theme() => ThemeData(
        useMaterial3: true,
        fontFamily: 'Inter',
        scaffoldBackgroundColor: AppColors.cyprus,
        splashColor: AppColors.white.withAlpha(30),
        dividerColor: AppColors.taxBreak.withOpacity(0.4),
        unselectedWidgetColor: AppColors.slateGrey.withOpacity(0.4),
        highlightColor: AppColors.brightSun,
        primaryColor: AppColors.dodgerBlue,
        appBarTheme: AppBarTheme(
          titleSpacing: 0,
          backgroundColor: AppColors.cyprus,
          surfaceTintColor: AppColors.cyprus,
          shadowColor: AppColors.baliHai.withOpacity(0.2),
          titleTextStyle: headlineLarge,
          toolbarTextStyle: headlineLarge,
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
        progressIndicatorTheme: const ProgressIndicatorThemeData(
          color: AppColors.dodgerBlue,
          refreshBackgroundColor: AppColors.white,
        ),
        bottomNavigationBarTheme: BottomNavigationBarThemeData(
          selectedItemColor: AppColors.limeGreen,
          unselectedItemColor: AppColors.blueBayoux,
          selectedLabelStyle: titleMedium,
          unselectedLabelStyle: titleMedium.copyWith(color: AppColors.taxBreak),
          backgroundColor: AppColors.cyprus,
        ),
        inputDecorationTheme: InputDecorationTheme(
          focusColor: AppColors.cyprus,
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
            borderSide: BorderSide(width: 1, color: AppColors.taxBreak.withOpacity(0.4)),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
            borderSide: BorderSide(width: 1, color: AppColors.taxBreak.withOpacity(0.4)),
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
        splashFactory: InkRipple.splashFactory,
        colorScheme: ColorScheme(
          brightness: Brightness.dark,
          primaryContainer: AppColors.tangaroa2,
          primary: AppColors.dodgerBlue,
          secondary: AppColors.white,
          error: AppColors.amaranth,
          surface: AppColors.cyprus,
          onPrimary: AppColors.cyprus,
          onSecondary: AppColors.black.withOpacity(0.08),
          onError: AppColors.cyprus,
          onSurface: AppColors.black.withOpacity(0.05),
        ),
        extensions: {
          ThemedColors(
            cyprusToBlueBayoux: AppColors.blueBayoux,
            lillyWhiteToTaxBreak: AppColors.taxBreak.withOpacity(.4),
            whiteToCyprusO8: AppColors.cyprus.withOpacity(.8),
            cyprusToTaxBreak: AppColors.taxBreak,
            solitudeToSolitudeO4: AppColors.solitude.withOpacity(.04),
            whiteToWhiteO4: AppColors.white.withOpacity(.04),
            cyprusToWhite: Colors.white,
            taxBreakToZircon: AppColors.zircon,
            whiteToTangaroa2: AppColors.tangaroa2,
            solitudeToAliceBlueO4: AppColors.aliceBlue.withOpacity(.04),
            blueBayouxToWhite: AppColors.white,
            prussianBlueToWhite: AppColors.white,
            deepFirToWhite: AppColors.white,
            geyserToZirconO2: AppColors.zircon.withOpacity(.2),
            whiteToCyprus: AppColors.cyprus,
          ),
          ThemedIcons(
            splashLogo: AppIcons.splashLogoDark,
            power: AppIcons.powerDark,
            runner: AppIcons.runnerDark,
            station: AppIcons.stationDark,
            qrScan: AppIcons.qrScanDark,
            plugAlt: AppIcons.plugAltDark,
            uicLogo: AppImages.uicLogoDark,
          ),
        },
      );

  static const displayLarge = TextStyle(
    fontSize: 20,
    fontWeight: FontWeight.w700,
    color: AppColors.white,
  );
  static const displayMedium = TextStyle(
    fontSize: 18,
    fontWeight: FontWeight.w700,
    color: AppColors.white,
  );
  static const displaySmall = TextStyle(
    fontSize: 16,
    fontWeight: FontWeight.w700,
    color: AppColors.white,
  );
  static const headlineLarge = TextStyle(
    fontSize: 16,
    fontWeight: FontWeight.w600,
    color: AppColors.white,
  );
  static const headlineMedium = TextStyle(
    fontSize: 14,
    fontWeight: FontWeight.w600,
    color: AppColors.white,
  );
  static const headlineSmall = TextStyle(
    fontSize: 14,
    fontWeight: FontWeight.w500,
    color: AppColors.white,
  );
  static const bodyLarge = TextStyle(
    fontSize: 14,
    fontWeight: FontWeight.w600,
    color: AppColors.white,
  );
  static const bodyMedium = TextStyle(
    fontSize: 16,
    fontWeight: FontWeight.w500,
    color: AppColors.white,
  );
  static const bodySmall = TextStyle(
    fontSize: 15,
    fontWeight: FontWeight.w600,
    color: AppColors.white,
    letterSpacing: 0,
  );
  static const titleLarge = TextStyle(
    fontSize: 14,
    fontWeight: FontWeight.w400,
    color: AppColors.white,
  );
  static const titleMedium = TextStyle(
    fontSize: 11,
    fontWeight: FontWeight.w500,
    color: AppColors.white,
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
  );
  static const labelSmall = TextStyle(
    fontSize: 10,
    fontWeight: FontWeight.w400,
    color: AppColors.blueBayoux,
    letterSpacing: 0,
  );
}
