import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:i_watt_app/core/config/app_icons.dart';
import 'package:i_watt_app/features/common/presentation/widgets/w_scale_animation.dart';

class ClearFieldButton extends StatelessWidget {
  final VoidCallback onClear;
  const ClearFieldButton({
    super.key,
    required this.onClear,
  });

  @override
  Widget build(BuildContext context) {
    return WScaleAnimation(
      onTap: onClear,
      child: Padding(
        padding: const EdgeInsets.all(10),
        child: SvgPicture.asset(AppIcons.clearRounded),
      ),
    );
  }
}
