import 'package:flutter/material.dart';
import 'package:i_watt_app/core/config/app_colors.dart';
import 'package:i_watt_app/core/util/extensions/build_context_extension.dart';

class NotActiveText extends StatelessWidget {
  final String text;
  const NotActiveText({super.key, required this.text});

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: context.textTheme.titleLarge?.copyWith(
        fontSize: 16,
        color: AppColors.darkGray,
      ),
      textAlign: TextAlign.left,
    );
  }
}
