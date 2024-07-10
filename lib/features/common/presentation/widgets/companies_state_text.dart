import 'package:flutter/material.dart';
import 'package:i_watt_app/core/config/app_constants.dart';
import 'package:i_watt_app/core/util/extensions/build_context_extension.dart';

class CompaniesStateText extends StatelessWidget {
  const CompaniesStateText({
    super.key,
    required this.vendors,
  });

  final String vendors;

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.centerLeft,
      child: AnimatedSwitcher(
        duration: AppConstants.animationDuration,
        transitionBuilder: (child, animation) => SizeTransition(
          axisAlignment: 1,
          sizeFactor: animation,
          child: child,
        ),
        child: Text(
          vendors,
          key: ValueKey(vendors),
          maxLines: 2,
          textAlign: TextAlign.left,
          overflow: TextOverflow.ellipsis,
          style: context.textTheme.headlineSmall?.copyWith(fontSize: 15),
        ),
      ),
    );
  }
}
