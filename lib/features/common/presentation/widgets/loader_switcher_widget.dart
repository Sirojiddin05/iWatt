import 'package:flutter/material.dart';

class LoaderSwitcherWidget extends StatelessWidget {
  final bool loading;
  final Widget loaderWidget;
  final Widget child;
  const LoaderSwitcherWidget({
    super.key,
    required this.loaderWidget,
    required this.loading,
    required this.child,
  });

  @override
  Widget build(BuildContext context) {
    return AnimatedCrossFade(
      firstChild: child,
      secondChild: loaderWidget,
      crossFadeState: loading ? CrossFadeState.showSecond : CrossFadeState.showFirst,
      duration: const Duration(milliseconds: 200),
    );
  }
}
