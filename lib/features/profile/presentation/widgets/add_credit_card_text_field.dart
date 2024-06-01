import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:i_watt_app/core/config/app_colors.dart';
import 'package:i_watt_app/core/util/extensions/build_context_extension.dart';

class AddCreditCardTextField extends StatelessWidget {
  const AddCreditCardTextField({
    super.key,
    required this.controller,
    this.inputFormatters,
    this.onChanged,
    this.keyboardType,
    this.contentPadding,
    this.margin,
    this.labelText,
    this.hintText,
    this.suffixIcon,
  });

  final TextEditingController controller;
  final List<TextInputFormatter>? inputFormatters;
  final ValueChanged<String>? onChanged;
  final TextInputType? keyboardType;
  final EdgeInsets? contentPadding;
  final EdgeInsets? margin;
  final String? labelText;
  final String? hintText;
  final Widget? suffixIcon;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: margin ?? const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            labelText ?? '',
            style: Theme.of(context).textTheme.titleMedium!.copyWith(
                  color: AppColors.darkGray,
                  fontSize: 12,
                ),
          ),
          const SizedBox(height: 4),
          TextField(
            controller: controller,
            onChanged: onChanged,
            // cursorColor: dark,
            style: Theme.of(context).textTheme.headlineMedium!.copyWith(),
            keyboardType: keyboardType,
            inputFormatters: inputFormatters,
            decoration: InputDecoration(
              focusColor: context.theme.primaryColor,
              contentPadding: contentPadding,
              floatingLabelBehavior: FloatingLabelBehavior.always,
              suffixIcon: suffixIcon,
              hintText: hintText,
              hintStyle: Theme.of(context).textTheme.headlineMedium!.copyWith(color: AppColors.darkGray),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8),
                borderSide: BorderSide(
                  width: 1,
                  color: context.theme.dividerColor,
                ),
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8),
                borderSide: BorderSide(
                  width: 1,
                  color: context.theme.dividerColor,
                ),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8),
                borderSide: BorderSide(
                  width: 2,
                  color: context.theme.primaryColor,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
