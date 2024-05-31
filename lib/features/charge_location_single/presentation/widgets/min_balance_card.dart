import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:i_watt_app/core/config/app_images.dart';
import 'package:i_watt_app/core/util/extensions/build_context_extension.dart';
import 'package:i_watt_app/core/util/my_functions.dart';
import 'package:i_watt_app/features/charge_location_single/presentation/widgets/location_single_card_wrapper.dart';
import 'package:i_watt_app/generated/locale_keys.g.dart';

class MinBalanceCard extends StatelessWidget {
  final String minBalance;
  const MinBalanceCard({super.key, required this.minBalance});

  @override
  Widget build(BuildContext context) {
    return LocationSingleCardWrapper(
      margin: const EdgeInsets.fromLTRB(16, 16, 16, 8),
      padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 14),
      child: Row(
        children: [
          Image.asset(AppImages.balanceMessage, height: 36, width: 36),
          const SizedBox(width: 8),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                LocaleKeys.minimum_balance_to_start.tr(),
                style: context.textTheme.titleLarge!.copyWith(
                  fontSize: 13,
                ),
              ),
              Text(
                '${MyFunctions.formatNumber(minBalance.split('.').first)} UZS',
                style: context.textTheme.displaySmall!.copyWith(
                  fontSize: 13,
                  color: context.colorScheme.primary,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
