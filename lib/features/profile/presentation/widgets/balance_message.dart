import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:i_watt_app/core/config/app_colors.dart';
import 'package:i_watt_app/core/util/extensions/build_context_extension.dart';
import 'package:i_watt_app/features/common/presentation/widgets/w_custom_tappable_button.dart';
import 'package:i_watt_app/features/profile/presentation/widgets/pay_with_card_sheet.dart';
import 'package:i_watt_app/generated/locale_keys.g.dart';

class BalanceMessage extends StatelessWidget {
  final String message;

  const BalanceMessage({
    super.key,
    required this.message,
  });

  @override
  Widget build(BuildContext context) {
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
                message,
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
}
