import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:i_watt_app/core/config/app_colors.dart';
import 'package:i_watt_app/core/config/app_constants.dart';
import 'package:i_watt_app/core/config/app_icons.dart';
import 'package:i_watt_app/core/util/extensions/build_context_extension.dart';
import 'package:i_watt_app/core/util/extensions/theme_mode_extension.dart';

class ThemeModeContainer extends StatelessWidget {
  const ThemeModeContainer({
    super.key,
    required this.value,
    required this.groupValue,
    required this.title,
    required this.image,
    required this.onChanged,
  });

  final ThemeMode value;
  final ThemeMode groupValue;
  final String title;
  final String image;
  final ValueChanged<ThemeMode> onChanged;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: value.isDark ? const EdgeInsets.symmetric(horizontal: 6) : EdgeInsets.zero,
      child: GestureDetector(
        onTap: () => onChanged(value),
        behavior: HitTestBehavior.opaque,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Stack(
              children: [
                AnimatedContainer(
                  duration: AppConstants.animationDuration,
                  margin: const EdgeInsets.only(bottom: 8),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8),
                    border: Border.all(
                      width: 2,
                      color: value == groupValue ? context.theme.primaryColor : Colors.transparent,
                    ),
                  ),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(6),
                    child: Image.asset(
                      image,
                      fit: BoxFit.cover,
                      height: 60,
                      width: (context.sizeOf.width - 80) / 3,
                    ),
                  ),
                ),
                Positioned(
                  right: 0,
                  left: 0,
                  bottom: 0,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        padding: const EdgeInsets.all(2),
                        decoration: const BoxDecoration(
                          shape: BoxShape.circle,
                          color: AppColors.white,
                        ),
                        child: AnimatedContainer(
                          height: 20,
                          width: 20,
                          duration: AppConstants.animationDuration,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: value == groupValue ? context.theme.primaryColor : Colors.transparent,
                            border: Border.all(
                              width: value == groupValue ? 0 : 1,
                              color: value == groupValue ? context.theme.primaryColor : AppColors.blueBayoux,
                            ),
                          ),
                          child: AnimatedSwitcher(
                            duration: AppConstants.animationDuration,
                            transitionBuilder: (child, anim) {
                              return ScaleTransition(scale: anim, child: child);
                            },
                            child: value == groupValue ? SvgPicture.asset(AppIcons.roundedCheck) : const SizedBox(),
                          ),
                        ),
                      ),
                    ],
                  ),
                )
              ],
            ),
            const SizedBox(height: 4),
            Text(
              title.tr(),
              style: context.textTheme.titleMedium?.copyWith(
                color: value == groupValue ? context.theme.primaryColor : AppColors.taxBreak,
              ),
            )
          ],
        ),
      ),
    );
  }
}
