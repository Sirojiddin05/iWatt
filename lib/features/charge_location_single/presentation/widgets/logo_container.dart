import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:i_watt_app/core/config/app_colors.dart';
import 'package:i_watt_app/core/config/app_icons.dart';
import 'package:i_watt_app/features/common/presentation/widgets/w_image.dart';

class LogoContainer extends StatelessWidget {
  final String logo;
  const LogoContainer({super.key, required this.logo});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 64,
      width: 64,
      foregroundDecoration: BoxDecoration(
        border: Border.all(
          color: AppColors.lavender.withOpacity(0.1),
        ),
        borderRadius: BorderRadius.circular(16),
      ),
      child: WImage(
        imageUrl: logo,
        fit: BoxFit.fill,
        height: 62,
        width: 62,
        borderRadius: BorderRadius.circular(16),
        errorWidget: Padding(padding: const EdgeInsets.all(16), child: SvgPicture.asset(AppIcons.logoPlaceholder)),
      ),
    );
  }
}
