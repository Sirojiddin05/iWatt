import 'package:flutter/material.dart';
import 'package:i_watt_app/core/config/app_colors.dart';

class WhiteWrapperContainer extends StatelessWidget {
  final Widget child;
  final EdgeInsets? margin;
  final EdgeInsets? padding;
  const WhiteWrapperContainer({super.key, required this.child, this.margin, this.padding});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: margin,
      padding: padding,
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: AppColors.baliHai.withOpacity(0.08),
            offset: const Offset(0, 6),
            blurRadius: 24,
          ),
        ],
      ),
      child: child,
    );
  }
}
