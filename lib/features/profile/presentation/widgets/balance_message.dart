import 'dart:math';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:i_watt_app/core/config/app_colors.dart';
import 'package:i_watt_app/core/config/app_icons.dart';
import 'package:i_watt_app/core/config/app_images.dart';
import 'package:i_watt_app/core/util/extensions/build_context_extension.dart';
import 'package:i_watt_app/core/util/my_functions.dart';
import 'package:i_watt_app/features/common/presentation/widgets/w_custom_tappable_button.dart';
import 'package:i_watt_app/features/profile/presentation/blocs/profile_bloc/profile_bloc.dart';
import 'package:i_watt_app/features/profile/presentation/widgets/pay_with_card_sheet.dart';
import 'package:i_watt_app/features/profile/presentation/widgets/payment_bottom_sheet.dart';
import 'package:i_watt_app/generated/locale_keys.g.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';

class BalanceMessage extends StatelessWidget {
  const BalanceMessage({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ProfileBloc, ProfileState>(
      buildWhen: (p, c) => p.user.balance != c.user.balance,
      builder: (context, state) {
        if (!state.user.balance.contains('-')) {
          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12),
            child: WCustomTappableButton(
              onTap: () {
                 showCupertinoModalBottomSheet(
                  context: context,
                  useRootNavigator: true,
                  shape: const RoundedRectangleBorder(
                    borderRadius: BorderRadius.vertical(
                      top: Radius.circular(12),
                    ),
                  ),
                  builder: (context) => const PaymentBottomSheet(),
                );
              },
              borderRadius: const BorderRadius.only(
                bottomLeft: Radius.circular(12),
                bottomRight: Radius.circular(12),
              ),
              rippleColor: AppColors.white.withAlpha(50),
              child: Stack(
                children: [
                  Container(
                    alignment: Alignment.centerLeft,
                    decoration: const BoxDecoration(
                      color: AppColors.dodgerBlue,
                      borderRadius: BorderRadius.only(
                        bottomLeft: Radius.circular(12),
                        bottomRight: Radius.circular(12),
                      ),
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
                          padding: const EdgeInsets.symmetric(vertical: 6, horizontal: 8),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                LocaleKeys.balance.tr(),
                                style: context.textTheme.labelMedium?.copyWith(
                                  color: AppColors.white.withOpacity(0.8),
                                ),
                              ),
                              const SizedBox(height: 2),
                              Text(
                                '${MyFunctions.getBalanceMessage(state.user.balance)} UZS',
                                style: context.textTheme.headlineMedium?.copyWith(
                                  color: AppColors.white,
                                ),
                              ),
                            ],
                          ),
                        ),
                        Positioned(
                          top: -33,
                          right: 0,
                          bottom: -50,
                          child: Transform.rotate(
                            angle: -pi / 10,
                            child: Image.asset(
                              AppImages.balanceWallet,
                              fit: BoxFit.fitWidth,
                              height: 100,
                              width: 100,
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
        } else {
          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12),
            child: WCustomTappableButton(
              onTap: () {
                showPayWithCardSheet(context);
              },
              borderRadius: const BorderRadius.only(
                bottomLeft: Radius.circular(12),
                bottomRight: Radius.circular(12),
              ),
              rippleColor: AppColors.white.withAlpha(50),
              child: Container(
                alignment: Alignment.centerLeft,
                decoration: const BoxDecoration(
                  color: AppColors.amaranth,
                  borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(12),
                    bottomRight: Radius.circular(12),
                  ),
                ),
                padding: const EdgeInsets.symmetric(vertical: 6, horizontal: 8),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      LocaleKeys.you_have_a_debt_of.tr(),
                      style: context.textTheme.labelMedium?.copyWith(
                        color: AppColors.white.withOpacity(0.8),
                      ),
                    ),
                    const SizedBox(height: 2),
                    Text(
                      '${MyFunctions.getBalanceMessage(state.user.balance)} UZS',
                      style: context.textTheme.headlineMedium?.copyWith(
                        color: AppColors.white,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        }

      },
    );
  }
}
