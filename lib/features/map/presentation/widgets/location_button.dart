import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:i_watt_app/core/config/app_colors.dart';
import 'package:i_watt_app/core/config/app_icons.dart';
import 'package:i_watt_app/core/util/extensions/build_context_extension.dart';
import 'package:i_watt_app/features/common/presentation/widgets/w_custom_tappable_button.dart';
import 'package:i_watt_app/features/map/presentation/widgets/location__loading_icon.dart';

class LocateMeButton extends StatelessWidget {
  final VoidCallback onTap;
  final bool isLoading;

  const LocateMeButton({super.key, required this.onTap, required this.isLoading});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.fromLTRB(12, 8, 12, 24),
      padding: const EdgeInsets.all(4),
      decoration: BoxDecoration(
        color: AppColors.black.withOpacity(0.08),
        borderRadius: BorderRadius.circular(10),
      ),
      child: WCustomTappableButton(
        onTap: onTap,
        borderRadius: BorderRadius.circular(8),
        rippleColor: context.themedColors.cyprusToWhite.withAlpha(20),
        child: Container(
          padding: const EdgeInsets.all(8),
          decoration: BoxDecoration(
            color: context.colorScheme.background,
            borderRadius: BorderRadius.circular(8),
            boxShadow: [
              BoxShadow(offset: const Offset(0, 4), blurRadius: 6, color: context.theme.shadowColor),
              BoxShadow(offset: const Offset(0, 1), spreadRadius: 1, color: context.theme.shadowColor),
            ],
          ),
          child: AnimatedSwitcher(
            duration: const Duration(milliseconds: 150),
            child: isLoading
                ? AnimatedLocationIcon(color: context.themedColors.cyprusToBlueBayoux)
                : SvgPicture.asset(AppIcons.myLocation, color: context.themedColors.cyprusToBlueBayoux),
          ),
        ),
      ),
    );
  }
}
