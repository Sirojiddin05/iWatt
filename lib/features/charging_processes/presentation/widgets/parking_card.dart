import 'dart:async';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:highlight_text/highlight_text.dart';
import 'package:i_watt_app/core/config/app_colors.dart';
import 'package:i_watt_app/core/config/app_icons.dart';
import 'package:i_watt_app/core/util/extensions/build_context_extension.dart';
import 'package:i_watt_app/core/util/my_functions.dart';
import 'package:i_watt_app/generated/locale_keys.g.dart';

class ParkingCard extends StatefulWidget {
  final String parkingStartTime;
  final int freeParkingMinutes;
  final String parkingPrice;
  const ParkingCard({
    super.key,
    required this.parkingStartTime,
    required this.freeParkingMinutes,
    required this.parkingPrice,
  });

  @override
  State<ParkingCard> createState() => _ParkingCardState();
}

class _ParkingCardState extends State<ParkingCard> {
  late final Timer timer;
  int currentSeconds = 0;
  // bool payedPeriodStarted;

  @override
  void initState() {
    super.initState();
    final DateTime startTime = DateTime.parse(widget.parkingStartTime);
    final DateTime now = DateTime.now();
    final int difference = now.difference(startTime).inSeconds;
    final freeParkingSeconds = widget.freeParkingMinutes * 60;
    if (difference < freeParkingSeconds) {
      currentSeconds = freeParkingSeconds - difference;
    } else {
      currentSeconds = difference - freeParkingSeconds;
    }
    timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (currentSeconds < freeParkingSeconds) {
        setState(() {
          currentSeconds = freeParkingSeconds - (difference + timer.tick);
        });
      } else {
        setState(() {
          currentSeconds = difference - freeParkingSeconds + timer.tick;
        });
      }
    });
  }

  @override
  void dispose() {
    timer.cancel();
    super.dispose();
  }

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
              Expanded(
                child: Material(
                  color: Colors.transparent,
                  child: TextHighlight(
                    text:
                        "${MyFunctions.getParkingTitle(widget.parkingStartTime, widget.freeParkingMinutes).tr()}:  ${MyFunctions.getFormattedTimerTime(currentSeconds)}",
                    textStyle: context.textTheme.bodyLarge,
                    words: {
                      MyFunctions.getFormattedTimerTime(currentSeconds): HighlightedWord(
                        textStyle: context.textTheme.bodyLarge!.copyWith(color: AppColors.amaranth),
                      ),
                    },
                  ),
                ),
              ),
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
                      "Прошло времени",
                      style: context.textTheme.titleSmall!.copyWith(color: AppColors.taxBreak, fontSize: 12),
                    ),
                    const SizedBox(height: 2),
                    Text(
                      "00:00:00",
                      style: context.textTheme.headlineSmall!.copyWith(color: AppColors.taxBreak),
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
                      "0 сум",
                      style: context.textTheme.headlineSmall!.copyWith(color: AppColors.taxBreak),
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
}
