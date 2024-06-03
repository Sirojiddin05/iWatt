import 'package:flutter/material.dart';
import 'package:i_watt_app/core/config/app_colors.dart';
import 'package:i_watt_app/core/util/extensions/build_context_extension.dart';

class ChargingProcessCardWrapper extends StatelessWidget {
  final Color? color;
  final EdgeInsets? padding;
  final EdgeInsets? margin;
  final Widget child;
  const ChargingProcessCardWrapper({super.key, this.color, this.padding, this.margin, required this.child});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: margin,
      padding: padding ?? const EdgeInsets.fromLTRB(16, 12, 0, 12),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: color ?? context.colorScheme.primaryContainer,
        boxShadow: [
          BoxShadow(
            color: AppColors.baliHai.withOpacity(0.08),
            blurRadius: 24,
            offset: const Offset(0, 6),
          )
        ],
      ),
      child: child,
    );
  }
}
