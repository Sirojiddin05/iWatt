import 'package:flutter/material.dart';

class ThemedIcons extends ThemeExtension<ThemedIcons> {
  final String splashLogo;
  final String power;
  final String runner;
  final String station;
  final String qrScan;
  final String plugAlt;

  ThemedIcons({
    required this.splashLogo,
    required this.power,
    required this.runner,
    required this.station,
    required this.qrScan,
    required this.plugAlt,
  });

  @override
  ThemeExtension<ThemedIcons> copyWith({
    String? splashLogo,
    String? power,
    String? runner,
    String? station,
    String? qrScan,
    String? plugAlt,
  }) {
    return ThemedIcons(
      splashLogo: splashLogo ?? this.splashLogo,
      power: power ?? this.power,
      runner: runner ?? this.runner,
      station: station ?? this.station,
      qrScan: qrScan ?? this.qrScan,
      plugAlt: plugAlt ?? this.plugAlt,
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
      qrScan: qrScan,
      plugAlt: plugAlt,
    );
  }
}
