import 'package:flutter/cupertino.dart';
import 'package:i_watt_app/core/util/extensions/build_context_extension.dart';

class SheetWrapper extends StatelessWidget {
  final Widget child;
  final Color? color;
  final EdgeInsets? margin;
  const SheetWrapper({super.key, required this.child, this.color, this.margin});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: margin,
      decoration: BoxDecoration(
        color: color ?? context.colorScheme.background,
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(20),
          topRight: Radius.circular(20),
        ),
      ),
      child: child,
    );
  }
}
