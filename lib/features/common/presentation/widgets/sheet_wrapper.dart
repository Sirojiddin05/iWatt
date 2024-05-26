import 'package:flutter/cupertino.dart';
import 'package:i_watt_app/core/util/extensions/build_context_extension.dart';

class SheetWrapper extends StatelessWidget {
  final Widget child;
  const SheetWrapper({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: context.colorScheme.background,
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(20),
          topRight: Radius.circular(20),
        ),
      ),
      child: child,
    );
  }
}
