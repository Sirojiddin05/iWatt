import 'package:flutter/material.dart';
import 'package:i_watt_app/core/config/app_colors.dart';
import 'package:i_watt_app/features/common/presentation/widgets/common_loader_dialog.dart';

class CommonLoaderDialog extends StatelessWidget {
  const CommonLoaderDialog({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: AppColors.black.withOpacity(0.5),
      child: const Center(
        child: AnimatedLoaderIndicator(),
      ),
    );
  }
}
