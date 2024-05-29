import 'package:flutter/material.dart';
import 'package:i_watt_app/core/config/app_colors.dart';
import 'package:i_watt_app/core/util/extensions/build_context_extension.dart';

class ConnectorTitleWidget extends StatelessWidget {
  const ConnectorTitleWidget({
    super.key,
    required this.type,
    this.isSmall = true,
  });

  final String type;
  final bool isSmall;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: isSmall ? const EdgeInsets.symmetric(horizontal: 8, vertical: 2) : const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
      decoration: BoxDecoration(
        color: AppColors.zircon,
        borderRadius: BorderRadius.circular(6),
      ),
      child: Text(
        type,
        style: context.textTheme.titleSmall!.copyWith(
          color: AppColors.deepFir,
          fontSize: 12,
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }
}
