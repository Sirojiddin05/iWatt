import 'dart:ui';

import 'package:i_watt_app/core/config/app_colors.dart';
import 'package:i_watt_app/generated/locale_keys.g.dart';

enum ConnectorStatus {
  free(LocaleKeys.free, AppColors.limeGreen),
  busy(LocaleKeys.busy, AppColors.jungleMist),
  booked(LocaleKeys.busy, AppColors.jungleMist),
  notWorking(LocaleKeys.does_not_work, AppColors.amaranth);

  final String title;
  final Color color;

  const ConnectorStatus(this.title, this.color);

  bool get isFree => this == ConnectorStatus.free;
  bool get isBusy => this == ConnectorStatus.busy;
  bool get isBooked => this == ConnectorStatus.booked;
  bool get isNotWorking => this == ConnectorStatus.notWorking;

  static ConnectorStatus fromString(String status) {
    switch (status) {
      case 'Available':
        return ConnectorStatus.free;
      case 'Charging':
        return ConnectorStatus.busy;
      case 'Finishing':
        return ConnectorStatus.busy;
      case 'Reserved':
        return ConnectorStatus.booked;
      case 'SuspendedEVSE':
        return ConnectorStatus.notWorking;
      case 'SuspendedEV':
        return ConnectorStatus.notWorking;
      case 'Faulted':
        return ConnectorStatus.notWorking;
      case 'Preparing':
        return ConnectorStatus.free;
      case 'Unavailable':
        return ConnectorStatus.notWorking;
      default:
        return ConnectorStatus.notWorking;
    }
  }
}
