import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:i_watt_app/core/config/app_icons.dart';
import 'package:i_watt_app/core/util/extensions/build_context_extension.dart';
import 'package:i_watt_app/generated/locale_keys.g.dart';

class LocationSingleHeaderAddress extends SliverPersistentHeaderDelegate {
  final String locationAddress;
  final String distance;
  const LocationSingleHeaderAddress({required this.locationAddress, required this.distance});
  @override
  Widget build(BuildContext context, double shrinkOffset, bool overlapsContent) {
    return Container(
      color: context.colorScheme.background,
      height: 56,
      padding: const EdgeInsets.symmetric(vertical: 6, horizontal: 16),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          // Row(
          //   children: [
          //     for (int i = 0; i < 5; i++)
          //       Padding(
          //         padding: const EdgeInsets.only(right: 2.0),
          //         child: SvgPicture.asset(AppIcons.star),
          //       ),
          //     const SizedBox(width: 2),
          //     Text(
          //       "5.0",
          //       style: context.textTheme.bodySmall!.copyWith(fontSize: 12, color: cyprus),
          //     ),
          //     const SizedBox(width: 4),
          //     Text(
          //       "(325)",
          //       style: context.textTheme.titleLarge!.copyWith(fontSize: 12, color: blueBayoux),
          //     ),
          //   ],
          // ),
          // const SizedBox(height: 12),
          Row(
            children: [
              Expanded(
                child: Text(
                  locationAddress,
                  maxLines: 2,
                  style: context.textTheme.titleMedium!.copyWith(
                    fontSize: 12,
                  ),
                ),
              ),
              if (distance.isNotEmpty && distance != '-1.0') ...{
                const SizedBox(width: 16),
                SvgPicture.asset(AppIcons.runner),
                const SizedBox(width: 4),
                Text(
                  "$distance ${LocaleKeys.km.tr()}",
                  style: context.textTheme.titleMedium!.copyWith(
                    fontSize: 12,
                  ),
                ),
              }
            ],
          ),
        ],
      ),
    );
  }

  @override
  double get maxExtent => 56;

  @override
  double get minExtent => 56;

  @override
  bool shouldRebuild(covariant SliverPersistentHeaderDelegate oldDelegate) => this != oldDelegate;
}
