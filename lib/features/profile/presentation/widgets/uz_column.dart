import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:i_watt_app/core/config/app_icons.dart';

class UzColumn extends StatelessWidget {
  const UzColumn({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [SvgPicture.asset(AppIcons.bigFlag), const SizedBox(height: 4), SvgPicture.asset(AppIcons.bigUz, width: 12)],
    );
  }
}
