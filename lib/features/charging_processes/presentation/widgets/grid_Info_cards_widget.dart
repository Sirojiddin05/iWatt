import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:i_watt_app/core/config/app_colors.dart';
import 'package:i_watt_app/core/config/app_icons.dart';
import 'package:i_watt_app/core/util/extensions/build_context_extension.dart';
import 'package:i_watt_app/features/charging_processes/presentation/widgets/charging_info_card.dart';
import 'package:i_watt_app/generated/locale_keys.g.dart';

class GridInfoCardsWidget extends StatelessWidget {
  final String currentPower;
  final String timeLeft;
  final String charged;
  final String paid;
  const GridInfoCardsWidget({
    super.key,
    required this.currentPower,
    required this.timeLeft,
    required this.charged,
    required this.paid,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Column(
        children: [
          Row(
            children: [
              Expanded(
                child: ChargingInfoCard(
                  backgroundColor: AppColors.solitude,
                  label: LocaleKeys.current_power.tr(),
                  value: charged,
                  icon: AppIcons.flash,
                  iconColor: context.theme.primaryColor,
                  valueTextStyle: context.textTheme.headlineMedium,
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: ChargingInfoCard(
                  backgroundColor: AppColors.solitude,
                  label: LocaleKeys.time_left.tr(),
                  value: timeLeft,
                  icon: AppIcons.timerYellow,
                  valueTextStyle: context.textTheme.headlineMedium,
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          Row(
            children: [
              Expanded(
                child: ChargingInfoCard(
                  backgroundColor: AppColors.solitude,
                  label: LocaleKeys.charged.tr(),
                  value: currentPower,
                  icon: AppIcons.batteryChargeMinimalistic,
                  valueTextStyle: context.textTheme.headlineMedium,
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: ChargingInfoCard(
                  backgroundColor: AppColors.solitude,
                  label: LocaleKeys.payed.tr(),
                  value: paid,
                  icon: AppIcons.billCheck,
                  valueTextStyle: context.textTheme.headlineMedium,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
