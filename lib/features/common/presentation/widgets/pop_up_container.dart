import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:i_watt_app/core/config/app_colors.dart';
import 'package:i_watt_app/core/config/app_icons.dart';
import 'package:i_watt_app/core/util/enums/pop_up_status.dart';
import 'package:i_watt_app/core/util/extensions/build_context_extension.dart';

class PopUpContainer extends StatelessWidget {
  final PopUpStatus status;
  final String message;
  final VoidCallback onCancel;
  const PopUpContainer({super.key, required this.status, required this.message, required this.onCancel});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: AppColors.nero.withOpacity(0.8),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        children: [
          Container(
            margin: const EdgeInsets.only(left: 12),
            padding: const EdgeInsets.all(4),
            decoration: BoxDecoration(
              color: statusColor(status),
              borderRadius: BorderRadius.circular(6),
            ),
            alignment: Alignment.center,
            child: SvgPicture.asset(statusIcon(status)),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 12),
                Text(
                  message,
                  style: context.textTheme.titleLarge?.copyWith(color: AppColors.white),
                ),
                const SizedBox(height: 12),
              ],
            ),
          ),
          GestureDetector(
            behavior: HitTestBehavior.opaque,
            onTap: onCancel,
            child: Padding(
              padding: const EdgeInsets.fromLTRB(12, 16, 16, 16),
              child: SvgPicture.asset(AppIcons.close),
            ),
          ),
        ],
      ),
    );
  }

  String statusIcon(PopUpStatus status) {
    switch (status) {
      case PopUpStatus.success:
        return AppIcons.popSuccess;
      case PopUpStatus.warning:
        return AppIcons.popFailure;
      case PopUpStatus.failure:
        return AppIcons.popFailure;
    }
  }

  Color statusColor(PopUpStatus status) {
    switch (status) {
      case PopUpStatus.success:
        return AppColors.darkTurquoise;
      case PopUpStatus.failure:
        return AppColors.amaranth;
      case PopUpStatus.warning:
        return AppColors.brightSun;
    }
  }
}
