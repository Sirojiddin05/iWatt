import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:i_watt_app/core/config/app_icons.dart';
import 'package:i_watt_app/core/util/extensions/build_context_extension.dart';
import 'package:i_watt_app/features/map/presentation/widgets/location__loading_icon.dart';

class LocateMeButton extends StatelessWidget {
  final VoidCallback onTap;
  final bool isLoading;

  const LocateMeButton({Key? key, required this.onTap, required this.isLoading}) : super(key: key);

  @override
  Widget build(BuildContext context) => GestureDetector(
        behavior: HitTestBehavior.opaque,
        onTap: onTap,
        child: Container(
          margin: const EdgeInsets.fromLTRB(16, 12, 16, 32),
          padding: const EdgeInsets.all(8),
          decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(8), boxShadow: [
            BoxShadow(offset: const Offset(0, 4), blurRadius: 6, color: context.theme.shadowColor),
            BoxShadow(offset: const Offset(0, 1), spreadRadius: 1, color: context.theme.shadowColor),
            BoxShadow(offset: const Offset(0, 0), blurRadius: 0, spreadRadius: 4, color: context.theme.shadowColor),
          ]),
          child: AnimatedSwitcher(
            duration: const Duration(milliseconds: 150),
            child: isLoading ? const AnimatedLocationIcon() : SvgPicture.asset(AppIcons.myLocation),
          ),
        ),
      );
}
