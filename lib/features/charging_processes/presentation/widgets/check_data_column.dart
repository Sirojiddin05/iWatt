import 'package:flutter/material.dart';
import 'package:i_watt_app/core/util/extensions/build_context_extension.dart';

class CheckDataColumn extends StatelessWidget {
  final String title;
  final String data;
  final EdgeInsets padding;

  const CheckDataColumn({
    super.key,
    required this.title,
    required this.data,
    this.padding = const EdgeInsets.symmetric(vertical: 10),
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: padding,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: context.textTheme.titleSmall?.copyWith(
              color: context.themedColors.taxBreakToZircon,
              fontSize: 12,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            data,
            style: context.textTheme.headlineMedium,
          ),
        ],
      ),
    );
  }
}
