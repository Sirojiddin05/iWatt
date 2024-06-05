import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:i_watt_app/core/config/app_colors.dart';
import 'package:i_watt_app/core/config/app_icons.dart';
import 'package:i_watt_app/core/util/extensions/build_context_extension.dart';
import 'package:i_watt_app/features/charging_processes/domain/entities/charging_process_entity.dart';
import 'package:i_watt_app/features/charging_processes/presentation/pages/charging_process_sheet.dart';
import 'package:i_watt_app/features/charging_processes/presentation/widgets/charging_car_animation_widget.dart';
import 'package:i_watt_app/features/charging_processes/presentation/widgets/icon_data_row.dart';
import 'package:i_watt_app/features/common/domain/entities/meter_value_message.dart';
import 'package:i_watt_app/features/common/presentation/widgets/w_custom_tappable_button.dart';
import 'package:i_watt_app/generated/locale_keys.g.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';

class ChargingCarDataWidget extends StatefulWidget {
  final ChargingProcessEntity process;
  final String locationName;
  final MeterValueMessageEntity meterValue;

  const ChargingCarDataWidget({
    super.key,
    required this.process,
    required this.locationName,
    required this.meterValue,
  });

  @override
  State<ChargingCarDataWidget> createState() => _ChargingCarDataWidgetState();
}

class _ChargingCarDataWidgetState extends State<ChargingCarDataWidget> {
  final List<String> iconData = [
    AppIcons.timerYellow,
    AppIcons.batteryChargeMinimalistic,
    AppIcons.flash,
    AppIcons.billCheck,
    AppIcons.parking,
  ];

  @override
  Widget build(BuildContext context) {
    return WCustomTappableButton(
      onTap: () {
        showCupertinoModalBottomSheet(
          context: context,
          builder: (ctx) {
            return ChargingProcessSheet(connector: widget.process.connector, locationName: widget.process.locationName);
          },
        );
      },
      borderRadius: BorderRadius.circular(12),
      rippleColor: AppColors.cyprusRipple30,
      child: Container(
        padding: const EdgeInsets.fromLTRB(16, 12, 16, 16),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: AppColors.dividerSolitude),
          color: AppColors.white,
          boxShadow: [
            BoxShadow(
              color: AppColors.baliHai.withOpacity(.16),
              spreadRadius: 0,
              blurRadius: 32,
              offset: const Offset(0, 6),
            )
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SvgPicture.asset(
                  AppIcons.plugRight,
                  color: widget.meterValue.batteryPercent == -1 ? AppColors.brightSun : AppColors.limeGreen,
                  width: 16,
                  height: 16,
                ),
                const SizedBox(width: 4),
                Expanded(
                  child: Text(
                    widget.meterValue.batteryPercent == -1
                        ? LocaleKeys.charging_is_starting.tr()
                        : widget.meterValue.batteryPercent == 100
                            ? LocaleKeys.charging_is_ended.tr()
                            : LocaleKeys.charging.tr(),
                    style: context.textTheme.headlineLarge,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 6),
            Text(
              widget.locationName,
              style: context.textTheme.titleLarge!.copyWith(color: AppColors.taxBreak),
            ),
            const SizedBox(height: 16),
            const Divider(height: 1, thickness: 1, color: AppColors.solitude),
            const SizedBox(height: 8),
            Row(
              children: [
                Flexible(
                  child: Column(
                    children: [
                      // currentPower: '${meterValue.batteryPercent} %',
                      // timeLeft: "-",
                      // charged: "${meterValue.consumedKwh} ${LocaleKeys.kW.tr()}",
                      // paid: meterValue.money.isEmpty ? '-' : "${meterValue.money} ${LocaleKeys.sum.tr()}",
                      // IconDataRow(icon: AppIcons.timerYellow, value: widget.process.estimatedTime),
                      const SizedBox(height: 10),
                      IconDataRow(icon: AppIcons.batteryChargeMinimalistic, value: "${widget.process.meterValue.batteryPercent}%"),
                      const SizedBox(height: 10),
                      IconDataRow(icon: AppIcons.flash, value: "${widget.process.meterValue.consumedKwh} ${LocaleKeys.kW.tr()}"),
                      const SizedBox(height: 10),
                      IconDataRow(icon: AppIcons.billCheck, value: '${widget.process.meterValue.money} ${LocaleKeys.sum.tr()}'),
                      const SizedBox(height: 10),
                      IconDataRow(icon: AppIcons.parking, value: '${widget.process.connector.parkingPrice} ${LocaleKeys.sum}'),
                    ],
                  ),
                ),
                Flexible(
                  flex: 3,
                  child: ChargingCarAnimationWidget(
                    percentage: widget.process.meterValue.batteryPercent,
                    scale: 0.6,
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
