import 'package:flutter/material.dart';
import 'package:i_watt_app/core/config/app_colors.dart';
import 'package:i_watt_app/core/util/extensions/build_context_extension.dart';

class CarNumber5 extends StatelessWidget {
  const CarNumber5({super.key, required this.number});
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
        decoration: BoxDecoration(
          color: AppColors.fruitSalad,
          borderRadius: BorderRadius.circular(5),
          border: Border.all(
            color: AppColors.white,
            width: 1,
          ),
        ),
        padding: const EdgeInsets.symmetric(horizontal: 15),
        child: Text(
          "${number.substring(0, 1)} ${number.substring(1, 7)}",
          style: context.textTheme.titleLarge?.copyWith(
            fontFamily: 'UZBauto',
            fontSize: 22,
            color: AppColors.white,
          ),
        ),
      ),
    );
  }
}
