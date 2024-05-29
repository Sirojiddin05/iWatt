import 'package:flutter/material.dart';
import 'package:i_watt_app/core/config/app_colors.dart';
import 'package:i_watt_app/core/util/extensions/build_context_extension.dart';

class StepRepresentingDivider extends StatelessWidget {
  final int step;
  const StepRepresentingDivider({super.key, required this.step});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Row(
        children: List.generate(
          4,
          (index) => Expanded(
            child: AnimatedContainer(
              height: 3,
              margin: index != 3 ? const EdgeInsets.only(right: 4) : EdgeInsets.zero,
              decoration: BoxDecoration(
                color: index > step ? AppColors.zircon : context.theme.primaryColor,
                borderRadius: BorderRadius.circular(12),
              ),
              duration: const Duration(milliseconds: 200),
            ),
          ),
        ),
      ),
    );
  }
}
