import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:i_watt_app/core/config/app_colors.dart';
import 'package:i_watt_app/core/config/app_icons.dart';
import 'package:i_watt_app/core/util/extensions/build_context_extension.dart';
import 'package:i_watt_app/core/util/my_functions.dart';
import 'package:i_watt_app/features/charging_processes/domain/entities/charging_process_entity.dart';
import 'package:i_watt_app/features/charging_processes/presentation/pages/charging_process_sheet.dart';
import 'package:i_watt_app/features/charging_processes/presentation/widgets/charging_car_animation_widget.dart';
import 'package:i_watt_app/features/charging_processes/presentation/widgets/icon_data_row.dart';
import 'package:i_watt_app/features/common/presentation/widgets/w_custom_tappable_button.dart';
import 'package:i_watt_app/generated/locale_keys.g.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';

class ChargingCarDataWidget extends StatefulWidget {
  final ChargingProcessEntity process;

  const ChargingCarDataWidget({
    super.key,
    required this.process,
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
          useRootNavigator: true,
          builder: (ctx) {
            return ChargingProcessSheet(
              connector: widget.process.connector,
              locationName: widget.process.locationName,
            );
          },
        );
      },
      borderRadius: BorderRadius.circular(12),
      rippleColor: AppColors.cyprusRipple30,
      child: Stack(
        children: [
          Container(
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
                      color: getPlugIconColor(),
                      width: 16,
                      height: 16,
                    ),
                    const SizedBox(width: 4),
                    Expanded(
                      child: Text(
                        getTitleText(),
                        style: context.textTheme.headlineLarge,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 6),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Text(
                      getSubtitleText(),
                      style: context.textTheme.titleLarge!.copyWith(color: AppColors.taxBreak),
                    ),
                    if (widget.process.freeParkingMinutes != -1) ...{
                      Text(
                        ' ${getTime()}',
                        style: context.textTheme.titleMedium!.copyWith(
                          color: !widget.process.isPayedParkingStarted ? AppColors.amaranth : null,
                        ),
                      ),
                    }
                  ],
                ),
                const SizedBox(height: 16),
                const Divider(height: 1, thickness: 1, color: AppColors.solitude),
                const SizedBox(height: 8),
                IconDataRow(
                  icon: AppIcons.timerYellow,
                  value: widget.process.estimatedTime,
                ),
                const SizedBox(height: 10),
                IconDataRow(
                  icon: AppIcons.batteryChargeMinimalistic,
                  value: "${widget.process.consumedKwh} ${LocaleKeys.kW.tr()}",
                ),
                const SizedBox(height: 10),
                IconDataRow(
                  icon: AppIcons.flash,
                  value: "${widget.process.currentKwh} ${LocaleKeys.kW.tr()}",
                ),
                const SizedBox(height: 10),
                IconDataRow(
                  icon: AppIcons.billCheck,
                  value: '${MyFunctions.getPrice(widget.process.money)} ${LocaleKeys.sum.tr()}',
                ),
                const SizedBox(height: 10),
                IconDataRow(
                  icon: AppIcons.parking,
                  value: '${MyFunctions.getPrice(widget.process.payedParkingPrice.toString())} ${LocaleKeys.sum}',
                ),
              ],
            ),
          ),
          Positioned(
            right: 0,
            top: 106,
            bottom: 24,
            child: ChargingCarAnimationWidget(
              percentage: widget.process.batteryPercent,
              carScale: 1,
              batteryScale: 1,
              fontSize: 26,
              percentageFontWeight: FontWeight.w800,
              percentageSignFontWeight: FontWeight.w900,
            ),
          ),
        ],
      ),
    );
  }

  Color getPlugIconColor() {
    if (widget.process.freeParkingMinutes != -1 || widget.process.batteryPercent == -1) {
      return AppColors.brightSun;
    }
    return AppColors.limeGreen;
  }

  String getTitleText() {
    if (widget.process.freeParkingMinutes != -1) {
      return LocaleKeys.pause.tr();
    } else if (widget.process.batteryPercent == -1) {
      return LocaleKeys.charging_is_starting.tr();
    } else if (widget.process.batteryPercent == 100) {
      return LocaleKeys.charging_is_ended.tr();
    }
    return LocaleKeys.charging.tr();
  }

  String getSubtitleText() {
    if (widget.process.freeParkingMinutes != -1) {
      return MyFunctions.getParkingTitle(widget.process.isPayedParkingStarted).tr();
    } else {
      return widget.process.locationName;
    }
  }

  String getTime() {
    if (widget.process.isPayedParkingStarted) {
      return MyFunctions.getFormattedTimerTime(widget.process.payedParkingLasts);
    }
    return MyFunctions.getFormattedTimerTime(widget.process.payedParkingWillStartAfter);
  }
}
