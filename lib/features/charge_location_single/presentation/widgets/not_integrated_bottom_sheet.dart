import 'dart:io';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:i_watt_app/core/config/app_icons.dart';
import 'package:i_watt_app/core/util/extensions/build_context_extension.dart';
import 'package:i_watt_app/features/charge_location_single/presentation/widgets/location_single_card_wrapper.dart';
import 'package:i_watt_app/features/common/presentation/widgets/sheet_header_container.dart';
import 'package:i_watt_app/features/common/presentation/widgets/w_button.dart';
import 'package:i_watt_app/features/common/presentation/widgets/w_image.dart';
import 'package:i_watt_app/features/common/presentation/widgets/w_scale_animation.dart';
import 'package:i_watt_app/generated/locale_keys.g.dart';
import 'package:url_launcher/url_launcher_string.dart';

class NotIntegratedBottomSheet extends StatelessWidget {
  final String locationName;
  final String locationAddress;
  final String distance;
  final String? vendorName;
  final String? vendorLogo;
  final String? organizationName;
  final String? appStoreUrl;
  final String? playMarketUrl;

  const NotIntegratedBottomSheet({
    super.key,
    required this.locationName,
    required this.locationAddress,
    required this.distance,
    required this.vendorName,
    required this.vendorLogo,
    required this.organizationName,
    required this.appStoreUrl,
    required this.playMarketUrl,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: context.colorScheme.primaryContainer,
        borderRadius: const BorderRadius.vertical(top: Radius.circular(24)),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const SheetHeadContainer(),
          Padding(
            padding: const EdgeInsets.fromLTRB(16, 16, 16, 0),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
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
                  child: SvgPicture.asset(
                    AppIcons.clearRounded,
                    height: 28,
                    width: 28,
                  ),
                ),
              ],
            ),
          ),
          Padding(
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
          ),
          ColoredBox(
            color: context.themedColors.solitudeToSolitudeO4,
            child: Column(
              children: [
                LocationSingleCardWrapper(
                  padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
                  margin: const EdgeInsets.symmetric(vertical: 15, horizontal: 16),
                  child: Text(
                    LocaleKeys.not_integrated_hint_text.tr(),
                    style: context.textTheme.titleMedium?.copyWith(fontSize: 12),
                  ),
                ),
                Container(
                  padding: const EdgeInsets.all(20),
                  color: context.colorScheme.primaryContainer,
                  child: Row(
                    children: [
                      WImage(
                        width: 100,
                        height: 100,
                        borderRadius: BorderRadius.circular(24),
                        imageUrl: vendorLogo ?? '',
                        errorWidget: Padding(padding: const EdgeInsets.all(16), child: SvgPicture.asset(AppIcons.logoPlaceholder)),
                      ),
                      const SizedBox(width: 16),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(vendorName ?? "", style: context.textTheme.displayMedium),
                          Text(organizationName ?? "", style: context.textTheme.labelMedium),
                          const SizedBox(height: 20),
                          WButton(
                            onTap: () {
                              if (Platform.isAndroid) {
                                launchUrlString(playMarketUrl!);
                              } else if (Platform.isIOS) {
                                launchUrlString(appStoreUrl!);
                              }
                            },
                            color: context.colorScheme.primary,
                            borderRadius: 20,
                            height: 34,
                            padding: const EdgeInsets.symmetric(horizontal: 16),
                            text: LocaleKeys.download.tr(),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                SizedBox(height: context.padding.bottom)
              ],
            ),
          ),
        ],
      ),
    );
  }
}
