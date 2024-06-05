import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:i_watt_app/core/config/app_icons.dart';
import 'package:i_watt_app/core/util/extensions/build_context_extension.dart';

class FacilityTitleWidget extends StatelessWidget {
  final String icon;
  final String title;

  const FacilityTitleWidget({super.key, required this.icon, required this.title});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        // SvgPicture.asset(icon, color: context.theme.primaryColor),
        if (icon.isNotEmpty && icon.contains("https") && icon.contains("svg")) ...{
          SvgPicture.network(icon, width: 16, height: 16),
          const SizedBox(width: 4),
        } else ...{
          SvgPicture.asset(AppIcons.iconPlaceHolder, width: 16, height: 16),
        },
        const SizedBox(width: 8),
        Text(
          title,
          style: context.textTheme.headlineLarge,
        ),
      ],
    );
  }
}
