import 'package:flutter/material.dart';
import 'package:i_watt_app/core/config/app_constants.dart';
import 'package:i_watt_app/core/util/extensions/build_context_extension.dart';
import 'package:i_watt_app/features/common/presentation/widgets/w_custom_tappable_button.dart';
import 'package:i_watt_app/features/common/presentation/widgets/w_radio.dart';

class RadioOptionContainer<T> extends StatelessWidget {
  final Widget child;
  final T value;
  final T groupValue;
  final ValueChanged<T> onChanged;
  const RadioOptionContainer({
    super.key,
    required this.child,
    required this.value,
    required this.groupValue,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return WCustomTappableButton(
      onTap: () => onChanged(value),
      rippleColor: context.theme.primaryColor.withAlpha(30),
      borderRadius: BorderRadius.circular(12),
      child: AnimatedContainer(
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          border: Border.all(
            color: value == groupValue ? context.theme.primaryColor : context.theme.unselectedWidgetColor,
          ),
        ),
        duration: AppConstants.animationDuration,
        child: Row(
          children: [
            Expanded(child: child),
            WRadio(
              onChanged: onChanged,
              value: value,
              groupValue: groupValue,
            )
          ],
        ),
      ),
    );
  }
}
