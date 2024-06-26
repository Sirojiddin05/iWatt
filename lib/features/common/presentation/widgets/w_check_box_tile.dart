import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:i_watt_app/core/config/app_colors.dart';
import 'package:i_watt_app/core/config/app_icons.dart';
import 'package:i_watt_app/core/util/extensions/build_context_extension.dart';
import 'package:i_watt_app/features/common/presentation/widgets/w_check_box.dart';
import 'package:i_watt_app/features/common/presentation/widgets/w_custom_tappable_button.dart';
import 'package:i_watt_app/features/common/presentation/widgets/w_image.dart';
import 'package:vibration/vibration.dart';

class WCheckBoxTile extends StatelessWidget {
  final String title;
  final bool hasDivider;
  final bool isSelectedDefault;
  final bool includeIcon;
  final String icon;
  final EdgeInsets padding;
  final Function(bool) onCheck;

  const WCheckBoxTile({
    this.isSelectedDefault = false,
    required this.title,
    this.hasDivider = true,
    required this.onCheck,
    super.key,
    this.includeIcon = false,
    this.icon = '',
    this.padding = const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
  });

  @override
  Widget build(BuildContext context) {
    return WCustomTappableButton(
      onTap: () async {
        if (Platform.isAndroid && (await Vibration.hasVibrator() ?? false)) {
          Vibration.vibrate(amplitude: 32, duration: 40);
        } else if (Platform.isIOS) {
          HapticFeedback.lightImpact();
        }
        onCheck(!isSelectedDefault);
      },
      borderRadius: BorderRadius.zero,
      rippleColor: context.theme.primaryColor.withAlpha(30),
      child: Container(
        padding: padding,
        child: Row(
          children: [
            if (icon.isEmpty || icon.contains('https://')) ...{
              Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  color: AppColors.white,
                  border: Border.all(color: AppColors.solitude),
                ),
                child: WImage(
                    imageUrl: icon,
                    width: 40,
                    height: 40,
                    borderRadius: BorderRadius.circular(20),
                    errorWidget: ColoredBox(
                      color: AppColors.white,
                      child: Padding(
                        padding: const EdgeInsets.all(8),
                        child: SvgPicture.asset(
                          AppIcons.logoPlaceholder,
                          color: AppColors.zircon,
                        ),
                      ),
                    )),
              ),
            } else ...{
              SvgPicture.asset(
                AppIcons.selectAll,
              )
            },
            const SizedBox(width: 12),
            Text(
              title,
              style: context.textTheme.headlineMedium,
            ),
            const Spacer(),
            WCheckBox(isChecked: isSelectedDefault)
          ],
        ),
      ),
    );
  }
}
