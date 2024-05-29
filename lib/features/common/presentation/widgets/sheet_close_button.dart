import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:i_watt_app/core/config/app_icons.dart';

class SheetCloseButton extends StatelessWidget {
  final VoidCallback onTap;
  final EdgeInsets? padding;
  const SheetCloseButton({super.key, required this.onTap, this.padding});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      behavior: HitTestBehavior.opaque,
      child: Padding(
        padding: padding ?? const EdgeInsets.fromLTRB(16, 8, 16, 16),
        child: SvgPicture.asset(AppIcons.closeBoldGrey),
      ),
    );
  }
}
