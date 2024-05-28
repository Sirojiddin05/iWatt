import 'package:flutter/material.dart';
import 'package:i_watt_app/core/config/app_colors.dart';
import 'package:i_watt_app/core/util/extensions/build_context_extension.dart';

class ConnectorTitleWidget extends StatelessWidget {
  const ConnectorTitleWidget({
    super.key,
    required this.type,
  });

  final String type;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
      decoration: BoxDecoration(
        color: AppColors.lillyWhite,
        borderRadius: BorderRadius.circular(4),
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
