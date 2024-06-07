import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:i_watt_app/core/config/app_colors.dart';
import 'package:i_watt_app/core/config/app_icons.dart';
import 'package:i_watt_app/core/util/extensions/build_context_extension.dart';

class InfoContainer extends StatelessWidget {
  final String infoText;
  final String? title;
  final Color color;
  final EdgeInsets? margin;
  final Widget? suffix;
  final Color? iconColor;
  final TextStyle? subtitleStyle;
  const InfoContainer({
    super.key,
    required this.infoText,
    this.color = AppColors.dodgerBlue,
    this.margin,
    this.title,
    this.suffix,
    this.iconColor,
    this.subtitleStyle,
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
          SvgPicture.asset(AppIcons.info, color: iconColor),
          const SizedBox(width: 10),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                if (title != null) ...{
                  Text(
                    title!,
                    style: context.textTheme.displaySmall?.copyWith(fontSize: 12),
                  ),
                  const SizedBox(height: 2),
                },
                Text(
                  infoText,
                  style: subtitleStyle ?? context.textTheme.headlineSmall,
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
