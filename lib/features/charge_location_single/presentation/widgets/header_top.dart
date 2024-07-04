import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:i_watt_app/core/config/app_icons.dart';
import 'package:i_watt_app/core/util/extensions/build_context_extension.dart';
import 'package:i_watt_app/features/common/presentation/widgets/w_scale_animation.dart';

class LocationSingleHeaderTop extends SliverPersistentHeaderDelegate {
  final String locationName;

  const LocationSingleHeaderTop({required this.locationName});

  @override
  Widget build(BuildContext context, double shrinkOffset, bool overlapsContent) {
    return Container(
      height: 70,
      padding: const EdgeInsets.fromLTRB(16, 24, 16, 6),
      color: context.colorScheme.primaryContainer,
      child: Row(
        children: [
          Expanded(
            child: Text(
              locationName,
              style: context.textTheme.displayMedium,
              maxLines: 2,
            ),
          ),
          const SizedBox(width: 12),
          WScaleAnimation(
            onTap: () => Navigator.pop(context),
            child: SvgPicture.asset(AppIcons.circleClose),
          ),
        ],
      ),
    );
  }

  @override
  double get maxExtent => 70;

  @override
  double get minExtent => 70;

  @override
  bool shouldRebuild(covariant SliverPersistentHeaderDelegate oldDelegate) => this != oldDelegate;
}
