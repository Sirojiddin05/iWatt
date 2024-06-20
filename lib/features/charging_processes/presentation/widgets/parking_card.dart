import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:i_watt_app/core/config/app_colors.dart';
import 'package:i_watt_app/core/config/app_icons.dart';
import 'package:i_watt_app/core/util/extensions/build_context_extension.dart';
import 'package:i_watt_app/core/util/my_functions.dart';
import 'package:i_watt_app/generated/locale_keys.g.dart';

class ParkingCard extends StatefulWidget {
  final bool isPayedPeriodStarted;
  final int payedParkingLasts;
  final int payedParkingWillStartAfter;
  final String parkingPrice;
  const ParkingCard({
    super.key,
    required this.payedParkingWillStartAfter,
    required this.payedParkingLasts,
    required this.isPayedPeriodStarted,
    required this.parkingPrice,
  });

  @override
  State<ParkingCard> createState() => _ParkingCardState();
}

class _ParkingCardState extends State<ParkingCard> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(12),
      margin: const EdgeInsets.symmetric(horizontal: 16),
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: AppColors.solitude,
          width: 1,
        ),
      ),
      child: Column(
        children: [
          Row(
            children: [
              SvgPicture.asset(AppIcons.parking),
              const SizedBox(width: 4),
              Text(
                getTitleText(),
                style: context.textTheme.bodyLarge,
              ),
              if (!widget.isPayedPeriodStarted) ...{
                Text(
                  ' ${MyFunctions.getFormattedTimerTime(widget.payedParkingWillStartAfter)}',
                  style: context.textTheme.bodyLarge?.copyWith(color: AppColors.amaranth),
                ),
              }
            ],
          ),
          const SizedBox(height: 8),
          Row(
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      LocaleKeys.time_passed.tr(),
                      style: context.textTheme.titleSmall!.copyWith(color: AppColors.taxBreak, fontSize: 12),
                    ),
                    const SizedBox(height: 2),
                    Text(
                      MyFunctions.getFormattedTimerTime(widget.payedParkingLasts, includeHours: true),
                      style: context.textTheme.headlineSmall,
                    ),
                  ],
                ),
              ),
              Container(
                width: 1,
                height: 36,
                margin: const EdgeInsets.symmetric(horizontal: 12),
                color: AppColors.solitude,
              ),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      LocaleKeys.total.tr(),
                      style: context.textTheme.titleSmall!.copyWith(color: AppColors.taxBreak, fontSize: 12),
                    ),
                    const SizedBox(height: 2),
                    Text(
                      '${getPrice().replaceAll('UZS', '')} ${LocaleKeys.sum.tr()}',
                      style: context.textTheme.headlineSmall,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  String getPrice() {
    if (widget.parkingPrice.isNotEmpty) {
      return MyFunctions.getPrice(widget.parkingPrice);
    }
    return '0';
  }

  String getTitleText() {
    final text = MyFunctions.getParkingTitle(widget.isPayedPeriodStarted).tr();
    if (widget.isPayedPeriodStarted) {
      return text;
    }
    return '$text:';
  }
}
