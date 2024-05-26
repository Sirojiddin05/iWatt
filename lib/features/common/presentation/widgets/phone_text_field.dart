import 'package:flutter/material.dart';
import 'package:i_watt_app/core/config/app_colors.dart';
import 'package:i_watt_app/core/util/custom_phone_formatter.dart';
import 'package:i_watt_app/core/util/extensions/build_context_extension.dart';
import 'package:i_watt_app/core/util/formatter.dart';
import 'package:i_watt_app/features/common/presentation/widgets/default_text_field.dart';

class PhoneTextField extends StatelessWidget {
  final TextEditingController controller;
  final ValueChanged<String> onChanged;
  final ValueChanged<String> onSubmitted;
  final bool hasError;
  const PhoneTextField({
    super.key,
    required this.controller,
    required this.onSubmitted,
    required this.onChanged,
    required this.hasError,
  });

  @override
  Widget build(BuildContext context) {
    return DefaultTextField(
      maxLines: 1,
      prefixMaxWidth: 70,
      hintText: '00 000 00 00',
      controller: controller,
      onSubmitted: onSubmitted,
      onChanged: onChanged,
      keyboardType: TextInputType.phone,
      hasError: hasError,
      hintStyle: context.textTheme.headlineSmall?.copyWith(fontSize: 20, color: AppColors.zircon),
      style: context.textTheme.headlineSmall?.copyWith(fontSize: 20),
      inputFormatters: [
        const CustomPhoneFormatter(),
        Formatters.phoneFormatter,
      ],
      prefixIcon: Padding(
        padding: const EdgeInsets.only(right: 6, bottom: 2, left: 12),
        child: Text(
          '+998',
          style: context.textTheme.headlineSmall?.copyWith(fontSize: 20),
        ),
      ),
    );
  }
}
