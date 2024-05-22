import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:i_watt_app/core/config/app_icons.dart';

class AnimatedLocationIcon extends StatefulWidget {
  const AnimatedLocationIcon({super.key});

  @override
  State<AnimatedLocationIcon> createState() => _AnimatedLocationIconState();
}

class _AnimatedLocationIconState extends State<AnimatedLocationIcon> with TickerProviderStateMixin {
  late final AnimationController _iconAnimationController;
  late final Animation<double> _animation;
  @override
  void initState() {
    super.initState();
    _iconAnimationController =
        AnimationController(vsync: this, duration: const Duration(milliseconds: 150), reverseDuration: const Duration(milliseconds: 600))
          ..forward()
          ..addStatusListener((status) {
            if (status == AnimationStatus.completed) {
              _iconAnimationController.reverse();
            } else if (status == AnimationStatus.dismissed) {
              _iconAnimationController.forward();
            }
          });
    _animation = Tween<double>(
      begin: 0.5, // Starting scale
      end: 1, // Ending scale
    ).animate(
      CurvedAnimation(
        curve: Curves.decelerate,
        parent: _iconAnimationController,
      ),
    );
  }

  @override
  void dispose() {
    _iconAnimationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 24,
      width: 24,
      child: Stack(
        children: [
          SvgPicture.asset(AppIcons.myLocationOutlined),
          ScaleTransition(
            scale: _animation,
            child: SvgPicture.asset(AppIcons.myLocationCenter),
          ),
        ],
      ),
    );
  }
}
