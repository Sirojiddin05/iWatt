import 'package:flutter/material.dart';
import 'package:i_watt_app/core/util/extensions/build_context_extension.dart';
import 'package:i_watt_app/features/common/presentation/widgets/w_custom_tappable_button.dart';
import 'package:i_watt_app/features/common/presentation/widgets/w_radio.dart';

class ModelItem<T> extends StatelessWidget {
  final String title;
  final VoidCallback onTap;
  final T groupValue;
  final T value;
  const ModelItem({
    super.key,
    required this.title,
    required this.onTap,
    required this.groupValue,
    required this.value,
  });

  @override
  Widget build(BuildContext context) {
    return WCustomTappableButton(
      onTap: onTap,
      borderRadius: BorderRadius.zero,
      rippleColor: context.theme.primaryColor.withAlpha(30),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Row(
          children: [
            Expanded(
              child: Text(
                title,
                textAlign: TextAlign.left,
                style: context.theme.textTheme.bodyMedium,
              ),
            ),
            WRadio(
              onChanged: (v) {
                onTap();
              },
              value: value,
              groupValue: groupValue,
            )
          ],
        ),
      ),
    );
  }
}
