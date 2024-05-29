import 'package:flutter/services.dart';

class CustomPhoneFormatter extends TextInputFormatter {
  const CustomPhoneFormatter();

  @override
  TextEditingValue formatEditUpdate(TextEditingValue oldValue, TextEditingValue newValue) {
    final cleanedText = newValue.text.replaceAll(RegExp(r'\D'), '');
    if (cleanedText.startsWith('998') && cleanedText.length > 9) {
      final neededText = cleanedText.replaceFirst('998', '');
      return TextEditingValue(
        text: neededText,
        selection: TextSelection.collapsed(offset: neededText.length),
      );
    }
    return newValue;
  }
}
