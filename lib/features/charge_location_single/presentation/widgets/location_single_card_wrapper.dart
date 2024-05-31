import 'package:flutter/material.dart';
import 'package:i_watt_app/core/config/app_colors.dart';
import 'package:i_watt_app/core/util/extensions/build_context_extension.dart';

class LocationSingleCardWrapper extends StatelessWidget {
  final Widget child;
  final EdgeInsets? padding;
  final EdgeInsets? margin;
  const LocationSingleCardWrapper({super.key, required this.child, this.padding, this.margin});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: margin ?? const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
      padding: padding ?? const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: context.colorScheme.background,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            offset: const Offset(0, 6),
            blurRadius: 20,
            spreadRadius: -12,
            color: AppColors.tangaroa.withOpacity(.14),
          ),
          BoxShadow(
            offset: const Offset(0, 2),
            blurRadius: 1,
            spreadRadius: -1,
            color: AppColors.tangaroa.withOpacity(.05),
          ),
        ],
      ),
      child: child,
    );
  }
}
