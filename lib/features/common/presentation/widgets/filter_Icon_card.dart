import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:i_watt_app/core/config/app_colors.dart';
import 'package:i_watt_app/core/config/app_icons.dart';

class FilterIconCard extends StatelessWidget {
  final bool isActive;
  final Function() onTap;
  const FilterIconCard({super.key, required this.isActive, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      behavior: HitTestBehavior.opaque,
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
        child: SvgPicture.asset(
          isActive ? AppIcons.filterSelected : AppIcons.filter,
          width: 20,
          height: 20,
        ),
      ),
    );
  }
}
