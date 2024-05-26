import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:i_watt_app/core/config/app_constants.dart';
import 'package:i_watt_app/core/config/app_icons.dart';
import 'package:i_watt_app/core/util/extensions/build_context_extension.dart';
import 'package:i_watt_app/core/util/my_functions.dart';

class ResendOtpWidget extends StatelessWidget {
  final int leftSeconds;
  final VoidCallback onResend;
  const ResendOtpWidget({super.key, required this.leftSeconds, required this.onResend});

  @override
  Widget build(BuildContext context) {
    return AnimatedSwitcher(
      duration: AppConstants.animationDuration,
      transitionBuilder: (child, animation) {
        return SizeTransition(
          sizeFactor: animation,
          axis: Axis.horizontal,
          child: ScaleTransition(
            scale: animation,
            child: child,
          ),
        );
      },
      child: leftSeconds == 0
          ? GestureDetector(
              onTap: onResend,
              behavior: HitTestBehavior.opaque,
              child: Padding(
                padding: const EdgeInsets.all(4),
                child: SvgPicture.asset(
                  AppIcons.resend,
                ),
              ),
            )
          : Container(
              padding: const EdgeInsets.only(left: 4, top: 2),
              width: 42,
              alignment: Alignment.center,
              child: Text(
                MyFunctions.getFormattedTimerTime(leftSeconds),
                style: context.textTheme.titleMedium?.copyWith(fontSize: 13),
              ),
            ),
    );
  }
}
