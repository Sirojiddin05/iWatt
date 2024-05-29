import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:i_watt_app/core/util/text_formatters/custom_text_editing_formatter.dart';
import 'package:i_watt_app/core/util/text_formatters/upper_case_editing_formatter.dart';

class RegionNumberField extends StatelessWidget {
  final FocusNode focusNode;
  final TextEditingController controller;
  final TextStyle textStyle;
  final int fieldLength;
  final Color cursorColor;
  final Color? backgroundColor;
  const RegionNumberField(
      {super.key,
      required this.textStyle,
      required this.focusNode,
      required this.fieldLength,
      required this.cursorColor,
      required this.controller,
      required this.backgroundColor});

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 200),
      padding: const EdgeInsets.only(left: 5),
      decoration: BoxDecoration(
        borderRadius: const BorderRadius.horizontal(left: Radius.circular(3)),
        color: backgroundColor,
      ),
      child: TextField(
        key: key,
        onChanged: (a) {},
        controller: controller,
        textAlign: TextAlign.center,
        cursorColor: cursorColor,
        decoration: const InputDecoration(
          contentPadding: EdgeInsets.only(bottom: 3),
          focusColor: Colors.transparent,
          border: InputBorder.none,
          counterText: "",
          hintStyle: TextStyle(color: Colors.black26, fontFamily: "UZBauto", decoration: TextDecoration.none),
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
        cursorHeight: 40,
        style: textStyle,
        focusNode: focusNode,
        inputFormatters: [
          UpperCaseTextFormatter(),
          CustomTextInputFormatter(fieldLength),
          FilteringTextInputFormatter.allow(RegExp("[0-9a-zA-Z]")),
        ],
      ),
    );
  }
}
