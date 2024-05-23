import 'package:flutter/material.dart';
import 'package:i_watt_app/core/util/extensions/build_context_extension.dart';

class ListOpacityContainer extends StatelessWidget {
  const ListOpacityContainer({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 20,
      margin: const EdgeInsets.symmetric(horizontal: 16),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          tileMode: TileMode.decal,
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [
            context.theme.scaffoldBackgroundColor,
            context.theme.scaffoldBackgroundColor.withOpacity(.6),
            context.theme.scaffoldBackgroundColor.withOpacity(.5),
            context.theme.scaffoldBackgroundColor.withOpacity(.4),
            context.theme.scaffoldBackgroundColor.withOpacity(.3),
            context.theme.scaffoldBackgroundColor.withOpacity(.2),
            context.theme.scaffoldBackgroundColor.withOpacity(.1),
            context.theme.scaffoldBackgroundColor.withOpacity(0),
          ],
        ),
      ),
    );
  }
}
