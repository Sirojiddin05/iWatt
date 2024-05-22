import 'package:flutter/material.dart';

class ThemedColors extends ThemeExtension<ThemedColors> {
  final Color lillyWhiteToTaxBreak;

  ThemedColors({required this.lillyWhiteToTaxBreak});
  @override
  ThemeExtension<ThemedColors> copyWith() {
    return ThemedColors(
      lillyWhiteToTaxBreak: lillyWhiteToTaxBreak,
    );
  }

  @override
  ThemeExtension<ThemedColors> lerp(covariant ThemeExtension<ThemedColors>? other, double t) {
    if (other is! ThemedColors) {
      return this;
    }
    return ThemedColors(
      lillyWhiteToTaxBreak: Color.lerp(lillyWhiteToTaxBreak, other.lillyWhiteToTaxBreak, t) ?? lillyWhiteToTaxBreak,
    );
  }
}
