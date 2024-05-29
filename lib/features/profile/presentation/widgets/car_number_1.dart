import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:i_watt_app/core/config/app_colors.dart';
import 'package:i_watt_app/core/config/app_icons.dart';
import 'package:i_watt_app/core/util/extensions/build_context_extension.dart';

class CarNumber1 extends StatelessWidget {
  const CarNumber1({super.key, required this.number});
  final String number;

  @override
  Widget build(BuildContext context) {
    List n = [number[2], number.substring(3, 6), number.substring(6, 8)];
    return Container(
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(4),
        border: Border.all(
          color: AppColors.ebonyClay,
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
              color: AppColors.conifer,
            ),
            alignment: const Alignment(0.2, 0),
            child: Text(
              number.substring(0, 2),
              style: context.textTheme.labelMedium?.copyWith(
                fontFamily: 'UZBauto',
                fontSize: 16,
                color: AppColors.ebonyClay,
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
                  color: AppColors.ebonyClay,
                  fontSize: 22,
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
