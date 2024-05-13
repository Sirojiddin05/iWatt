import 'package:flutter/material.dart';

class ThemedColors extends ThemeExtension<ThemedColors> {
  @override
  ThemeExtension<ThemedColors> copyWith() {
    return ThemedColors();
  }

  @override
  ThemeExtension<ThemedColors> lerp(covariant ThemeExtension<ThemedColors>? other, double t) {
    if (other is! ThemedColors) {
      return this;
    }
    return ThemedColors();
  }
}
