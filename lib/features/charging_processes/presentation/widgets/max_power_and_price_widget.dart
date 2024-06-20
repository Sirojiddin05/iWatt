import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:i_watt_app/core/config/app_icons.dart';
import 'package:i_watt_app/features/charging_processes/presentation/widgets/charging_info_card.dart';
import 'package:i_watt_app/generated/locale_keys.g.dart';

class MaxPowerAndPriceWidget extends StatelessWidget {
  final String maxPower;
  final String price;
  const MaxPowerAndPriceWidget({
    super.key,
    required this.maxPower,
    required this.price,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Row(
        children: [
          Expanded(
            child: ChargingInfoCard(
              label: LocaleKeys.max_power.tr(),
              value: '$maxPower ${LocaleKeys.kW.tr()}',
              icon: AppIcons.flash,
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: ChargingInfoCard(
              label: LocaleKeys.price.tr(),
              value: '$price ${LocaleKeys.sum.tr()}/${LocaleKeys.kW.tr()}',
              icon: AppIcons.tagPrice,
            ),
          ),
        ],
      ),
    );
  }
}
