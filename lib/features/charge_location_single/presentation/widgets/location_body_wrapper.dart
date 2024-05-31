import 'package:flutter/material.dart';
import 'package:i_watt_app/core/util/extensions/build_context_extension.dart';

class LocationSingleBodyWrapper extends StatelessWidget {
  final Widget child;
  const LocationSingleBodyWrapper({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: context.sizeOf.height,
      margin: const EdgeInsets.only(top: 20),
      clipBehavior: Clip.antiAlias,
      decoration: BoxDecoration(
        color: context.theme.scaffoldBackgroundColor,
        borderRadius: const BorderRadius.vertical(top: Radius.circular(20)),
      ),
      child: child,
    );
  }
}
