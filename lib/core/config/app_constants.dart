import 'package:i_watt_app/core/config/app_icons.dart';
import 'package:i_watt_app/features/navigation/domain/entity/nav_bar.dart';
import 'package:i_watt_app/generated/locale_keys.g.dart';

class AppConstants {
  static const String baseUrl = 'https://api.example.com/';
  static const String language = '';

  static final List<NavBar> navBarSections = [
    const NavBar(title: LocaleKeys.map, id: 0, icon: AppIcons.lightning),
    const NavBar(title: LocaleKeys.stations, id: 1, icon: AppIcons.plug),
    const NavBar(title: LocaleKeys.charging_processes, id: 2, icon: AppIcons.batteryBackground),
    const NavBar(title: LocaleKeys.profile, id: 3, icon: AppIcons.user),
  ];

  static const Duration animationDuration = Duration(milliseconds: 150);
}
