// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:i_watt_app/core/config/app_colors.dart';
import 'package:i_watt_app/core/config/app_icons.dart';

class WCheckBox extends StatelessWidget {
  bool isChecked;
  final Color checkBoxColor;
  final double size;

  WCheckBox({
    required this.isChecked,
    this.size = 24,
    this.checkBoxColor = AppColors.dodgerBlue,
    super.key,
  });

  @override
  Widget build(BuildContext context) => AnimatedContainer(
        duration: const Duration(milliseconds: 150),
        height: size,
        width: size,
        alignment: Alignment.center,
        decoration: BoxDecoration(
          color: isChecked ? checkBoxColor : Colors.transparent,
          borderRadius: BorderRadius.circular(6),
          border: Border.all(color: isChecked ? checkBoxColor : AppColors.geyser, width: 2),
        ),
        child: Builder(builder: (ctx) {
          if (isChecked) {
            return SvgPicture.asset(
              AppIcons.check,
            );
          }
          return Container();
        }),
      );
}
