import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:i_watt_app/core/config/app_colors.dart';
import 'package:i_watt_app/core/config/app_images.dart';
import 'package:i_watt_app/core/util/extensions/build_context_extension.dart';
import 'package:i_watt_app/features/map/presentation/widgets/animated_size_scale_map_widget.dart';
import 'package:i_watt_app/generated/locale_keys.g.dart';

class ParkingMessageContainer extends StatelessWidget {
  const ParkingMessageContainer({super.key});

  @override
  Widget build(BuildContext context) {
    return AnimatedScaleSizeWidget(
      buttonText: LocaleKeys.more_details.tr(),
      onButtonTap: () {},
      iconPath: AppImages.parkingInProgress,
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            LocaleKeys.parking_fees_apply.tr(),
            style: context.textTheme.labelSmall!.copyWith(color: AppColors.blueBayoux, fontSize: 12),
          ),
          const SizedBox(height: 2),
          //TODO: Remove Static data and set real
          Text(
            '1000 so‘m/daqiqasi',
            style: context.textTheme.headlineSmall!.copyWith(color: AppColors.darkTurquoise, fontSize: 12),
          )
        ],
      ),
      isVisible: false,
      width: context.sizeOf.width - 32,
    );
  }
}
