import 'package:flutter/material.dart';
import 'package:i_watt_app/core/config/app_colors.dart';
import 'package:i_watt_app/core/util/extensions/build_context_extension.dart';

class CarNumber4 extends StatelessWidget {
  const CarNumber4({super.key, required this.number});
  final String number;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 32,
      decoration: BoxDecoration(
        color: AppColors.fruitSalad,
        borderRadius: BorderRadius.circular(6),
        border: Border.all(
          color: AppColors.fruitSalad,
          width: 1,
        ),
      ),
      child: Container(
        alignment: Alignment.center,
        padding: const EdgeInsets.symmetric(horizontal: 14),
        decoration: BoxDecoration(
          color: AppColors.fruitSalad,
          borderRadius: BorderRadius.circular(5),
          border: Border.all(color: AppColors.white, width: 1),
        ),
        child: Row(
          children: [
            Text(
              "${number.substring(0, 3)} ${number.substring(3, 5)}-${number.substring(5, 7)}",
              style: context.textTheme.titleLarge?.copyWith(
                fontFamily: 'UZBauto',
                fontSize: 22,
                color: AppColors.white,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
