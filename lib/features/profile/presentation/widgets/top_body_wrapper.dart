import 'package:flutter/material.dart';
import 'package:k_watt_app/assets/colors/colors.dart';

class TopUpBodyWrapper extends StatelessWidget {
  final Widget child;
  const TopUpBodyWrapper({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(top: 16),
      decoration: BoxDecoration(
        color: white,
        borderRadius: const BorderRadius.vertical(top: Radius.circular(16)),
        boxShadow: [
          BoxShadow(
            color: baliHai.withOpacity(0.2),
            blurRadius: 40,
            offset: const Offset(0, 4),
          )
        ],
      ),
      child: child,
    );
  }
}
