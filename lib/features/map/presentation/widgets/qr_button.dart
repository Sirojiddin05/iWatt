import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:i_watt_app/core/config/app_colors.dart';
import 'package:i_watt_app/core/util/extensions/build_context_extension.dart';
import 'package:i_watt_app/features/common/presentation/widgets/w_custom_tappable_button.dart';

class QrButton extends StatelessWidget {
  final VoidCallback onTap;

  const QrButton({super.key, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return Container(
      // padding: const EdgeInsets.fromLTRB(16, 0, 16, 32),
      margin: const EdgeInsets.fromLTRB(12, 0, 12, 28),
      padding: const EdgeInsets.all(4),
      decoration: BoxDecoration(
        color: AppColors.black.withOpacity(0.08),
        borderRadius: BorderRadius.circular(10),
      ),
      child: WCustomTappableButton(
        onTap: onTap,
        borderRadius: BorderRadius.circular(8),
        rippleColor: AppColors.cyprus.withAlpha(20),
        child: Container(
          padding: const EdgeInsets.all(8),
          decoration: BoxDecoration(
            color: context.colorScheme.surface,
            borderRadius: BorderRadius.circular(8),
            boxShadow: [
              BoxShadow(offset: const Offset(0, 4), blurRadius: 6, color: context.theme.shadowColor),
              BoxShadow(offset: const Offset(0, 1), spreadRadius: 1, color: context.theme.shadowColor),
              // BoxShadow(offset: const Offset(0, 0), blurRadius: 0, spreadRadius: 4, color: context.theme.shadowColor),
            ],
          ),
          child: AnimatedSwitcher(
            duration: const Duration(milliseconds: 150),
            child: SvgPicture.asset(context.themedIcons.qrScan),
          ),
        ),
      ),
    );
  }
}
