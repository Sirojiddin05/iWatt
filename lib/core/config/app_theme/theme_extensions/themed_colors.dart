import 'package:flutter/material.dart';

class ThemedColors extends ThemeExtension<ThemedColors> {
  final Color lillyWhiteToTaxBreak;
  final Color whiteToCyprusO8;
  final Color cyprusToTaxBreak;
  final Color solitudeToSolitudeO4;
  final Color whiteToWhiteO4;
  final Color cyprusToWhite;
  final Color taxBreakToZircon;
  final Color whiteToTangaroa2;
  final Color solitudeToAliceBlueO4;
  final Color blueBayouxToWhite;
  final Color prussianBlueToWhite;
  final Color deepFirToWhite;
  final Color geyserToZirconO2;
  final Color cyprusToBlueBayoux;

  ThemedColors({
    required this.lillyWhiteToTaxBreak,
    required this.whiteToCyprusO8,
    required this.cyprusToTaxBreak,
    required this.solitudeToSolitudeO4,
    required this.whiteToWhiteO4,
    required this.cyprusToWhite,
    required this.taxBreakToZircon,
    required this.whiteToTangaroa2,
    required this.solitudeToAliceBlueO4,
    required this.blueBayouxToWhite,
    required this.prussianBlueToWhite,
    required this.deepFirToWhite,
    required this.geyserToZirconO2,
    required this.cyprusToBlueBayoux,
  });

  @override
  ThemeExtension<ThemedColors> copyWith() {
    return ThemedColors(
      lillyWhiteToTaxBreak: lillyWhiteToTaxBreak,
      whiteToCyprusO8: whiteToCyprusO8,
      cyprusToTaxBreak: cyprusToTaxBreak,
      solitudeToSolitudeO4: solitudeToSolitudeO4,
      whiteToWhiteO4: whiteToWhiteO4,
      cyprusToWhite: cyprusToWhite,
      taxBreakToZircon: taxBreakToZircon,
      whiteToTangaroa2: whiteToTangaroa2,
      solitudeToAliceBlueO4: solitudeToAliceBlueO4,
      blueBayouxToWhite: blueBayouxToWhite,
      prussianBlueToWhite: prussianBlueToWhite,
      deepFirToWhite: deepFirToWhite,
      geyserToZirconO2: geyserToZirconO2,
      cyprusToBlueBayoux: cyprusToBlueBayoux,
    );
  }

  @override
  ThemeExtension<ThemedColors> lerp(covariant ThemeExtension<ThemedColors>? other, double t) {
    if (other is! ThemedColors) {
      return this;
    }
    return ThemedColors(
      cyprusToBlueBayoux: Color.lerp(cyprusToBlueBayoux, other.cyprusToBlueBayoux, t) ?? cyprusToBlueBayoux,
      lillyWhiteToTaxBreak: Color.lerp(lillyWhiteToTaxBreak, other.lillyWhiteToTaxBreak, t) ?? lillyWhiteToTaxBreak,
      whiteToCyprusO8: Color.lerp(whiteToCyprusO8, other.whiteToCyprusO8, t) ?? whiteToCyprusO8,
      cyprusToTaxBreak: Color.lerp(cyprusToTaxBreak, other.cyprusToTaxBreak, t) ?? cyprusToTaxBreak,
      solitudeToSolitudeO4: Color.lerp(solitudeToSolitudeO4, other.solitudeToSolitudeO4, t) ?? solitudeToSolitudeO4,
      whiteToWhiteO4: Color.lerp(whiteToWhiteO4, other.whiteToWhiteO4, t) ?? whiteToWhiteO4,
      cyprusToWhite: Color.lerp(cyprusToWhite, other.cyprusToWhite, t) ?? cyprusToWhite,
      taxBreakToZircon: Color.lerp(taxBreakToZircon, other.taxBreakToZircon, t) ?? taxBreakToZircon,
      whiteToTangaroa2: Color.lerp(whiteToTangaroa2, other.whiteToTangaroa2, t) ?? whiteToTangaroa2,
      solitudeToAliceBlueO4: Color.lerp(solitudeToAliceBlueO4, other.solitudeToAliceBlueO4, t) ?? solitudeToAliceBlueO4,
      blueBayouxToWhite: Color.lerp(blueBayouxToWhite, other.blueBayouxToWhite, t) ?? blueBayouxToWhite,
      prussianBlueToWhite: Color.lerp(prussianBlueToWhite, other.prussianBlueToWhite, t) ?? prussianBlueToWhite,
      deepFirToWhite: Color.lerp(deepFirToWhite, other.deepFirToWhite, t) ?? deepFirToWhite,
      geyserToZirconO2: Color.lerp(geyserToZirconO2, other.geyserToZirconO2, t) ?? geyserToZirconO2,
    );
  }
}
