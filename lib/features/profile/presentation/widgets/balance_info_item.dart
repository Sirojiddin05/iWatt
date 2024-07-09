import 'dart:math';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:i_watt_app/core/config/app_colors.dart';
import 'package:i_watt_app/core/config/app_icons.dart';
import 'package:i_watt_app/core/config/app_images.dart';
import 'package:i_watt_app/core/util/extensions/build_context_extension.dart';
import 'package:i_watt_app/core/util/my_functions.dart';
import 'package:i_watt_app/features/common/presentation/widgets/w_custom_tappable_button.dart';
import 'package:i_watt_app/generated/locale_keys.g.dart';

class BalanceInfoItem extends StatelessWidget {
  final String balance;
  final bool isMain;
  final VoidCallback onTap;

  const BalanceInfoItem({
    super.key,
    required this.balance,
    required this.isMain,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return IgnorePointer(
      ignoring: !isMain,
      child: WCustomTappableButton(
        onTap: onTap,
        borderRadius: isMain
            ? const BorderRadius.only(
                bottomLeft: Radius.circular(12),
                bottomRight: Radius.circular(12),
              )
            : BorderRadius.circular(12),
        rippleColor: AppColors.white.withAlpha(50),
        child: Stack(
          children: [
            Container(
              alignment: Alignment.centerLeft,
              decoration: BoxDecoration(
                color: AppColors.dodgerBlue,
                borderRadius: isMain
                    ? const BorderRadius.only(
                        bottomLeft: Radius.circular(12),
                        bottomRight: Radius.circular(12),
                      )
                    : BorderRadius.circular(12),
              ),
              child: Stack(
                children: [
                  Positioned.fill(
                    left: 0,
                    right: 0,
                    child: SvgPicture.asset(
                      AppIcons.balancePattern,
                      fit: BoxFit.cover,
                      color: AppColors.white.withOpacity(0.07),
                    ),
                  ),
                  Container(
                    width: double.infinity,
                    padding: EdgeInsets.symmetric(vertical: isMain ? 8 : 10, horizontal: 12),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          LocaleKeys.balance.tr(),
                          style: context.textTheme.labelMedium
                              ?.copyWith(color: AppColors.white.withOpacity(0.8), fontSize: 13),
                        ),
                        const SizedBox(height: 2),
                        Text(
                          '${MyFunctions.getBalanceMessage(balance)} UZS',
                          style: context.textTheme.headlineMedium?.copyWith(
                            color: AppColors.white,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Positioned(
                    top: -20,
                    right: 0,
                    child: Transform.rotate(
                      angle: -pi / 10,
                      child: Image.asset(
                        AppImages.balanceWallet,
                        fit: BoxFit.fitWidth,
                        height: 110,
                        width: 110,
                        // color: AppColors.white.withOpacity(0.07),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
