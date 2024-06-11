import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:i_watt_app/core/util/text_formatters/custom_number_field_formatter.dart';
import 'package:i_watt_app/core/util/text_formatters/upper_case_editing_formatter.dart';

class NumberField extends StatelessWidget {
  final TextEditingController controller;
  final Color cursorColor;
  final TextStyle style;
  final FocusNode focusNode;
  final int fieldLength;
  const NumberField(
      {super.key, required this.controller, required this.cursorColor, required this.style, required this.focusNode, required this.fieldLength});

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      key: key,
      onChanged: (a) {},
      controller: controller,
      cursorColor: cursorColor,
      decoration: const InputDecoration(
        contentPadding: EdgeInsets.only(bottom: 3),
        focusColor: Colors.transparent,
        border: InputBorder.none,
        counterText: "",
        hintStyle: TextStyle(color: Colors.black26, decoration: TextDecoration.none),
        focusedErrorBorder: OutlineInputBorder(
          borderSide: BorderSide(width: 0, color: Colors.transparent),
        ),
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(width: 0, color: Colors.transparent),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(width: 0, color: Colors.transparent),
        ),
        errorBorder: OutlineInputBorder(
          borderSide: BorderSide(width: 0, color: Colors.transparent),
        ),
      ),
      cursorHeight: 50,
      style: style,
      focusNode: focusNode,
      inputFormatters: [
        UpperCaseTextFormatter(),
        CustomTextInputFormatter(fieldLength),
        FilteringTextInputFormatter.allow(RegExp("[0-9a-zA-Z]")),
      ],
    );
  }
}
