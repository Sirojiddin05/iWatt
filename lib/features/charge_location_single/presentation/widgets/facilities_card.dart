import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:i_watt_app/core/config/app_colors.dart';
import 'package:i_watt_app/core/config/app_icons.dart';
import 'package:i_watt_app/core/util/extensions/build_context_extension.dart';
import 'package:i_watt_app/features/charge_location_single/presentation/widgets/facilities_sheet.dart';
import 'package:i_watt_app/features/charge_location_single/presentation/widgets/location_single_card_wrapper.dart';
import 'package:i_watt_app/features/common/domain/entities/id_name_entity.dart';
import 'package:i_watt_app/features/common/presentation/widgets/w_custom_tappable_button.dart';
import 'package:i_watt_app/features/common/presentation/widgets/w_scale_animation.dart';
import 'package:i_watt_app/generated/locale_keys.g.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';

class FacilitiesCard extends StatelessWidget {
  final List<IdNameEntity> facilities;

  const FacilitiesCard({super.key, required this.facilities});

  @override
  Widget build(BuildContext context) {
    return LocationSingleCardWrapper(
      padding: EdgeInsets.zero,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.only(top: 16, left: 16),
                  child: Text(
                    LocaleKeys.facilities.tr(),
                    style: context.textTheme.headlineLarge,
                  ),
                ),
              ),
              WScaleAnimation(
                onTap: () {
                  showCupertinoModalBottomSheet(
                    context: context,
                    backgroundColor: AppColors.white,
                    builder: (context) => FacilitiesSheet(facilities),
                  );
                },
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(16, 16, 16, 12),
                  child: Row(
                    children: [
                      Text(
                        LocaleKeys.all.tr(),
                        style: context.textTheme.headlineSmall!.copyWith(
                          color: AppColors.shuttleGrey,
                        ),
                      ),
                      const SizedBox(width: 4),
                      SvgPicture.asset(AppIcons.chevronRightGrey, width: 16, height: 16),
                    ],
                  ),
                ),
              ),
            ],
          ),
          Container(
            padding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
            // width: double.infinity,
            child: Wrap(
              spacing: 6,
              runSpacing: 6,
              alignment: WrapAlignment.start,
              crossAxisAlignment: WrapCrossAlignment.start,
              runAlignment: WrapAlignment.start,
              children: List.generate(
                facilities.length > 8 ? 9 : facilities.length,
                (index) {
                  if (facilities.length > 8 && index == 8) {
                    return WCustomTappableButton(
                      onTap: () {
                        showCupertinoModalBottomSheet(
                          context: context,
                          backgroundColor: AppColors.white,
                          builder: (context) => FacilitiesSheet(facilities),
                        );
                      },
                      borderRadius: BorderRadius.circular(41),
                      rippleColor: AppColors.white.withAlpha(30),
                      child: Container(
                        padding: const EdgeInsets.fromLTRB(6, 6, 12, 6),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(41),
                          color: AppColors.dodgerBlue,
                        ),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            SvgPicture.asset(AppIcons.plusWhite, width: 16, height: 16),
                            const SizedBox(width: 4),
                            Text(
                              "${LocaleKeys.yet.tr()} ${facilities.length - 8}",
                              style: context.textTheme.titleSmall!.copyWith(
                                fontSize: 12,
                                color: AppColors.white,
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  }
                  return Container(
                    padding: const EdgeInsets.fromLTRB(6, 6, 12, 6),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(41),
                      color: AppColors.solitude2,
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        if (facilities[index].icon.isNotEmpty &&
                            facilities[index].icon.contains("https") &&
                            facilities[index].icon.contains("svg")) ...{
                          SvgPicture.network(facilities[index].icon, width: 16, height: 16),
                          const SizedBox(width: 4),
                        } else ...{
                          SvgPicture.asset(AppIcons.iconPlaceHolder, width: 16, height: 16),
                        },
                        Text(
                          facilities[index].name,
                          style: context.textTheme.titleSmall!.copyWith(
                            fontSize: 12,
                            color: AppColors.cyprus,
                          ),
                        ),
                      ],
                    ),
                  );
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}
