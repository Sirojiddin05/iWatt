import 'package:flutter/material.dart';
import 'package:i_watt_app/core/config/app_colors.dart';
import 'package:i_watt_app/core/util/extensions/build_context_extension.dart';

class CarNumber3 extends StatelessWidget {
  const CarNumber3({super.key, required this.number});
  final String number;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 32,
      decoration: BoxDecoration(
        color: AppColors.freeSpeechBlue,
        borderRadius: BorderRadius.circular(6),
        border: Border.all(
          color: AppColors.freeSpeechBlue,
          width: 1,
        ),
      ),
      child: Container(
        alignment: Alignment.center,
        decoration: BoxDecoration(
          color: AppColors.freeSpeechBlue,
          borderRadius: BorderRadius.circular(5),
          border: Border.all(
            color: AppColors.white,
            width: 1,
          ),
        ),
        padding: const EdgeInsets.symmetric(horizontal: 12),
        child: Text(
          "${number.substring(0, 2)}  ${number.substring(2, 6).toString()}",
          style: context.textTheme.titleLarge?.copyWith(
            fontFamily: 'UZBauto',
            fontSize: 20,
            color: AppColors.white,
          ),
        ),
      ),
    );
  }
}
