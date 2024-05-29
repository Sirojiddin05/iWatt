import 'package:flutter/material.dart';

class FieldWrapper extends StatelessWidget {
  final Color backgroundColor;
  final double scala;
  final int type;
  final Color borderColor;
  const FieldWrapper({
    super.key,
    required this.backgroundColor,
    required this.scala,
    required this.type,
    required this.borderColor,
  });

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      height: scala * 60,
      width: 250,
      padding: EdgeInsets.all(3 * scala),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        color: backgroundColor,
        // border: Border
      ),
      duration: const Duration(milliseconds: 100),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(6 * scala),
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 100),
          padding: EdgeInsets.symmetric(
            horizontal: (type != 3 && type != 4) ? 4 * 0 : 0,
          ),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(6),
            border: Border.all(color: borderColor, width: 2),
            color: backgroundColor,
          ),
        ),
      ),
    );
  }
}
