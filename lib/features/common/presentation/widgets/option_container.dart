import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:i_watt_app/core/config/app_colors.dart';
import 'package:i_watt_app/core/util/extensions/build_context_extension.dart';
import 'package:i_watt_app/features/common/presentation/widgets/w_custom_tappable_button.dart';

class OptionContainer extends StatelessWidget {
  final String title;
  final Widget content;
  final String icon;
  final VoidCallback onTap;
  const OptionContainer({
    super.key,
    required this.content,
    this.icon = '',
    required this.onTap,
    required this.title,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: context.textTheme.titleMedium?.copyWith(
            fontSize: 12,
            color: AppColors.darkGray,
          ),
        ),
        const SizedBox(height: 6),
        WCustomTappableButton(
          onTap: onTap,
          borderRadius: BorderRadius.circular(8),
          rippleColor: AppColors.cyprus.withAlpha(30),
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8),
              border: Border.all(
                color: AppColors.fieldBorderZircon,
              ),
            ),
            padding: const EdgeInsets.all(12),
            child: Row(
              children: [
                Expanded(child: content),
                if (icon.isNotEmpty) ...{
                  SvgPicture.asset(icon),
                }
              ],
            ),
          ),
        )
      ],
    );
  }
}
