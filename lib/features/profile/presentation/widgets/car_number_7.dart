import 'package:flutter/material.dart';
import 'package:i_watt_app/core/config/app_colors.dart';
import 'package:i_watt_app/core/util/extensions/build_context_extension.dart';

class CarNumber7 extends StatelessWidget {
  const CarNumber7({super.key, required this.number});
  final String number;
  @override
  Widget build(BuildContext context) {
    List n = [number.substring(2, 3), number.substring(3, 8)];

    return Container(
      decoration: BoxDecoration(
        color: AppColors.kournikova,
        borderRadius: BorderRadius.circular(6),
        border: Border.all(color: AppColors.kournikova, width: 1),
      ),
      child: Container(
        // width: 112,
        decoration: BoxDecoration(
          color: AppColors.kournikova,
          borderRadius: BorderRadius.circular(5),
          border: Border.all(color: AppColors.ebonyClay, width: 1),
        ),
        child: Row(
          children: [
            Container(
              padding: const EdgeInsets.fromLTRB(5, 0, 5, 2),
              decoration: const BoxDecoration(
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(3),
                  bottomLeft: Radius.circular(3),
                ),
                color: AppColors.kournikova,
              ),
              alignment: const Alignment(0.1, 0),
              child: Text(
                number.substring(0, 2),
                style: context.textTheme.titleLarge?.copyWith(
                  fontFamily: 'UZBauto',
                  fontSize: 16,
                ),
              ),
            ),
            Container(
              width: 1,
              height: 32,
              color: AppColors.ebonyClay,
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
                    fontSize: 20,
                    color: AppColors.ebonyClay,
                  ),
                ),
              ),
            ),
            const SizedBox(width: 4),
          ],
        ),
      ),
    );
  }
}
