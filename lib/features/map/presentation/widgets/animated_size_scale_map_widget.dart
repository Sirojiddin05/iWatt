import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:i_watt_app/core/util/extensions/build_context_extension.dart';
import 'package:i_watt_app/features/common/presentation/widgets/w_button.dart';

class AnimatedScaleSizeWidget extends StatefulWidget {
  final bool isVisible;
  final String buttonText;
  final VoidCallback onButtonTap;
  final String iconPath;
  final Widget body;
  final double? width;
  const AnimatedScaleSizeWidget({
    super.key,
    required this.buttonText,
    required this.onButtonTap,
    required this.iconPath,
    required this.body,
    required this.isVisible,
    this.width,
  });

  @override
  State<AnimatedScaleSizeWidget> createState() => _AnimatedScaleSizeWidgetState();
}

class _AnimatedScaleSizeWidgetState extends State<AnimatedScaleSizeWidget> with TickerProviderStateMixin {
  late final AnimationController _widthSizeController;
  late final AnimationController _heightSizeController;
  late final AnimationController _scaleController;
  late final Animation<double> _sizeAnimation;
  late final Animation<double> _scaleAnimation;
  late final Animation<double> _heightSizeAnimation;

  @override
  void initState() {
    super.initState();
    _heightSizeController = AnimationController(vsync: this, duration: const Duration(milliseconds: 150));
    _scaleController = AnimationController(vsync: this, duration: const Duration(milliseconds: 600));
    _scaleAnimation = CurvedAnimation(parent: _scaleController, curve: Curves.elasticInOut);
    _widthSizeController = AnimationController(vsync: this, duration: const Duration(milliseconds: 300));
    _sizeAnimation = CurvedAnimation(parent: _widthSizeController, curve: Curves.easeOutCubic);

    _heightSizeController.addStatusListener(_heightAnimationListener);
    _scaleController.addStatusListener(_scaleAnimationListener);
    _widthSizeController.addStatusListener(_widthSizeAnimationListener);

    if (widget.isVisible) {
      _heightSizeController.forward();
    }
  }

  void _heightAnimationListener(AnimationStatus status) async {
    if (status == AnimationStatus.completed) {
      await Future.delayed(const Duration(milliseconds: 150));
      _scaleController.forward();
    }
  }

  void _scaleAnimationListener(AnimationStatus status) async {
    if (status == AnimationStatus.completed) {
      await Future.delayed(const Duration(milliseconds: 600));
      _widthSizeController.forward();
    } else if (status == AnimationStatus.dismissed) {
      await Future.delayed(const Duration(milliseconds: 150));
      _heightSizeController.reverse();
    }
  }

  void _widthSizeAnimationListener(AnimationStatus status) async {
    if (status == AnimationStatus.dismissed) {
      await Future.delayed(const Duration(milliseconds: 300));
      _scaleController.reverse();
    }
  }

  @override
  void didUpdateWidget(covariant AnimatedScaleSizeWidget oldWidget) {
    if (widget.isVisible) {
      _heightSizeController.forward();
    } else {
      _widthSizeController.reverse();
    }
    super.didUpdateWidget(oldWidget);
  }

  @override
  Widget build(BuildContext context) {
    return UnconstrainedBox(
      child: SizeTransition(
        sizeFactor: _heightSizeController,
        child: ScaleTransition(
          scale: _scaleAnimation,
          child: Container(
            padding: const EdgeInsets.fromLTRB(8, 8, 10, 8),
            margin: const EdgeInsets.only(top: 6, bottom: 6, left: 16, right: 16),
            decoration: BoxDecoration(
              color: context.colorScheme.background,
              borderRadius: BorderRadius.circular(32),
              boxShadow: [
                BoxShadow(
                  color: context.theme.shadowColor,
                  spreadRadius: 0,
                  blurRadius: 6,
                  offset: const Offset(0, 4),
                ),
                BoxShadow(
                  color: context.theme.shadowColor,
                  spreadRadius: 1,
                  blurRadius: 0,
                  offset: const Offset(0, 1),
                ),
              ],
            ),
            child: Row(
              children: [
                if (widget.iconPath.contains('.png')) ...{
                  RotationTransition(turns: _sizeAnimation, child: Image.asset(widget.iconPath, width: 36, height: 36)),
                } else ...{
                  RotationTransition(turns: _sizeAnimation, child: SvgPicture.asset(widget.iconPath, width: 36, height: 36)),
                },
                SizeTransition(
                  sizeFactor: _sizeAnimation,
                  axis: Axis.horizontal,
                  child: SizedBox(
                    width: (widget.width ?? context.sizeOf.width - 32) - 54,
                    child: Row(
                      children: [
                        const SizedBox(width: 8),
                        Expanded(child: widget.body),
                        const SizedBox(width: 10),
                        WButton(
                          onTap: widget.onButtonTap,
                          text: widget.buttonText,
                          textStyle: context.textTheme.labelLarge,
                          borderRadius: 16,
                          height: 32,
                          padding: const EdgeInsets.symmetric(horizontal: 16),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    _heightSizeController.dispose();
    _widthSizeController.dispose();
    _scaleController.dispose();
    super.dispose();
  }
}
