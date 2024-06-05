import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_touch_ripple/flutter_touch_ripple.dart';

class WCustomTappableButton extends StatefulWidget {
  final VoidCallback onTap;
  final BorderRadius borderRadius;
  final Color rippleColor;
  final Widget child;
  const WCustomTappableButton({super.key, required this.onTap, required this.borderRadius, required this.rippleColor, required this.child});

  @override
  State<WCustomTappableButton> createState() => _WCustomTappableButtonState();
}

class _WCustomTappableButtonState extends State<WCustomTappableButton> {
  bool isTappable = true;
  late Timer timer;

  @override
  Widget build(BuildContext context) {
    return TouchRipple(
      borderRadius: widget.borderRadius,
      rippleColor: widget.rippleColor,
      onTap: () {
        if (isTappable) {
          isTappable = false;
          setState(() {});
          timer = Timer(const Duration(milliseconds: 120), () {
            widget.onTap();
            if (timer.isActive) {
              timer.cancel();
            }
            setState(() {
              isTappable = true;
            });
          });
        }
      },
      child: widget.child,
    );
  }
}
