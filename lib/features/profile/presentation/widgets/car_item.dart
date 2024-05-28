import 'package:flutter/material.dart';
import 'package:i_watt_app/core/config/app_colors.dart';
import 'package:i_watt_app/core/util/extensions/build_context_extension.dart';
import 'package:i_watt_app/core/util/my_functions.dart';
import 'package:i_watt_app/features/common/presentation/widgets/w_custom_tappable_button.dart';
import 'package:i_watt_app/features/profile/presentation/widgets/car_number_switcher.dart';
import 'package:i_watt_app/features/profile/presentation/widgets/connector_name_widget.dart';

class CarItem extends StatelessWidget {
  CarItem({
    super.key,
    required this.model,
    required this.manafactur,
    required this.number,
    required this.type,
    required this.onTap,
  }) : numberType = MyFunctions.carNumberType(number);

  final String model;
  final String manafactur;
  final String number;
  final VoidCallback onTap;
  final List<String> type;
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
                  manafactur,
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
                if (type.length > 1) ...{
                  ConnectorTitleWidget(type: (type.length - 1).toString()),
                  const SizedBox(width: 4),
                },
                if (type.isNotEmpty) ...{
                  ConnectorTitleWidget(type: type[0]),
                }
              ],
            )
          ],
        ),
      ),
    );
  }
}
