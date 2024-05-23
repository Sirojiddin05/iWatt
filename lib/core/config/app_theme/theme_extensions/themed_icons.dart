import 'package:flutter/material.dart';

class ThemedIcons extends ThemeExtension<ThemedIcons> {
  final String splashLogo;
  final String power;
  final String runner;
  final String station;

  ThemedIcons({required this.splashLogo, required this.power, required this.runner, required this.station});

  @override
  ThemeExtension<ThemedIcons> copyWith({
    String? splashLogo,
    String? power,
    String? runner,
    String? station,
  }) {
    return ThemedIcons(
      splashLogo: splashLogo ?? this.splashLogo,
      power: power ?? this.power,
      runner: runner ?? this.runner,
      station: station ?? this.station,
    );
  }

  @override
  ThemeExtension<ThemedIcons> lerp(covariant ThemeExtension<ThemedIcons>? other, double t) {
    if (other is! ThemedIcons) {
      return this;
    }
    return ThemedIcons(
      splashLogo: splashLogo,
      power: power,
      runner: runner,
      station: station,
    );
  }
}
