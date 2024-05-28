import 'package:i_watt_app/core/config/app_icons.dart';
import 'package:i_watt_app/core/config/app_images.dart';
import 'package:i_watt_app/generated/locale_keys.g.dart';

enum CarOnMap {
  whiteCar(icon: AppIcons.whiteCar, title: LocaleKeys.white_car, imageOnMap: AppImages.whiteCar),
  taxi(icon: AppIcons.taxi, title: LocaleKeys.taxi, imageOnMap: AppImages.taxiCar),
  blackCar(icon: AppIcons.blackCar, title: LocaleKeys.black_car, imageOnMap: AppImages.blackCar),
  redCar(icon: AppIcons.redCar, title: LocaleKeys.red_car, imageOnMap: AppImages.redCar),
  oper(icon: AppIcons.oper, title: LocaleKeys.oper, imageOnMap: AppImages.oper),
  sportCar(icon: AppIcons.sportCar, title: LocaleKeys.sport_car, imageOnMap: AppImages.sportCar),
  whiteSuv(icon: AppIcons.whiteSUV, title: LocaleKeys.white_suv, imageOnMap: AppImages.whiteSUV);

  const CarOnMap({
    required this.icon,
    required this.title,
    required this.imageOnMap,
  });

  final String icon;
  final String title;
  final String imageOnMap;

  bool get isWhiteCar => this == CarOnMap.whiteCar;
  bool get isTaxi => this == CarOnMap.taxi;
  bool get isBlackCar => this == CarOnMap.blackCar;
  bool get isRedCar => this == CarOnMap.redCar;
  bool get isOper => this == CarOnMap.oper;
  bool get isSportCar => this == CarOnMap.sportCar;
  bool get isWhiteSuv => this == CarOnMap.whiteSuv;

  static CarOnMap defineType(String key) {
    try {
      final type = CarOnMap.values.firstWhere((element) => element.title == key);
      return type;
    } catch (e) {
      return CarOnMap.sportCar;
    }
  }
}
