import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:i_watt_app/core/util/extensions/build_context_extension.dart';
import 'package:i_watt_app/features/navigation/domain/entity/nav_bar.dart';

class NavBarItem extends StatelessWidget {
  final int currentIndex;
  final String? avatar;
  final NavBar navBar;

  const NavBarItem({
    this.avatar,
    required this.navBar,
    required this.currentIndex,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(top: 5, bottom: context.padding.bottom),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          SvgPicture.asset(
            navBar.icon,
            height: 24,
            width: 24,
            color: currentIndex == navBar.id
                ? context.theme.bottomNavigationBarTheme.selectedItemColor
                : context.theme.bottomNavigationBarTheme.unselectedItemColor,
          ),
          const SizedBox(height: 3),
          Text(
            navBar.title.tr(),
            overflow: TextOverflow.ellipsis,
            textAlign: TextAlign.center,
            maxLines: 1,
            style: currentIndex == navBar.id
                ? context.theme.bottomNavigationBarTheme.selectedLabelStyle
                : context.theme.bottomNavigationBarTheme.unselectedLabelStyle,
          ),
        ],
      ),
    );
  }
}
