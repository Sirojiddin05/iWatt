import 'package:flutter/material.dart';

class ThemedIcons extends ThemeExtension<ThemedIcons> {
  final String splashLogo;

  ThemedIcons({required this.splashLogo});
  @override
  ThemeExtension<ThemedIcons> copyWith({
    String? splashLogo,
  }) {
    return ThemedIcons(
      splashLogo: splashLogo ?? this.splashLogo,
    );
  }

  @override
  ThemeExtension<ThemedIcons> lerp(covariant ThemeExtension<ThemedIcons>? other, double t) {
    if (other is! ThemedIcons) {
      return this;
    }
    return ThemedIcons(
      splashLogo: splashLogo,
    );
  }
}
