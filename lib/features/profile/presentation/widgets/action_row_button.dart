import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:i_watt_app/core/util/extensions/build_context_extension.dart';
import 'package:i_watt_app/features/common/presentation/widgets/w_custom_tappable_button.dart';

class IconTextButton extends StatelessWidget {
  final String title;
  final VoidCallback onTap;
  final String icon;
  final List<Widget> actions;
  final BorderRadius borderRadius;
  final EdgeInsets padding;
  final Color? rippleColor;
  final bool includeTopDivider;
  final bool includeBottomDivider;

  const IconTextButton({
    required this.title,
    required this.onTap,
    required this.icon,
    this.actions = const [],
    this.borderRadius = BorderRadius.zero,
    this.padding = const EdgeInsets.symmetric(vertical: 8, horizontal: 12),
    super.key,
    this.rippleColor,
    this.includeTopDivider = false,
    this.includeBottomDivider = false,
  });

  @override
  Widget build(BuildContext context) {
    return WCustomTappableButton(
      onTap: onTap,
      borderRadius: borderRadius,
      rippleColor: rippleColor ?? context.theme.primaryColor.withAlpha(30),
      child: Padding(
        padding: padding,
        child: Row(
          children: [
            SvgPicture.asset(icon),
            const SizedBox(width: 12),
            Expanded(
              child: Text(title, style: context.textTheme.titleLarge?.copyWith(fontSize: 15)),
            ),
            ...actions,
          ],
        ),
      ),
    );
  }
}
