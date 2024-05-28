import 'package:flutter/material.dart';
import 'package:i_watt_app/core/util/extensions/build_context_extension.dart';
import 'package:i_watt_app/features/common/presentation/widgets/w_custom_tappable_button.dart';
import 'package:i_watt_app/features/common/presentation/widgets/w_radio.dart';

class WRadioTile<T> extends StatelessWidget {
  final T value;
  final T groupValue;
  final Widget icon;
  final String title;
  final ValueChanged<T> onChanged;
  final EdgeInsets padding;
  const WRadioTile({
    super.key,
    required this.value,
    required this.groupValue,
    required this.icon,
    required this.title,
    required this.onChanged,
    this.padding = const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
  });

  @override
  Widget build(BuildContext context) {
    return WCustomTappableButton(
      onTap: () => onChanged(value),
      borderRadius: BorderRadius.zero,
      rippleColor: context.theme.primaryColor.withAlpha(30),
      child: Padding(
        padding: padding,
        child: Row(
          children: [
            icon,
            const SizedBox(width: 12),
            Text(
              title,
              style: context.textTheme.headlineMedium,
            ),
            const Spacer(),
            WRadio(
              groupValue: groupValue,
              value: value,
              onChanged: onChanged,
            )
          ],
        ),
      ),
    );
  }
}
