import 'package:flutter/material.dart';
import 'package:i_watt_app/features/navigation/presentation/widgets/custom_indicator_pointer/worm_effect.dart';
import 'package:i_watt_app/features/navigation/presentation/widgets/custom_indicator_pointer/worm_painter.dart';

class DotsIndicator extends StatelessWidget {
  final int length;
  final double offset;
  final Color dotColor;
  final Color activeDotColor;

  const DotsIndicator({
    super.key,
    required this.length,
    required this.offset,
    this.dotColor = Colors.white54,
    this.activeDotColor = Colors.white,
  });

  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      size: Size((length + 2) * 8, 8),
      painter: WormPainter(
        effect: WormEffect(
          paintStyle: PaintingStyle.fill,
          activeDotColor: activeDotColor,
          dotColor: dotColor,
          dotWidth: 8,
          dotHeight: 8,
          spacing: 8,
        ),
        count: length,
        offset: offset,
      ),
    );
  }
}
