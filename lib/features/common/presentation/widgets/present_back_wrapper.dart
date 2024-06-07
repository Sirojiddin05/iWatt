import 'package:flutter/material.dart';

class PresentSheetBackPageWrapper extends StatelessWidget {
  final Widget child;
  final double transformY2;
  final double scaleAnimation;
  final double borderRadius;
  const PresentSheetBackPageWrapper({
    super.key,
    required this.child,
    required this.transformY2,
    required this.scaleAnimation,
    required this.borderRadius,
  });

  @override
  Widget build(BuildContext context) {
    return Transform.translate(
      offset: Offset(0, transformY2),
      child: Transform(
        transform: Matrix4.identity()..scale(scaleAnimation),
        alignment: Alignment.center,
        child: ClipRRect(
          borderRadius: BorderRadius.circular(borderRadius),
          child: child,
        ),
      ),
    );
  }
}
