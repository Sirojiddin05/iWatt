import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:i_watt_app/core/config/app_colors.dart';
import 'package:i_watt_app/core/util/extensions/build_context_extension.dart';
import 'package:i_watt_app/core/util/my_functions.dart';
import 'package:i_watt_app/features/common/presentation/widgets/w_custom_tappable_button.dart';
import 'package:i_watt_app/features/profile/presentation/blocs/profile_bloc/profile_bloc.dart';
import 'package:i_watt_app/features/profile/presentation/widgets/balance_info_item.dart';
import 'package:i_watt_app/features/profile/presentation/widgets/pay_with_card_sheet.dart';
import 'package:i_watt_app/features/profile/presentation/widgets/top_up_bottom_sheet.dart';
import 'package:i_watt_app/generated/locale_keys.g.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';

class BalanceMessage extends StatelessWidget {
  final bool isMain;
  final EdgeInsets margin;
  const BalanceMessage({
    super.key,
    this.isMain = true,
    this.margin = const EdgeInsets.symmetric(horizontal: 12),
  });

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ProfileBloc, ProfileState>(
      buildWhen: (p, c) => p.user.balance != c.user.balance,
      builder: (context, state) {
        if (!state.user.balance.contains('-')) {
          return Padding(
            padding: margin,
            child: BalanceInfoItem(
              balance: state.user.balance,
              isMain: isMain,
              onTap: () {
                showCupertinoModalBottomSheet(
                  context: context,
                  useRootNavigator: true,
                  shape: const RoundedRectangleBorder(
                    borderRadius: BorderRadius.vertical(
                      top: Radius.circular(12),
                    ),
                  ),
                  overlayStyle: SystemUiOverlayStyle.dark.copyWith(
                    statusBarIconBrightness: Brightness.light,
                    statusBarBrightness: Brightness.dark,
                    systemNavigationBarColor: AppColors.white,
                  ),
                  builder: (context) => const TopUpBottomSheet(),
                );
              },
            ),
          );
        } else {
          return Padding(
            padding: margin,
            child: WCustomTappableButton(
              onTap: () {
                showPayWithCardSheet(context);
              },
              borderRadius: isMain
                  ? const BorderRadius.only(
                      bottomLeft: Radius.circular(12),
                      bottomRight: Radius.circular(12),
                    )
                  : BorderRadius.circular(12),
              rippleColor: AppColors.white.withAlpha(50),
              child: Container(
                alignment: Alignment.centerLeft,
                decoration: BoxDecoration(
                  color: AppColors.amaranth,
                  borderRadius: isMain
                      ? const BorderRadius.only(
                          bottomLeft: Radius.circular(12),
                          bottomRight: Radius.circular(12),
                        )
                      : BorderRadius.circular(12),
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
