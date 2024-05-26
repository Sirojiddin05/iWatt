import 'package:flutter/material.dart';
import 'package:i_watt_app/core/util/extensions/build_context_extension.dart';

class ActiveText extends StatelessWidget {
  final String text;
  const ActiveText({super.key, required this.text});

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: context.textTheme.bodyMedium,
      textAlign: TextAlign.left,
    );
  }
}
