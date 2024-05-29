import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:i_watt_app/core/config/app_colors.dart';
import 'package:i_watt_app/core/config/app_icons.dart';
import 'package:i_watt_app/core/util/extensions/build_context_extension.dart';
import 'package:i_watt_app/features/common/presentation/widgets/sheet_header_widget.dart';
import 'package:i_watt_app/features/common/presentation/widgets/w_scale_animation.dart';
import 'package:i_watt_app/generated/locale_keys.g.dart';

class MyCardsSheetHeader extends StatelessWidget {
  final Function() onEditTap;

  const MyCardsSheetHeader({super.key, required this.onEditTap});

  @override
  Widget build(BuildContext context) {
    return SheetHeaderWidget(
      titleWidget: Padding(
        padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
        child: Row(
          children: [
            Text(LocaleKeys.my_cards.tr(), style: Theme.of(context).textTheme.displayMedium),
            const SizedBox(width: 6),
            WScaleAnimation(
              onTap: onEditTap,
              child: Container(
                padding: const EdgeInsets.symmetric(vertical: 4, horizontal: 8),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: AppColors.dodgerBlue.withOpacity(.1),
                ),
                child: Row(
                  children: [
                    SvgPicture.asset(AppIcons.edit),
                    const SizedBox(width: 4),
                    Text(
                      LocaleKeys.edit.tr(),
                      style: context.textTheme.labelLarge?.copyWith(color: AppColors.dodgerBlue),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
