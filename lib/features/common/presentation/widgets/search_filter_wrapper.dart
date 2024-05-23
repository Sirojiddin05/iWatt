import 'package:flutter/material.dart';
import 'package:i_watt_app/core/config/app_colors.dart';
import 'package:i_watt_app/core/util/extensions/build_context_extension.dart';

class SearchFilterWrapper extends StatelessWidget {
  final List<Widget> children;
  const SearchFilterWrapper({super.key, required this.children});

  @override
  Widget build(BuildContext context) {
    return Container(
      clipBehavior: Clip.hardEdge,
      decoration: BoxDecoration(
        color: context.theme.colorScheme.primaryContainer,
        borderRadius: BorderRadius.circular(8),
        // border: Border.all(color: lilyWhite),
        boxShadow: [
          BoxShadow(
            offset: const Offset(0, 4),
            blurRadius: 6,
            color: AppColors.black.withOpacity(0.05),
          ),
          BoxShadow(
            offset: const Offset(0, 1),
            spreadRadius: 1,
            color: AppColors.black.withOpacity(0.05),
          ),
          BoxShadow(
            offset: const Offset(0, 0),
            spreadRadius: 4,
            color: AppColors.black.withOpacity(0.08),
          ),
        ],
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: children,
      ),
    );
  }
}
