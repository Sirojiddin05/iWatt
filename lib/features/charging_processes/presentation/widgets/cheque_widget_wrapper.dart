import 'package:flutter/cupertino.dart';
import 'package:i_watt_app/core/config/app_colors.dart';

class ChequeWidgetWrapper extends StatelessWidget {
  final Widget child;
  final EdgeInsets padding;
  const ChequeWidgetWrapper({
    super.key,
    required this.child,
    this.padding = const EdgeInsets.fromLTRB(16, 16, 0, 16),
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(10),
        boxShadow: [
          BoxShadow(
            color: AppColors.baliHai.withOpacity(0.08),
            blurRadius: 24,
            offset: const Offset(0, 6),
          ),
        ],
      ),
      padding: padding,
      child: child,
    );
  }
}
