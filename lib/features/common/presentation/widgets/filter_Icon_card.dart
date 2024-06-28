import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:i_watt_app/core/config/app_colors.dart';
import 'package:i_watt_app/core/config/app_icons.dart';
import 'package:i_watt_app/features/common/presentation/widgets/w_custom_tappable_button.dart';

class FilterIconCard extends StatelessWidget {
  final bool isActive;
  final Function() onTap;
  const FilterIconCard({super.key, required this.isActive, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return WCustomTappableButton(
      rippleColor: AppColors.cyprus.withAlpha(20),
      onTap: onTap,
      borderRadius: BorderRadius.circular(8),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        height: 36,
        width: 36,
        margin: const EdgeInsets.all(4),
        padding: const EdgeInsets.all(8),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8),
          color: isActive ? AppColors.dodgerBlue.withOpacity(.12) : null,
        ),
        child: isActive
            ? SvgPicture.asset(
                AppIcons.filterSelected,
              )
            : SvgPicture.asset(AppIcons.filter),
      ),
    );
  }
}
