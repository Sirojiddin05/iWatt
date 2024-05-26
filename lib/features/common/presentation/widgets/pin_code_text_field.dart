import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:i_watt_app/core/config/app_colors.dart';
import 'package:i_watt_app/core/config/app_constants.dart';
import 'package:i_watt_app/core/util/extensions/build_context_extension.dart';
import 'package:pin_code_fields/pin_code_fields.dart';

class WPinCodeTextField extends StatelessWidget {
  final bool hasError;
  final TextEditingController pinCodeController;
  final FocusNode focusNode;
  final ValueChanged<String> onChanged;
  const WPinCodeTextField({
    super.key,
    required this.hasError,
    required this.pinCodeController,
    required this.focusNode,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return PinCodeTextField(
      length: 6,
      appContext: context,
      onChanged: onChanged,
      controller: pinCodeController,
      focusNode: focusNode,
      showCursor: true,
      cursorWidth: 1,
      cursorColor: context.colorScheme.primary,
      separatorBuilder: (context, index) => const SizedBox(width: 10),
      animationDuration: AppConstants.animationDuration,
      animationType: AnimationType.fade,
      enableActiveFill: true,
      enablePinAutofill: true,
      textStyle: context.textTheme.displayLarge!.copyWith(fontWeight: FontWeight.w600),
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      keyboardType: TextInputType.number,
      inputFormatters: [
        FilteringTextInputFormatter.digitsOnly,
      ],
      pinTheme: PinTheme(
        borderWidth: 1,
        disabledColor: AppColors.geyser.withOpacity(0.4),
        inactiveFillColor: context.colorScheme.background,
        activeFillColor: context.colorScheme.background,
        activeColor: hasError ? context.colorScheme.error : AppColors.geyser.withOpacity(0.4),
        inactiveColor: AppColors.geyser.withOpacity(0.4),
        selectedColor: hasError ? context.colorScheme.error : context.colorScheme.primary,
        shape: PinCodeFieldShape.box,
        borderRadius: BorderRadius.circular(8),
        selectedFillColor: context.colorScheme.background,
        fieldHeight: 52,
        fieldWidth: 48,
        errorBorderColor: context.colorScheme.error,
      ),
    );
  }
}
