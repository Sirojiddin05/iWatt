import 'package:flutter/material.dart';
import 'package:i_watt_app/core/config/app_colors.dart';
import 'package:i_watt_app/core/util/extensions/build_context_extension.dart';

class NotificationCountBadge extends StatelessWidget {
  final int count;
  const NotificationCountBadge({super.key, required this.count});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
      decoration: BoxDecoration(
        color: AppColors.amaranth,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Text(
        '$count+',
        textAlign: TextAlign.center,
        style: context.textTheme.headlineSmall?.copyWith(color: AppColors.white),
      ),
    );
  }
}
