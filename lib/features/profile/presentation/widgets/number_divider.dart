import 'package:flutter/material.dart';

class NumberDivider extends StatelessWidget {
  final double scala;
  final Color color;
  const NumberDivider({super.key, required this.scala, required this.color});

  @override
  Widget build(BuildContext context) {
    return Container(width: 2, height: scala * 50, color: color);
  }
}
