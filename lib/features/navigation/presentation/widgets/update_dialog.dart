import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:i_watt_app/core/config/app_images.dart';
import 'package:i_watt_app/core/util/extensions/build_context_extension.dart';
import 'package:i_watt_app/features/common/presentation/widgets/w_button.dart';
import 'package:i_watt_app/generated/locale_keys.g.dart';

class UpdateDialog extends StatelessWidget {
  final bool isRequired;

  const UpdateDialog({super.key, required this.isRequired});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        width: context.sizeOf.width * .68,
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            SvgPicture.asset(AppImages.updateDialogVector),
            const SizedBox(height: 24),
            Text(
              LocaleKeys.update_app.tr(),
              textAlign: TextAlign.center,
              style: context.textTheme.displaySmall,
            ),
            const SizedBox(height: 5),
            Text(
              isRequired ? LocaleKeys.update_app_subtitle.tr() : LocaleKeys.update_app_subtitle_2.tr(),
              textAlign: TextAlign.center,
              style: context.textTheme.labelMedium?.copyWith(
                color: context.textTheme.titleSmall?.color,
              ),
            ),
            const SizedBox(height: 16),
            Row(
              children: [
                if (!isRequired) ...{
                  Expanded(
                    child: WButton(
                      height: 44,
                      color: context.theme.scaffoldBackgroundColor,
                      text: LocaleKeys.skip.tr(),
                      textStyle: context.textTheme.bodyLarge,
                      onTap: () => Navigator.pop(context),
                    ),
                  ),
                  const SizedBox(width: 10),
                },
                Expanded(
                  child: WButton(
                    height: 44,
                    text: LocaleKeys.update.tr(),
                    onTap: () {},
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
