import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:i_watt_app/core/config/app_icons.dart';
import 'package:i_watt_app/core/util/extensions/build_context_extension.dart';

class StationBackgroundImage extends StatelessWidget {
  const StationBackgroundImage({super.key});

  @override
  Widget build(BuildContext context) {
    return Positioned.fill(
      child: Padding(
        padding: const EdgeInsets.only(top: 16, bottom: 20),
        child: SvgPicture.asset(AppIcons.stationBackground, color: context.themedColors.whiteToWhiteO4),
      ),
    );
  }
}
