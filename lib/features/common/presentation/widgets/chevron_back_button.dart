import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:i_watt_app/core/config/app_icons.dart';

class ChevronBackButton extends StatelessWidget {
  final VoidCallback? onTap;
  final EdgeInsets? padding;
  const ChevronBackButton({super.key, this.onTap, this.padding});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap ?? () => Navigator.pop(context),
      behavior: HitTestBehavior.opaque,
      child: Padding(
        padding: padding ?? const EdgeInsets.all(16),
        child: SvgPicture.asset(AppIcons.chevronLeftBlack),
      ),
    );
  }
}
