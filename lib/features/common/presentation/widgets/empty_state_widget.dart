import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:i_watt_app/core/config/app_colors.dart';
import 'package:i_watt_app/core/util/extensions/build_context_extension.dart';

class EmptyStateWidget extends StatelessWidget {
  final String icon;
  final String title;
  final String subtitle;
  final TextStyle? titleTextStyle;
  final TextStyle? subtitleTextStyle;
  final double? sizeBetweenTitleSubtitle;
  final double? sizeBetweenIconTitle;
  const EmptyStateWidget(
      {super.key,
      this.icon = '',
      required this.title,
      required this.subtitle,
      this.titleTextStyle,
      this.subtitleTextStyle,
      this.sizeBetweenTitleSubtitle,
      this.sizeBetweenIconTitle});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          if (icon.contains('.svg'))
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 32),
              child: SvgPicture.asset(
                icon,
                height: 100,
              ),
            )
          else if (icon.contains('.png'))
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 32),
              child: Image.asset(
                icon,
                height: 164,
                width: 164,
              ),
            ),
          SizedBox(height: sizeBetweenIconTitle ?? 8),
          Text(
            title,
            style: titleTextStyle ?? context.textTheme.displayLarge!,
            textAlign: TextAlign.center,
          ),
          SizedBox(height: sizeBetweenTitleSubtitle ?? 8),
          Text(
            subtitle,
            style: subtitleTextStyle ?? context.textTheme.labelMedium?.copyWith(color: AppColors.taxBreak),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 24),
        ],
      ),
    );
  }
}
