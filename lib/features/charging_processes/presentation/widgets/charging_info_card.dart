import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:i_watt_app/core/config/app_colors.dart';
import 'package:i_watt_app/core/util/extensions/build_context_extension.dart';
import 'package:i_watt_app/features/charging_processes/presentation/widgets/charging_process_card_wrapper.dart';

class ChargingInfoCard extends StatelessWidget {
  final String label;
  final String value;
  final String icon;
  final Color? iconColor;
  final Color? backgroundColor;
  final TextStyle? valueTextStyle;
  const ChargingInfoCard({
    super.key,
    required this.label,
    required this.value,
    required this.icon,
    this.iconColor,
    this.backgroundColor,
    this.valueTextStyle,
  });

  @override
  Widget build(BuildContext context) {
    return ChargingProcessCardWrapper(
      color: backgroundColor,
      padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            label,
            style: context.textTheme.titleLarge!.copyWith(fontSize: 12, color: AppColors.taxBreak),
          ),
          const SizedBox(height: 3),
          Row(
            children: [
              SvgPicture.asset(icon, color: iconColor, width: 16, height: 16),
              const SizedBox(width: 4),
              Text(
                getValue(),
                style: valueTextStyle ?? context.textTheme.headlineSmall!.copyWith(color: AppColors.cyprus),
              ),
            ],
          ),
        ],
      ),
    );
  }

  String getValue() {
    final v = value.replaceAll(' kWh', '');
    if (v.contains('-1') || v.contains('-1.0')) {
      return '-';
    }
    return value;
  }
}
