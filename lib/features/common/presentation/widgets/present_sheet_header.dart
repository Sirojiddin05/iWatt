import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:i_watt_app/core/config/app_icons.dart';

class PresentSheetHeader extends StatelessWidget {
  final String title;
  final EdgeInsets? paddingOfCloseIcon;
  final double? titleFotSize;
  final VoidCallback? onCloseTap;
  final bool hasCloseIcon;
  const PresentSheetHeader({super.key, required this.title, this.paddingOfCloseIcon, this.titleFotSize, this.onCloseTap, this.hasCloseIcon = true});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        const Spacer(),
        Text(
          title,
          style: Theme.of(context).textTheme.displayMedium,
        ),
        if (hasCloseIcon)
          Expanded(
            child: Align(
              alignment: Alignment.centerRight,
              child: GestureDetector(
                onTap: onCloseTap ?? () => Navigator.pop(context),
                behavior: HitTestBehavior.opaque,
                child: Padding(
                  padding: paddingOfCloseIcon ?? const EdgeInsets.all(16),
                  child: SvgPicture.asset(AppIcons.close),
                ),
              ),
            ),
          )
        else
          const Spacer()
      ],
    );
  }
}
