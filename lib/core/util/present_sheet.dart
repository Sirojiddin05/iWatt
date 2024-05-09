import 'package:flutter/material.dart';

const double _kPreviousPageVisibleOffset = 10;

PageRouteBuilder showPresentSheet({required Widget page, RouteSettings? settings}) {
  print('showPresentSheet');
  return PageRouteBuilder(
    settings: settings,
    transitionDuration: const Duration(milliseconds: 200),
    pageBuilder: (BuildContext context, Animation<double> animation, Animation<double> secondaryAnimation) => page,
    transitionsBuilder: (context, animation, secondaryAnimation, child) {
      final paddingTop = MediaQuery.of(context).padding.top;
      final distanceWithScale = (paddingTop + _kPreviousPageVisibleOffset) * 0.9;
      final offsetY = secondaryAnimation.value * (paddingTop - distanceWithScale);
      final scale = 1 - secondaryAnimation.value / 10;
      return AnimatedBuilder(
        builder: (context, child) => Transform.translate(
          offset: Offset(0, offsetY),
          child: Transform.scale(
            scale: scale,
            alignment: Alignment.topCenter,
            child: child,
          ),
        ),
        animation: secondaryAnimation,
        child: child,
      );
    },
  );
}
