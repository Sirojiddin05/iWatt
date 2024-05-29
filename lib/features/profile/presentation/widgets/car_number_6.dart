import 'package:flutter/material.dart';
import 'package:i_watt_app/core/config/app_colors.dart';
import 'package:i_watt_app/core/util/extensions/build_context_extension.dart';

class CarNumber6 extends StatelessWidget {
  const CarNumber6({super.key, required this.number});
  final String number;
  @override
  Widget build(BuildContext context) {
    List n = [number.substring(2, 3), number.substring(3, 9)];
    return Container(
      decoration: BoxDecoration(
        color: AppColors.fruitSalad,
        borderRadius: BorderRadius.circular(6),
        border: Border.all(
          color: AppColors.fruitSalad,
          width: 1,
        ),
      ),
      child: Container(
        decoration: BoxDecoration(
          color: AppColors.fruitSalad,
          borderRadius: BorderRadius.circular(5),
          border: Border.all(
            color: AppColors.white,
            width: 1,
          ),
        ),
        child: Row(
          children: [
            Container(
              height: 32,
              width: 32,
              decoration: const BoxDecoration(
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(3),
                  bottomLeft: Radius.circular(3),
                ),
                color: AppColors.fruitSalad,
              ),
              alignment: const Alignment(0.1, 0),
              child: Text(
                number.substring(0, 2),
                style: context.textTheme.titleLarge?.copyWith(
                  fontFamily: 'UZBauto',
                  fontSize: 18,
                  color: AppColors.white,
                ),
              ),
            ),
            Container(
              width: 1,
              height: 32,
              color: AppColors.white,
              margin: const EdgeInsets.only(right: 4),
            ),
            ...List.generate(
              n.length,
              (index) => Padding(
                padding: const EdgeInsets.only(left: 2, right: 1),
                child: Text(
                  n[index].toString(),
                  style: context.textTheme.titleLarge?.copyWith(
                    fontFamily: 'UZBauto',
                    fontSize: 22,
                    color: AppColors.white,
                  ),
                ),
              ),
            ),
            const SizedBox(width: 10),
          ],
        ),
      ),
    );
  }
}
