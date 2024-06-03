import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:i_watt_app/core/config/app_colors.dart';
import 'package:i_watt_app/features/charging_processes/presentation/widgets/dotted_row.dart';

class BatteryContainer extends StatefulWidget {
  final int percent;
  const BatteryContainer({super.key, required this.percent});

  @override
  State<BatteryContainer> createState() => _BatteryContainerState();
}

class _BatteryContainerState extends State<BatteryContainer> {
  Color colorBackground = AppColors.taxBreak;
  Color colorForeground = AppColors.lightSlateGrey;
  final Color colorBackground1 = AppColors.taxBreak;
  final Color colorForeground1 = AppColors.lightSlateGrey;
  final Color colorBackground2 = AppColors.amazon;
  final Color colorForeground2 = AppColors.limeGreen;
  final Color colorBackground3 = AppColors.himalaya;
  final Color colorForeground3 = AppColors.brightSun;

  @override
  void initState() {
    if (widget.percent == 24) {
      colorBackground = colorBackground1;
      colorForeground = colorForeground1;
    } else if (widget.percent > 30 && widget.percent < 50) {
      colorBackground = colorBackground3;
      colorForeground = colorForeground3;
    } else if (widget.percent > 50) {
      colorBackground = colorBackground2;
      colorForeground = colorForeground2;
    }
    super.initState();
  }

  @override
  void didUpdateWidget(covariant BatteryContainer oldWidget) {
    if (widget.percent == 24) {
      colorBackground = colorBackground1;
      colorForeground = colorForeground1;
    } else if (widget.percent > 30 && widget.percent < 50) {
      colorBackground = colorBackground3;
      colorForeground = colorForeground3;
    } else if (widget.percent > 50) {
      colorBackground = colorBackground2;
      colorForeground = colorForeground2;
    }
    super.didUpdateWidget(oldWidget);
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        SizedBox(
          width: 71,
          height: 25,
          child: Stack(
            alignment: Alignment.center,
            children: [
              Transform(
                transform: Matrix4.identity()
                  ..setEntry(3, 2, 0.009)
                  ..rotateX(-.8),
                alignment: FractionalOffset.center,
                child: AnimatedContainer(
                  duration: const Duration(milliseconds: 150),
                  height: 24,
                  width: 66,
                  decoration: BoxDecoration(color: colorBackground),
                  foregroundDecoration: BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      colors: [
                        colorBackground,
                        AppColors.white.withOpacity(.6),
                      ],
                    ),
                  ),
                ),
              ),
              Positioned(
                top: 1.7,
                left: 3,
                child: Transform(
                  transform: Matrix4.identity()
                    ..setEntry(3, 2, 0.009)
                    ..rotateX(-.8),
                  alignment: FractionalOffset.center,
                  child: AnimatedContainer(
                    duration: const Duration(milliseconds: 150),
                    height: 22,
                    width: 65,
                    padding: const EdgeInsets.all(.7),
                    decoration: BoxDecoration(color: colorBackground),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        DottedRow(
                          colorForeground: colorForeground,
                          missedIndexes: const [15, 11, 7, 4],
                          dotCount: 18,
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 2),
                          child: DottedRow(
                            colorForeground: colorForeground,
                            missedIndexes: const [20, 16, 14, 12, 9, 6, 3],
                            dotCount: 17,
                          ),
                        ),
                        DottedRow(
                          colorForeground: colorForeground,
                          missedIndexes: const [13, 10, 5, 2],
                          dotCount: 18,
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 2),
                          child: DottedRow(
                            colorForeground: colorForeground,
                            missedIndexes: const [12, 9, 6, 4],
                            dotCount: 17,
                          ),
                        ),
                        DottedRow(
                          colorForeground: colorForeground,
                          missedIndexes: const [14, 13, 7, 5],
                          dotCount: 18,
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              if (widget.percent >= 0) ...{
                Positioned(
                  top: 1.7,
                  left: 3,
                  child: Transform(
                    transform: Matrix4.identity()
                      ..setEntry(3, 2, 0.009)
                      ..rotateX(-.8),
                    alignment: FractionalOffset.center,
                    child: Container(
                      width: 65,
                      height: 22,
                      alignment: Alignment.centerLeft,
                      child: AnimatedContainer(
                        duration: const Duration(milliseconds: 150),
                        height: 22,
                        width: 65 * (widget.percent / 100),
                        decoration: BoxDecoration(color: colorForeground),
                      ),
                    ),
                  ),
                ),
              },
              Positioned(
                bottom: .3,
                child: AnimatedContainer(
                  duration: const Duration(milliseconds: 150),
                  height: 3.14,
                  width: 72,
                  decoration: BoxDecoration(color: colorBackground),
                  foregroundDecoration: BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      colors: [
                        colorBackground,
                        AppColors.white.withOpacity(.2),
                      ],
                    ),
                  ),
                ),
              ),
              Positioned(
                bottom: .8,
                child: AnimatedContainer(
                  duration: const Duration(milliseconds: 150),
                  height: 2,
                  width: 70,
                  decoration: BoxDecoration(color: colorBackground),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
