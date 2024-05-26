import 'package:flutter/material.dart';
import 'package:i_watt_app/core/config/app_constants.dart';
import 'package:i_watt_app/core/util/extensions/build_context_extension.dart';

class WRadio<T> extends StatelessWidget {
  final T value;
  final T groupValue;
  final ValueChanged<T> onChanged;
  final Color? activeColor;
  final Color? inactiveColor;

  const WRadio({
    required this.onChanged,
    required this.value,
    required this.groupValue,
    this.activeColor,
    this.inactiveColor,
    super.key,
  });

  @override
  Widget build(BuildContext context) => GestureDetector(
        behavior: HitTestBehavior.opaque,
        onTap: () {
          onChanged(value);
        },
        child: AnimatedContainer(
          duration: AppConstants.animationDuration,
          height: 22,
          width: 22,
          alignment: Alignment.center,
          decoration: BoxDecoration(
            border: Border.all(
              color: value == groupValue ? activeColor ?? context.theme.primaryColor : (inactiveColor ?? context.theme.unselectedWidgetColor),
              width: value == groupValue ? 2 : 1,
            ),
            shape: BoxShape.circle,
            color: Colors.transparent,
          ),
          child: AnimatedContainer(
            duration: const Duration(milliseconds: 150),
            height: value == groupValue ? 10 : 0,
            width: value == groupValue ? 10 : 0,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: value == groupValue ? activeColor ?? context.theme.primaryColor : Colors.transparent,
            ),
          ),
        ),
      );
}
