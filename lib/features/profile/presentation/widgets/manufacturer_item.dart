import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:i_watt_app/core/config/app_colors.dart';
import 'package:i_watt_app/core/config/app_icons.dart';
import 'package:i_watt_app/core/util/extensions/build_context_extension.dart';
import 'package:i_watt_app/features/common/presentation/widgets/w_custom_tappable_button.dart';

class ManufacturerItem extends StatelessWidget {
  final VoidCallback onTap;
  final String icon;
  final String title;
  const ManufacturerItem({super.key, required this.onTap, required this.icon, required this.title});

  @override
  Widget build(BuildContext context) {
    return WCustomTappableButton(
      onTap: onTap,
      borderRadius: BorderRadius.zero,
      rippleColor: context.theme.primaryColor.withAlpha(30),
      child: Padding(
        padding: const EdgeInsets.fromLTRB(16, 10, 12, 10),
        child: Row(
          children: [
            Container(
              height: 32,
              width: 32,
              margin: const EdgeInsets.only(right: 10),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(6),
                border: Border.all(color: AppColors.zircon),
              ),
              alignment: Alignment.center,
              child: Builder(
                builder: (context) {
                  if (!(icon.contains('https://'))) {
                    if (icon.isEmpty) {
                      return SvgPicture.asset(AppIcons.smallCarPlaceHolder);
                    }
                    return SvgPicture.asset(icon);
                  }
                  return SvgPicture.network(icon);
                },
              ),
            ),
            Expanded(
              child: Text(
                title,
                textAlign: TextAlign.left,
                style: context.theme.textTheme.bodyMedium,
              ),
            ),
            SvgPicture.asset(AppIcons.chevronRightGrey)
          ],
        ),
      ),
    );
  }
}
