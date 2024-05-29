import 'package:flutter/material.dart';
import 'package:i_watt_app/core/util/extensions/build_context_extension.dart';
import 'package:i_watt_app/features/common/presentation/widgets/chevron_back_button.dart';

class AppBarWrapper extends StatelessWidget implements PreferredSizeWidget {
  final bool hasBackButton;
  final String title;
  final String subtitle;
  final Widget? child;
  final List<Widget> actions;
  final PreferredSizeWidget? bottom;
  final Color? backgroundColor;

  const AppBarWrapper({
    super.key,
    this.hasBackButton = false,
    this.title = '',
    this.subtitle = '',
    this.child,
    this.actions = const [],
    this.bottom,
    this.backgroundColor,
  });

  @override
  Widget build(BuildContext context) {
    return AppBar(
      leadingWidth: 0,
      titleSpacing: 0,
      automaticallyImplyLeading: false,
      elevation: 20,
      scrolledUnderElevation: 10,
      backgroundColor: backgroundColor ?? context.appBarTheme.backgroundColor,
      shadowColor: context.theme.shadowColor,
      surfaceTintColor: context.theme.appBarTheme.backgroundColor,
      title: child ??
          Row(
            children: [
              if (hasBackButton)
                const Expanded(
                  child: Align(
                    alignment: Alignment.centerLeft,
                    child: ChevronBackButton(),
                  ),
                ),
              if (subtitle.isEmpty)
                Padding(
                  padding: const EdgeInsets.fromLTRB(20, 16, 20, 17),
                  child: Text(
                    title,
                    style: context.textTheme.headlineLarge,
                  ),
                )
              else
                Column(
                  children: [
                    Text(
                      title,
                      style: context.textTheme.headlineLarge,
                    ),
                    Text(
                      subtitle,
                      style: context.textTheme.labelMedium
                          ?.copyWith(color: Theme.of(context).inputDecorationTheme.labelStyle?.color),
                    ),
                  ],
                ),
              if (actions.isNotEmpty)
                Expanded(child: Row(mainAxisAlignment: MainAxisAlignment.end, children: actions))
              else
                const Spacer()
            ],
          ),
      bottom: bottom,
    );
  }

  @override
  Size get preferredSize => _getPreferredSize();

  Size _getPreferredSize() {
    final appBarSize = AppBar().preferredSize;
    if (bottom == null) {
      return appBarSize;
    }
    final appBarHeight = appBarSize.height;
    final bottomHeight = bottom!.preferredSize.height;
    return Size.fromHeight(appBarHeight + bottomHeight);
  }
}
