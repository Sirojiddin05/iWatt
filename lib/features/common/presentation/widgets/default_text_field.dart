import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:i_watt_app/core/config/app_colors.dart';
import 'package:i_watt_app/core/util/extensions/build_context_extension.dart';

class DefaultTextField extends StatefulWidget {
  final bool fill;
  final TextEditingController controller;
  final ValueChanged<String> onChanged;
  final ValueChanged<String>? onSubmitted;
  final EdgeInsets contentPadding;
  final Widget? prefix;
  final Widget? prefixIcon;
  final List<TextInputFormatter>? inputFormatters;
  final Widget? suffix;
  final double prefixMaxWidth;
  final double suffixMaxWidth;
  final TextStyle? style;
  final TextStyle? hintStyle;
  final String? hintText;
  final bool hasError;
  final bool isObscure;
  final String? prefixText;
  final TextInputType? keyboardType;
  final String title;
  final String errorText;
  final double? height;
  final int? maxLines;
  final int? maxLength;
  final bool autoFocus;
  final FocusNode? focusNode;
  final TextAlignVertical? textAlignVertical;
  final bool? expands;
  final MaxLengthEnforcement? maxLengthEnforcement;
  final bool showCount;
  final TextInputAction? textInputAction;
  final TextStyle? titleStyle;
  final TextStyle? prefixTextStyle;
  final Color? fillColor;
  final Widget? Function(BuildContext, {required int currentLength, required bool isFocused, required int? maxLength})?
      buildCounter;

  const DefaultTextField({
    this.autoFocus = false,
    this.showCount = false,
    this.focusNode,
    this.textInputAction,
    this.maxLengthEnforcement,
    required this.controller,
    required this.onChanged,
    this.prefix,
    this.title = '',
    this.errorText = '',
    this.contentPadding = const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
    this.inputFormatters,
    this.suffix,
    this.prefixMaxWidth = 40,
    this.suffixMaxWidth = 40,
    this.hintStyle,
    this.hintText,
    this.style,
    this.isObscure = false,
    this.hasError = false,
    this.prefixText,
    this.prefixTextStyle,
    this.prefixIcon,
    this.keyboardType,
    this.height,
    this.maxLines,
    this.maxLength,
    this.titleStyle,
    this.textAlignVertical,
    this.expands,
    super.key,
    this.buildCounter,
    this.onSubmitted,
    this.fill = false,
    this.fillColor,
  });

  @override
  State<DefaultTextField> createState() => _DefaultTextFieldState();
}

class _DefaultTextFieldState extends State<DefaultTextField> {
  late final FocusNode focusNode;
  late final ValueNotifier<bool> focusNotifier;

  @override
  void initState() {
    super.initState();
    focusNode = widget.focusNode ?? FocusNode();
    focusNotifier = ValueNotifier<bool>(focusNode.hasFocus);
    focusNode.addListener(() {
      focusNotifier.value = focusNode.hasFocus;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (widget.title.isNotEmpty) ...[
          ValueListenableBuilder<bool>(
            valueListenable: focusNotifier,
            builder: (context, hasFocus, child) {
              return Text(
                widget.title,
                style: widget.titleStyle ??
                    context.textTheme.titleMedium?.copyWith(
                      fontSize: 12,
                      color: hasFocus ? AppColors.dodgerBlue : AppColors.darkGray,
                    ),
              );
            },
          ),
          const SizedBox(height: 6),
        ],
        SizedBox(
          height: widget.height ?? 48,
          child: TextField(
            expands: widget.expands ?? false,
            maxLengthEnforcement: widget.maxLengthEnforcement,
            textAlignVertical: widget.textAlignVertical,
            focusNode: focusNode,
            autofocus: widget.autoFocus,
            controller: widget.controller,
            textInputAction: widget.textInputAction,
            style: widget.style ?? Theme.of(context).textTheme.titleLarge?.copyWith(fontWeight: FontWeight.w500),
            inputFormatters: widget.inputFormatters,
            obscureText: widget.isObscure,
            keyboardType: widget.keyboardType,
            maxLength: widget.maxLength,
            maxLines: widget.isObscure ? 1 : widget.maxLines,
            cursorWidth: 1,
            cursorColor: context.themedColors.cyprusToWhite,
            buildCounter: widget.buildCounter,
            decoration: InputDecoration(
              hintText: widget.hintText,
              hintStyle: widget.hintStyle,
              contentPadding: widget.contentPadding,
              suffixIcon: widget.suffix,
              suffixIconConstraints: BoxConstraints(maxWidth: widget.suffixMaxWidth),
              prefixIconConstraints: BoxConstraints(maxWidth: widget.prefixMaxWidth, minWidth: 0),
              prefixIcon: widget.prefixIcon,
              prefixText: widget.prefixText,
              prefix: widget.prefix,
              counterText: '',
              filled: widget.fill,
              fillColor: widget.fillColor ?? context.theme.colorScheme.surface,
              enabledBorder: widget.hasError
                  ? context.theme.inputDecorationTheme.errorBorder
                  : context.theme.inputDecorationTheme.enabledBorder,
              border: widget.hasError
                  ? context.theme.inputDecorationTheme.errorBorder
                  : context.theme.inputDecorationTheme.border,
              focusedBorder: widget.hasError
                  ? context.theme.inputDecorationTheme.errorBorder
                  : context.theme.inputDecorationTheme.focusedBorder,
            ),
            onChanged: widget.onChanged,
            onSubmitted: widget.onSubmitted,
          ),
        ),
      ],
    );
  }
}
