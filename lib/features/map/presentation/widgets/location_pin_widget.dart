import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:i_watt_app/core/config/app_colors.dart';
import 'package:i_watt_app/core/config/app_icons.dart';
import 'package:i_watt_app/core/util/enums/connector_status.dart';
import 'package:i_watt_app/features/common/presentation/widgets/w_image.dart';

class LocationPinWidget extends StatelessWidget {
  final String logo;
  final List<ConnectorStatus> statuses;
  final bool adjustSaturation;
  final bool isSelected;
  const LocationPinWidget({super.key, required this.logo, required this.statuses, this.adjustSaturation = false, this.isSelected = false});

  @override
  Widget build(BuildContext context) {
    return ColorFiltered(
      colorFilter: ColorFilter.matrix(createSaturationMatrix(adjustSaturation ? 0 : 1)),
      child: Stack(
        alignment: Alignment.center,
        children: [
          if (isSelected) ...{
            Container(
              height: 60,
              width: 60,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: AppColors.limeGreen.withOpacity(0.48),
              ),
              margin: const EdgeInsets.only(bottom: 6),
            ),
          },
          Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const SizedBox(height: 8),
              CustomPaint(
                foregroundPainter: _StatusIconPainter(statuses: statuses),
                child: Container(
                  height: 48,
                  width: 48,
                  clipBehavior: Clip.hardEdge,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: AppColors.white,
                    boxShadow: [
                      BoxShadow(
                        blurRadius: 12,
                        offset: const Offset(0, 0),
                        color: AppColors.limeGreen.withOpacity(.08),
                      ),
                    ],
                  ),
                  alignment: Alignment.center,
                  child: logo.isNotEmpty
                      ? WImage(
                          imageUrl: logo,
                          height: 30,
                          width: 30,
                          borderRadius: BorderRadius.circular(15),
                        )
                      : Container(
                          margin: const EdgeInsets.all(8),
                          decoration: const BoxDecoration(
                            shape: BoxShape.circle,
                            color: AppColors.limeGreen,
                          ),
                          alignment: Alignment.center,
                          child: SvgPicture.asset(
                            AppIcons.union,
                          ),
                        ),
                ),
              ),
              Container(
                height: 12,
                width: 12,
                margin: const EdgeInsets.only(top: 2),
                padding: const EdgeInsets.all(2),
                clipBehavior: Clip.hardEdge,
                decoration: BoxDecoration(
                  color: AppColors.limeGreen,
                  shape: BoxShape.circle,
                  border: Border.all(color: AppColors.white, width: 2),
                  boxShadow: [
                    BoxShadow(
                      blurRadius: 16,
                      offset: const Offset(0, 4),
                      color: AppColors.limeGreen.withOpacity(.5),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  List<double> createSaturationMatrix(double saturation) {
    double invSat = 1 - saturation;
    double r = 0.213 * invSat;
    double g = 0.715 * invSat;
    double b = 0.072 * invSat;

    return [
      r + saturation,
      g,
      b,
      0,
      0,
      r,
      g + saturation,
      b,
      0,
      0,
      r,
      g,
      b + saturation,
      0,
      0,
      0,
      0,
      0,
      1,
      0,
    ];
  }
}

class _StatusIconPainter extends CustomPainter {
  final List<ConnectorStatus> statuses;
  _StatusIconPainter({required this.statuses});

  @override
  Future<void> paint(Canvas canvas, Size size) async {
    final x = size.width / 2;
    final y = size.height / 2;
    Rect rect = Rect.fromCircle(center: Offset(x, y), radius: 20);
    final List<Paint> paints = List.generate(
      statuses.length,
      (index) => Paint()
        ..color = statuses[index].color
        ..style = PaintingStyle.stroke
        ..strokeCap = StrokeCap.round
        ..shader
        ..strokeWidth = 3,
    );

    const availableSpace = 2 * pi;
    const indentSingleLength = pi / 12;
    final indentFullLength = statuses.length * indentSingleLength;
    final lengthOfStatus = (availableSpace - indentFullLength) / statuses.length;
    double startAngle = (3 * pi / 2) + (indentSingleLength / 2);
    for (int i = 0; i < statuses.length; i++) {
      canvas.drawArc(
          rect,
          startAngle,
          lengthOfStatus, // Sweep angle (adjust as needed)
          false,
          paints[i]);
      startAngle = startAngle + lengthOfStatus + indentSingleLength;
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
