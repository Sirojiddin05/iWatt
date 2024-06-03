import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:i_watt_app/core/config/app_icons.dart';

showCommonLoaderDialog(BuildContext context) {
  showDialog(
    context: context,
    barrierDismissible: false,
    builder: (context) {
      return const PopScope(
        canPop: false,
        child: Center(child: AnimatedLoaderIndicator()),
      );
    },
  );
}

class AnimatedLoaderIndicator extends StatefulWidget {
  const AnimatedLoaderIndicator({Key? key}) : super(key: key);

  @override
  State<AnimatedLoaderIndicator> createState() => _AnimatedLoaderIndicatorState();
}

class _AnimatedLoaderIndicatorState extends State<AnimatedLoaderIndicator> with TickerProviderStateMixin {
  late AnimationController _iconAnimationController;

  @override
  void initState() {
    super.initState();
    _iconAnimationController = AnimationController(vsync: this, duration: const Duration(milliseconds: 500))..repeat();
  }

  @override
  void dispose() {
    _iconAnimationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 32,
      width: 32,
      child: AnimatedBuilder(
        animation: _iconAnimationController,
        builder: (context, child) {
          return Transform.rotate(
            angle: _iconAnimationController.value * pi,
            child: child,
          );
        },
        child: SvgPicture.asset(
          AppIcons.loaderIndicator,
          color: Colors.white,
        ),
      ),
    );
  }
}
