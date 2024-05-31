import 'package:flutter/material.dart';
import 'package:i_watt_app/core/config/app_colors.dart';
import 'package:i_watt_app/core/util/extensions/build_context_extension.dart';
import 'package:i_watt_app/core/util/my_functions.dart';
import 'package:i_watt_app/features/common/domain/entities/id_name_entity.dart';
import 'package:i_watt_app/features/common/presentation/widgets/w_custom_tappable_button.dart';
import 'package:i_watt_app/features/profile/presentation/widgets/car_number_switcher.dart';
import 'package:i_watt_app/features/profile/presentation/widgets/connector_name_widget.dart';

class CarItem extends StatelessWidget {
  CarItem({
    super.key,
    required this.model,
    required this.manufacturer,
    required this.number,
    required this.connectorTypes,
    required this.onTap,
  }) : numberType = MyFunctions.carNumberType(number);

  final String model;
  final String manufacturer;
  final String number;
  final VoidCallback onTap;
  final List<IdNameEntity> connectorTypes;
  final int numberType;

  @override
  Widget build(BuildContext context) {
    return WCustomTappableButton(
      onTap: onTap,
      rippleColor: AppColors.cyprusRipple30,
      borderRadius: BorderRadius.circular(14),
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: AppColors.white,
          borderRadius: BorderRadius.circular(14),
          boxShadow: [
            BoxShadow(
              offset: const Offset(0, 6),
              blurRadius: 32,
              spreadRadius: 0,
              color: AppColors.baliHai.withOpacity(.16),
            ),
          ],
        ),
        child: Column(
          children: [
            Row(
              children: [
                Text(
                  manufacturer,
                  style: context.textTheme.titleSmall!.copyWith(
                    color: AppColors.deepFir,
                    fontWeight: FontWeight.w500,
                    fontSize: 16,
                  ),
                ),
                const SizedBox(width: 6),
                Expanded(
                  child: Text(
                    model,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: context.textTheme.titleSmall!.copyWith(
                      color: AppColors.deepFir,
                      fontWeight: FontWeight.w700,
                      fontSize: 16,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 12),
            Row(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                CarNumberSwitcher(numberType: numberType, number: number),
                const Spacer(),
                if (connectorTypes.length > 1) ...{
                  ConnectorTitleWidget(type: '+${connectorTypes.length - 1}'),
                  const SizedBox(width: 4),
                },
                if (connectorTypes.isNotEmpty) ...{
                  ConnectorTitleWidget(type: connectorTypes.first.name),
                }
              ],
            )
          ],
        ),
      ),
    );
  }
}
