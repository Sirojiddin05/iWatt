import 'package:flutter/material.dart';
import 'package:highlight_text/highlight_text.dart';
import 'package:i_watt_app/core/config/app_colors.dart';
import 'package:i_watt_app/core/config/app_images.dart';
import 'package:i_watt_app/core/util/extensions/build_context_extension.dart';
import 'package:i_watt_app/features/charging_processes/presentation/widgets/battery_container.dart';

class ChargingCarAnimationWidget extends StatelessWidget {
  final double carScale;
  final double batteryScale;
  final int percentage;
  final int fontSize;
  final FontWeight percentageFontWeight;
  final FontWeight percentageSignFontWeight;
  const ChargingCarAnimationWidget({
    super.key,
    required this.percentage,
    this.carScale = 1.26,
    this.batteryScale = 1.7,
    this.fontSize = 40,
    this.percentageFontWeight = FontWeight.w700,
    this.percentageSignFontWeight = FontWeight.w800,
  });

  @override
  Widget build(BuildContext context) {
    return Transform.scale(
      scale: carScale,
      child: Material(
        color: Colors.transparent,
        child: Stack(
          children: [
            Center(child: Image.asset(AppImages.transparentCar)),
            Positioned(
              top: 0,
              bottom: -3,
              right: 0,
              left: 0,
              child: UnconstrainedBox(
                alignment: Alignment.center,
                child: Transform.scale(
                  scale: batteryScale,
                  child: BatteryContainer(
                    percent: getPercent(),
                  ),
                ),
              ),
            ),
            Positioned(
              top: -20,
              bottom: 0,
              right: 0,
              left: 0,
              child: Center(
                child: DecoratedBox(
                  decoration: BoxDecoration(
                    boxShadow: [
                      BoxShadow(
                        offset: const Offset(0, 3),
                        blurRadius: 8,
                        color: AppColors.black.withOpacity(.15),
                      ),
                    ],
                  ),
                  child: Stack(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          TextHighlight(
                            text: getPercent().toString(),
                            textAlign: TextAlign.end,
                            words: {
                              getPercent().toString(): HighlightedWord(
                                textStyle: context.textTheme.titleSmall!.copyWith(
                                  fontSize: fontSize.toDouble(),
                                  fontWeight: percentageFontWeight,
                                  height: 1,
                                  letterSpacing: 0,
                                  color: AppColors.cyprus,
                                ),
                              ),
                            },
                          ),
                          Padding(
                            padding: const EdgeInsets.only(bottom: 3),
                            child: TextHighlight(
                              text: '%',
                              textAlign: TextAlign.end,
                              words: {
                                '%': HighlightedWord(
                                  textStyle: context.textTheme.titleSmall!.copyWith(
                                    fontSize: fontSize.toDouble() / 2,
                                    fontWeight: percentageSignFontWeight,
                                    height: 1,
                                    letterSpacing: 0,
                                    color: AppColors.cyprus,
                                  ),
                                ),
                              },
                            ),
                          ),
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          TextHighlight(
                            text: getPercent().toString(),
                            textAlign: TextAlign.end,
                            words: {
                              getPercent().toString(): HighlightedWord(
                                textStyle: context.textTheme.titleSmall!.copyWith(
                                  fontSize: fontSize.toDouble(),
                                  fontWeight: percentageFontWeight,
                                  height: 1,
                                  letterSpacing: 0,
                                  foreground: Paint()
                                    ..style = PaintingStyle.stroke
                                    ..strokeWidth = 1.4
                                    ..color = AppColors.white,
                                ),
                              ),
                            },
                          ),
                          Padding(
                            padding: const EdgeInsets.only(bottom: 3),
                            child: TextHighlight(
                              text: '%',
                              textAlign: TextAlign.end,
                              words: {
                                '%': HighlightedWord(
                                  textStyle: context.textTheme.titleSmall!.copyWith(
                                    fontSize: fontSize.toDouble() / 2,
                                    fontWeight: percentageSignFontWeight,
                                    height: 1,
                                    letterSpacing: 0,
                                    foreground: Paint()
                                      ..style = PaintingStyle.stroke
                                      ..strokeWidth = 0.8
                                      ..color = AppColors.white,
                                  ),
                                ),
                              },
                            ),
                          ),
                        ],
                      )
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  int getPercent() {
    if (percentage == -1) {
      return 0;
    }
    return percentage;
  }
}
