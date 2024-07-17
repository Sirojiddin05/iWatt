import 'dart:ui';

import 'package:i_watt_app/core/config/app_icons.dart';
import 'package:i_watt_app/features/navigation/domain/entity/nav_bar.dart';
import 'package:i_watt_app/features/profile/domain/entities/language_entity.dart';
import 'package:i_watt_app/generated/locale_keys.g.dart';

class AppConstants {
  static const String baseUrl = 'https://app.i-watt.uz/api/v1/';
  static const Duration animationDuration = Duration(milliseconds: 150);
  static const languageList = [
    LanguageEntity(
      icon: AppIcons.flagUzb,
      title: "O‘zbekcha",
      locale: Locale('uz', 'UZ'),
    ),
    LanguageEntity(
      icon: AppIcons.flagTg,
      title: 'Тоҷикӣ',
      locale: Locale('ta', 'TA'),
    ),
    LanguageEntity(
      icon: AppIcons.flagKaa,
      title: 'Qaraqalpaqsha',
      locale: Locale('ka', 'KA'),
    ),
    LanguageEntity(
      icon: AppIcons.flagRus,
      title: 'Русский',
      locale: Locale('ru', 'RU'),
    ),
    LanguageEntity(
      icon: AppIcons.flagEng,
      title: 'English',
      locale: Locale('en', 'EN'),
    ),
  ];
  static final List<NavBar> navBarSections = [
    const NavBar(title: LocaleKeys.map, id: 0, icon: AppIcons.lightning),
    const NavBar(title: LocaleKeys.stations, id: 1, icon: AppIcons.plug),
    const NavBar(title: LocaleKeys.charging_processes_plural_nominative, id: 2, icon: AppIcons.batteryBackground),
    const NavBar(title: LocaleKeys.profile, id: 3, icon: AppIcons.user),
  ];
  static final regionRegexes = [
    RegExp("^[0-9]{2}"), //01M123MM //white  =>0
    RegExp("^[0-9]{2}"), //01123MMM //white =>1
    RegExp("^UN"), //UN0123 //blue  =>2
    RegExp("^CM"), //CMD1234 //green  =>3
    RegExp("^T[0-9]{1}"), //T012345 //green  =>4
    RegExp("^[0-9]{2}"), //01M123456 //green  =>5
    RegExp("^[0-9]{2}"), //01H123456 //orange =>6
  ];
  static final numberRegexes = [
    RegExp("^[0-9]{2}[A-Z]{1}[0-9]{3}[A-Z]{2}\$"), //01M123MM //white
    RegExp("^[0-9]{5}[A-Z]{3}\$"), //01123MMM //white
    RegExp("^UN[0-9]{4}\$"), //UN0123 //blue
    RegExp("^CMD[0-9]{4}\$"), //CMD1234 //green
    RegExp("^T[0-9]{6}\$"), //T012345 //green
    RegExp("^[0-9]{2}M[0-9]{5,6}\$"), //01M123456 //green
    RegExp("^[0-9]{2}H[0-9]{5,6}\$"), //01H123456 //orange
  ];

  static const locationDb = 'charge_locations.db';
  static const locationsTable = 'locations';
}
