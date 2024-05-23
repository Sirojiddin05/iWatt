import 'dart:math';

import 'package:flutter/material.dart';
import 'package:i_watt_app/core/config/app_colors.dart';
import 'package:i_watt_app/core/config/app_icons.dart';
import 'package:i_watt_app/core/util/enums/connector_status.dart';

class LocationStatusesWidget extends StatelessWidget {
  final List<ConnectorStatus> connectorStatuses;
  const LocationStatusesWidget({super.key, required this.connectorStatuses});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 36,
      height: 36,
      child: CustomPaint(
        foregroundPainter: _StatusIconPainter(statuses: connectorStatuses),
        child: Container(
          padding: const EdgeInsets.all(4),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(90),
            boxShadow: [
              BoxShadow(
                blurRadius: 12,
                color: AppColors.black.withOpacity(.08),
              ),
            ],
            border: Border.all(
              color: AppColors.white,
              width: 6,
              strokeAlign: BorderSide.strokeAlignCenter,
            ),
          ),
          child: Image.asset(AppIcons.locationCardIcon, width: 24, height: 24),
        ),
      ),
    );
  }
}

class _StatusIconPainter extends CustomPainter {
  final List<ConnectorStatus> statuses;
  _StatusIconPainter({required this.statuses});

  @override
  Future<void> paint(Canvas canvas, Size size) async {
    final x = size.width / 2;
    final y = size.height / 2;
    Rect rect = Rect.fromCircle(center: Offset(x, y), radius: 18);
    final List<Paint> paints = List.generate(
      statuses.length,
      (index) => Paint()
        ..color = statuses[index].color
        ..style = PaintingStyle.stroke
        ..strokeCap = StrokeCap.round
        ..shader
        ..strokeWidth = 2.5,
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
