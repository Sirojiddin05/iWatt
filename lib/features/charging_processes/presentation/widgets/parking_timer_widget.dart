import 'dart:async';

import 'package:flutter/material.dart';
import 'package:i_watt_app/core/config/app_colors.dart';
import 'package:i_watt_app/core/util/extensions/build_context_extension.dart';
import 'package:i_watt_app/core/util/my_functions.dart';

class ParkingTimerWidget extends StatefulWidget {
  final bool isSmall;
  final int freeParkingMinutes;
  final String parkingStartTime;
  const ParkingTimerWidget({
    super.key,
    required this.freeParkingMinutes,
    required this.parkingStartTime,
    required this.isSmall,
  });

  @override
  State<ParkingTimerWidget> createState() => _ParkingTimerWidgetState();
}

class _ParkingTimerWidgetState extends State<ParkingTimerWidget> {
  late final Timer timer;
  int currentSeconds = 0;

  late Color textColor;
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
          textColor = AppColors.cyprus;
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
    return Text(
      MyFunctions.getFormattedTimerTime(currentSeconds),
      style: context.textTheme.headlineMedium?.copyWith(color: textColor),
    );
  }
}
