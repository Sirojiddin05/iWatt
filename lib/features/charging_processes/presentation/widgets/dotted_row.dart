import 'package:flutter/material.dart';
import 'package:i_watt_app/core/config/app_colors.dart';

class DottedRow extends StatelessWidget {
  const DottedRow({
    super.key,
    required this.colorForeground,
    required this.missedIndexes,
    required this.dotCount,
  });

  final Color colorForeground;
  final List<int> missedIndexes;
  final int dotCount;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: List.generate(
        dotCount,
        (index) => missedIndexes.contains(index)
            ? const SizedBox(
                width: 2,
                height: 2,
              )
            : AnimatedContainer(
                duration: const Duration(milliseconds: 150),
                width: 1,
                height: 1,
                margin: const EdgeInsets.all(1.4),
                decoration: ShapeDecoration(
                  color: colorForeground,
                  shape: const OvalBorder(),
                  shadows: [
                    BoxShadow(
                      offset: const Offset(0, 0),
                      blurRadius: .8,
                      spreadRadius: .4,
                      color: colorForeground.withOpacity(.64),
                    ),
                    BoxShadow(
                      offset: const Offset(0, 0),
                      blurRadius: .5,
                      spreadRadius: .4,
                      color: AppColors.white.withOpacity(.25),
                    ),
                  ],
                ),
              ),
      ),
    );
  }
}
