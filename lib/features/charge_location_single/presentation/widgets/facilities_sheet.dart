import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_touch_ripple/flutter_touch_ripple.dart';
import 'package:i_watt_app/core/config/app_colors.dart';
import 'package:i_watt_app/core/util/extensions/build_context_extension.dart';
import 'package:i_watt_app/features/charge_location_single/presentation/widgets/facility_card_widget.dart';
import 'package:i_watt_app/features/common/domain/entities/id_name_entity.dart';
import 'package:i_watt_app/generated/locale_keys.g.dart';

class FacilitiesSheet extends StatelessWidget {
  final List<IdNameEntity> facilities;

  const FacilitiesSheet(this.facilities, {super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            Expanded(
              child: Padding(
                padding: const EdgeInsets.fromLTRB(17, 16, 0, 14),
                child: Text(
                  LocaleKeys.facilities.tr(),
                  style: context.textTheme.headlineLarge?.copyWith(fontSize: 17),
                ),
              ),
            ),
            TouchRipple(
              rippleColor: Colors.white.withAlpha(50),
              onTap: () => Navigator.pop(context),
              child: Padding(
                padding: const EdgeInsets.fromLTRB(8, 17, 7, 11),
                child: Text(
                  LocaleKeys.close.tr(),
                  style: context.textTheme.titleLarge!.copyWith(fontSize: 17, color: context.theme.primaryColor),
                ),
              ),
            ),
          ],
        ),
        const Divider(height: 1, color: AppColors.solitude),
        Expanded(
          child: NotificationListener(
            onNotification: (OverscrollIndicatorNotification notification) {
              notification.disallowIndicator();
              return false;
            },
            child: ListView.separated(
              separatorBuilder: (context, index) => const Divider(height: 1, color: AppColors.aliceBlue),
              itemCount: facilities.length,
              itemBuilder: (context, index) {
                return FacilityCardWidget(
                  icon: facilities[index].icon,
                  title: facilities[index].name,
                  facilities: facilities[index].descriptions,
                );
              },
            ),
          ),
        ),
      ],
    );
  }
}
