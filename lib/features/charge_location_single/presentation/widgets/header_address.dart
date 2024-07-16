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
      color: context.colorScheme.primaryContainer,
      height: 56,
      padding: const EdgeInsets.symmetric(vertical: 6, horizontal: 16),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
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
