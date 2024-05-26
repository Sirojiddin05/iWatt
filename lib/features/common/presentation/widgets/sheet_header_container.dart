import 'package:flutter/material.dart';
import 'package:i_watt_app/core/config/app_colors.dart';

class SheetHeadContainer extends StatelessWidget {
  final Color color;
  final EdgeInsets? margin;
  const SheetHeadContainer({
    super.key,
    this.color = AppColors.blueBayoux,
    this.margin,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 4,
      width: 40,
      margin: margin ?? const EdgeInsets.only(top: 8),
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(8),
      ),
    );
  }
}
