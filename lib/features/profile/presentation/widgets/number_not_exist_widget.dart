import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:i_watt_app/core/config/app_colors.dart';
import 'package:i_watt_app/core/config/app_icons.dart';
import 'package:i_watt_app/core/util/extensions/build_context_extension.dart';
import 'package:i_watt_app/generated/locale_keys.g.dart';

class NumberNotExistWidget extends StatelessWidget {
  final String? number;
  const NumberNotExistWidget({super.key, this.number});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: (context.sizeOf.width - 64) / 2,
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(6),
        border: Border.all(color: AppColors.ebonyClay),
      ),
      padding: const EdgeInsets.fromLTRB(14, 4, 6, 4),
      child: Row(
        children: [
          Expanded(
            child: Text(
              getNumber(),
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: context.textTheme.labelSmall?.copyWith(
                fontWeight: FontWeight.w500,
                fontSize: 12,
              ),
            ),
          ),
          const SizedBox(width: 14),
          Column(
            children: [
              const SizedBox(height: 1),
              SvgPicture.asset(AppIcons.numberUzb),
              const SizedBox(height: 1),
              SvgPicture.asset(AppIcons.uz),
            ],
          ),
        ],
      ),
    );
  }

  String getNumber() {
    if (number == null || number!.isEmpty) {
      return LocaleKeys.no_number.tr();
    }
    return number!;
  }
}
