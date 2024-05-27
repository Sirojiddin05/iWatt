import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:i_watt_app/core/config/app_colors.dart';
import 'package:i_watt_app/core/config/app_icons.dart';
import 'package:i_watt_app/core/util/extensions/build_context_extension.dart';
import 'package:i_watt_app/features/common/presentation/widgets/w_custom_tappable_button.dart';
import 'package:i_watt_app/generated/locale_keys.g.dart';

class DeleteAccountButton extends StatelessWidget {
  final VoidCallback onDelete;
  const DeleteAccountButton({super.key, required this.onDelete});

  @override
  Widget build(BuildContext context) {
    return WCustomTappableButton(
      //TODO adaptivedialog
      onTap: onDelete,
      borderRadius: BorderRadius.circular(22),
      rippleColor: AppColors.amaranth.withAlpha(30),
      child: Padding(
        padding: const EdgeInsets.all(8),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            SvgPicture.asset(AppIcons.trash),
            const SizedBox(width: 4),
            Text(
              LocaleKeys.delete_account.tr(),
              style: context.textTheme.bodySmall?.copyWith(color: AppColors.amaranth),
            ),
          ],
        ),
      ),
    );
  }
}
