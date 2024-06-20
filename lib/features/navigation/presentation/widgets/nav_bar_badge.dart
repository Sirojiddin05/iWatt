import 'package:flutter/material.dart';
import 'package:i_watt_app/core/config/app_colors.dart';
import 'package:i_watt_app/core/util/extensions/build_context_extension.dart';

class NavBarBadge extends StatelessWidget {
  final int number;
  const NavBarBadge({super.key, required this.number});

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.topCenter,
      padding: const EdgeInsets.all(4),
      decoration: const BoxDecoration(
        color: AppColors.amaranth,
        shape: BoxShape.circle,
      ),
      child: Text(
        number.toString(),
        style: context.textTheme.labelLarge?.copyWith(fontSize: 9),
        textAlign: TextAlign.center,
      ),
    );
  }
}
