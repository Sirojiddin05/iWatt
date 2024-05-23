import 'package:flutter/material.dart';
import 'package:i_watt_app/core/config/app_colors.dart';

class LocationDataDividerCircle extends StatelessWidget {
  const LocationDataDividerCircle({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 3,
      height: 3,
      margin: const EdgeInsets.symmetric(horizontal: 10),
      decoration: const ShapeDecoration(
        shape: OvalBorder(),
        color: AppColors.blueBayoux,
      ),
    );
  }
}
