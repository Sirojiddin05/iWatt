import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:i_watt_app/core/config/app_icons.dart';
import 'package:i_watt_app/core/util/extensions/build_context_extension.dart';
import 'package:i_watt_app/features/charging_processes/presentation/widgets/charging_process_card_wrapper.dart';
import 'package:i_watt_app/generated/locale_keys.g.dart';

class ChargerInfoWidget extends StatelessWidget {
  final String address;
  final String cost;

  const ChargerInfoWidget({
    super.key,
    required this.address,
    required this.cost,
  });

  @override
  Widget build(BuildContext context) {
    return ChargingProcessCardWrapper(
      margin: const EdgeInsets.symmetric(horizontal: 16),
      child: Column(
        children: [
          Row(
            children: [
              SvgPicture.asset(AppIcons.plugCircle),
              const SizedBox(width: 8),
              Expanded(
                child: Text(
                  address,
                  style: context.textTheme.headlineSmall,
                ),
              ),
              const SizedBox(width: 12),
            ],
          ),
          Divider(height: 17, color: context.theme.dividerColor, indent: 25),
          Row(
            children: [
              SvgPicture.asset(AppIcons.parking),
              const SizedBox(width: 6),
              Text(
                '${getCost()} ${LocaleKeys.sum.tr()}/${LocaleKeys.minute_plural_genitive.tr()}',
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: context.textTheme.headlineSmall,
              ),
              const Spacer(),
            ],
          ),
        ],
      ),
    );
  }

  String getCost() {
    if (cost.contains('-1') || cost.contains('-1.0')) {
      return '-';
    }
    return cost;
  }
}
