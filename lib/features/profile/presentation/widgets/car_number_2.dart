import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:i_watt_app/core/config/app_colors.dart';
import 'package:i_watt_app/core/config/app_icons.dart';
import 'package:i_watt_app/core/util/extensions/build_context_extension.dart';

class CarNumber2 extends StatelessWidget {
  const CarNumber2({super.key, required this.number});
  final String number;

  @override
  Widget build(BuildContext context) {
    List n = [number.substring(2, 5), number.substring(5, 8)];

    print(n);
    return Container(
      // width: 112,
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(4),
        border: Border.all(color: AppColors.ebonyClay),
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
              color: AppColors.conifer,
            ),
            alignment: const Alignment(0.1, 0),
            child: Text(
              number.substring(0, 2),
              style: Theme.of(context).textTheme.bodyText2?.copyWith(fontFamily: 'UZBauto', fontSize: 16),
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
              padding: const EdgeInsets.only(left: 2, right: 2),
              child: Text(
                n[index].toString(),
                style: context.textTheme.titleLarge?.copyWith(
                  fontFamily: 'UZBauto',
                  color: AppColors.ebonyClay,
                  fontSize: 20,
                ),
              ),
            ),
          ),
          const SizedBox(width: 3),
          Column(
            children: [
              const SizedBox(height: 1),
              SvgPicture.asset(AppIcons.numberUzb),
              const SizedBox(height: 1),
              SvgPicture.asset(AppIcons.uz),
            ],
          ),
          const SizedBox(width: 4),
        ],
      ),
    );
  }
}
