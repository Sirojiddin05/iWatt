import 'package:flutter/cupertino.dart';
import 'package:i_watt_app/core/config/app_colors.dart';
import 'package:i_watt_app/features/common/presentation/widgets/w_custom_tappable_button.dart';

class LocationSingleActionsWrapper extends StatelessWidget {
  final VoidCallback onTap;
  final Widget child;

  const LocationSingleActionsWrapper({super.key, required this.onTap, required this.child});

  @override
  Widget build(BuildContext context) {
    return WCustomTappableButton(
      onTap: onTap,
      borderRadius: BorderRadius.circular(8),
      rippleColor: AppColors.cyprusRipple30,
      child: Container(
        padding: const EdgeInsets.all(8),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8),
          border: Border.all(color: AppColors.zircon, width: 1),
        ),
        child: child,
      ),
    );
  }
}
