import 'package:flutter/cupertino.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:i_watt_app/core/config/app_colors.dart';
import 'package:i_watt_app/core/config/app_icons.dart';

class UserImagePlaceholder extends StatelessWidget {
  const UserImagePlaceholder({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: AppColors.lillyWhite,
        borderRadius: BorderRadius.circular(10),
      ),
      child: SvgPicture.asset(
        AppIcons.userImagePlaceholder,
      ),
    );
  }
}
