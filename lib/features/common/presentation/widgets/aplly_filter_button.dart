import 'package:flutter/material.dart';
import 'package:i_watt_app/core/util/extensions/build_context_extension.dart';
import 'package:i_watt_app/features/common/presentation/widgets/w_button.dart';

class ApplyFilterButton extends StatelessWidget {
  final VoidCallback onTap;
  final String text;
  const ApplyFilterButton({
    super.key,
    required this.onTap,
    required this.text,
  });

  @override
  Widget build(BuildContext context) {
    return WButton(
      margin: EdgeInsets.fromLTRB(16, 0, 16, context.padding.bottom + context.viewInsets.bottom + 8),
      text: text,
      textColor: Colors.white,
      onTap: onTap,
      height: 44,
    );
  }
}
