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
}
