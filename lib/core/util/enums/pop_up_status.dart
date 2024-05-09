import 'package:flutter/material.dart';
import 'package:i_watt_app/core/config/app_colors/app_colors.dart';
import 'package:i_watt_app/core/config/app_icons.dart';

enum PopUpStatus {
  failure(AppIcons.popFailure, AppColors.amaranth),
  success(AppIcons.popSuccess, AppColors.darkTurquoise),
  warning(AppIcons.popFailure, AppColors.brightSun);

  const PopUpStatus(this.icon, this.color);
  final String icon;
  final Color color;

  bool get isFailure => this == PopUpStatus.failure;
  bool get isSuccess => this == PopUpStatus.success;
  bool get isWarning => this == PopUpStatus.warning;
}
