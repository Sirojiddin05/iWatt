import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:i_watt_app/core/config/app_colors.dart';
import 'package:i_watt_app/core/config/app_icons.dart';
import 'package:i_watt_app/core/util/extensions/build_context_extension.dart';

class InfoContainer extends StatelessWidget {
  final String? title;
  final String infoText;
  final TextStyle? infoTextStyle;
  final TextStyle? titleTextStyle;
  final Color color;
  final String icon;
  final Color? iconColor;
  final EdgeInsets? margin;
  final Widget? suffix;
  const InfoContainer({
    super.key,
    required this.infoText,
    this.color = AppColors.dodgerBlue,
    this.margin,
    this.title,
    this.suffix,
    this.iconColor,
    this.infoTextStyle,
    this.titleTextStyle,
    this.icon = AppIcons.info,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: margin ?? const EdgeInsets.all(16),
      padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 12),
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Row(
        children: [
          SvgPicture.asset(icon, color: iconColor),
          const SizedBox(width: 10),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                if (title != null) ...{
                  Text(
                    title!,
                    style: titleTextStyle ?? context.textTheme.displaySmall?.copyWith(fontSize: 12),
                  ),
                  const SizedBox(height: 2),
                },
                Text(
                  infoText,
                  style: infoTextStyle ?? context.textTheme.headlineSmall,
                ),
              ],
            ),
          ),
          const SizedBox(width: 12),
          if (suffix != null) suffix!,
        ],
      ),
    );
  }
}
