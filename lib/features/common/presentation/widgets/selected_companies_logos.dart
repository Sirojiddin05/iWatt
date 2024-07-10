import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:i_watt_app/core/config/app_colors.dart';
import 'package:i_watt_app/core/config/app_icons.dart';
import 'package:i_watt_app/core/util/extensions/build_context_extension.dart';
import 'package:i_watt_app/features/common/domain/entities/id_name_entity.dart';
import 'package:i_watt_app/features/common/presentation/widgets/w_image.dart';

class SelectedCompaniesLogos extends StatelessWidget {
  final List<IdNameEntity> vendors;

  const SelectedCompaniesLogos({
    super.key,
    required this.vendors,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: List.generate(vendors.length <= 9 ? vendors.length : 10, (index) {
        if (index == 9) {
          return Positioned(
            left: index * 20,
            child: Container(
              width: 30,
              height: 30,
              alignment: Alignment.center,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                color: AppColors.dodgerBlue,
                border: Border.all(
                  color: context.themedColors.whiteToTangaroa2,
                ),
              ),
              child: Text("+${vendors.length - 9}", style: context.textTheme.labelLarge),
            ),
          );
        }
        return Positioned(
          left: index * 20,
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              color: AppColors.white,
              border: Border.all(
                color: context.themedColors.whiteToTangaroa2,
              ),
            ),
            child: WImage(
                imageUrl: vendors[index].logo,
                width: 28,
                height: 28,
                borderRadius: BorderRadius.circular(20),
                errorWidget: ColoredBox(
                  color: AppColors.white,
                  child: Padding(
                    padding: const EdgeInsets.all(8),
                    child: SvgPicture.asset(
                      AppIcons.logoPlaceholder,
                      color: AppColors.zircon,
                    ),
                  ),
                )),
          ),
        );
      }).toList(),
    );
  }
}
