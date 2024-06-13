import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:i_watt_app/core/config/app_colors.dart';
import 'package:i_watt_app/core/config/app_icons.dart';
import 'package:i_watt_app/core/util/extensions/build_context_extension.dart';
import 'package:i_watt_app/core/util/my_functions.dart';
import 'package:i_watt_app/features/charging_processes/domain/entities/transaction_entity.dart';
import 'package:i_watt_app/features/common/presentation/widgets/w_custom_tappable_button.dart';

class TransactionHistoryItem extends StatelessWidget {
  final TransactionEntity transaction;

  final VoidCallback onTap;
  const TransactionHistoryItem({required this.transaction, super.key, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return WCustomTappableButton(
      onTap: onTap,
      rippleColor: AppColors.brightSun.withAlpha(20),
      borderRadius: BorderRadius.circular(6),
      child: Container(
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(color: AppColors.white, borderRadius: BorderRadius.circular(12), boxShadow: [
          BoxShadow(
            offset: const Offset(0, 6),
            blurRadius: 32,
            color: AppColors.taxBreak.withOpacity(.16),
          ),
        ]),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Container(
              padding: const EdgeInsets.all(6),
              decoration: BoxDecoration(
                color: AppColors.white2,
                borderRadius: BorderRadius.circular(6),
                border: Border.all(color: context.theme.dividerColor),
              ),
              child: SvgPicture.asset(AppIcons.roundedPlug),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    transaction.locationName,
                    style: context.textTheme.titleMedium?.copyWith(fontSize: 12),
                  ),
                  Text(
                    transaction.vendorName,
                    style: context.textTheme.titleMedium?.copyWith(fontSize: 12),
                  ),
                ],
              ),
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Text(
                  DateFormat("dd.MM.yyyy").format(DateTime.tryParse(transaction.createdAt)?.toLocal() ?? DateTime.now()).toString(),
                  style: context.textTheme.labelMedium!.copyWith(
                    color: AppColors.taxBreak,
                  ),
                ),
                const SizedBox(height: 2),
                Text(
                  '- ${MyFunctions.getPrice(transaction.totalPrice)} UZS',
                  style: context.textTheme.headlineMedium!.copyWith(
                    color: AppColors.amaranth,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
