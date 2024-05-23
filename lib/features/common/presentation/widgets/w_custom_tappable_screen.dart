import 'package:flutter/material.dart';

class WCustomTappableScreen extends StatefulWidget {
  final ValueChanged<ValueNotifier<bool>> onTapAbilityChanged;
  final Widget child;
  const WCustomTappableScreen({super.key, required this.onTapAbilityChanged, required this.child});

  @override
  State<WCustomTappableScreen> createState() => _WCustomTappableScreenState();
}

class _WCustomTappableScreenState extends State<WCustomTappableScreen> {
  late final ValueNotifier<bool> isTappable;
  @override
  void initState() {
    super.initState();
    isTappable = ValueNotifier<bool>(true);
    widget.onTapAbilityChanged(isTappable);
  }

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
      valueListenable: isTappable,
      builder: (BuildContext context, bool value, Widget? child) {
        return IgnorePointer(
          ignoring: !isTappable.value,
          child: child ?? const SizedBox.shrink(),
        );
      },
      child: widget.child,
    );
  }
}
