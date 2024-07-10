import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:i_watt_app/core/config/app_colors.dart';
import 'package:i_watt_app/core/config/app_icons.dart';
import 'package:i_watt_app/core/util/extensions/build_context_extension.dart';
import 'package:i_watt_app/features/common/presentation/widgets/w_custom_tappable_button.dart';
import 'package:i_watt_app/generated/locale_keys.g.dart';

class FilterIconCard extends StatelessWidget {
  final bool isActive;
  final Function() onTap;

  const FilterIconCard({super.key, required this.isActive, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return WCustomTappableButton(
      rippleColor: context.themedColors.cyprusToWhite.withAlpha(20),
      onTap: onTap,
      borderRadius: BorderRadius.circular(8),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        margin: const EdgeInsets.all(4),
        padding: const EdgeInsets.all(8),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8),
          color: isActive ? AppColors.dodgerBlue.withOpacity(.12) : null,
        ),
        child: Row(
          children: [
            if (isActive) ...{
              SvgPicture.asset(
                AppIcons.filterSelected,
              )
            } else ...{
              SvgPicture.asset(AppIcons.filter)
            },
            const SizedBox(width: 4),
            Text(
              LocaleKeys.filter.tr(),
              style: context.textTheme.headlineSmall!.copyWith(color: isActive ? AppColors.dodgerBlue : AppColors.blueBayoux),
            )
          ],
        ),
      ),
    );
  }
}
