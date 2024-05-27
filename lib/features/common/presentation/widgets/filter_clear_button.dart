import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:i_watt_app/core/config/app_colors.dart';
import 'package:i_watt_app/core/util/extensions/build_context_extension.dart';
import 'package:i_watt_app/features/common/presentation/widgets/w_scale_animation.dart';
import 'package:i_watt_app/generated/locale_keys.g.dart';

class FilterClearButton extends StatelessWidget {
  final bool isActive;
  final VoidCallback onTap;
  const FilterClearButton({super.key, required this.isActive, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return IgnorePointer(
      ignoring: !isActive,
      child: WScaleAnimation(
        onTap: onTap,
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 18, horizontal: 20),
          child: Text(
            LocaleKeys.clear.tr(),
            style: context.textTheme.headlineSmall!.copyWith(color: !isActive ? AppColors.gullGrey : AppColors.dodgerBlue),
          ),
        ),
      ),
    );
  }
}
