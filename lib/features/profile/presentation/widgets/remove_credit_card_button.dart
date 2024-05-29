import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:i_watt_app/core/config/app_colors.dart';
import 'package:i_watt_app/core/util/extensions/build_context_extension.dart';
import 'package:i_watt_app/features/common/presentation/widgets/adaptive_dialog.dart';
import 'package:i_watt_app/features/common/presentation/widgets/w_button.dart';
import 'package:i_watt_app/generated/locale_keys.g.dart';

class RemoveCreditCardButton extends StatelessWidget {
  const RemoveCreditCardButton({super.key});

  @override
  Widget build(BuildContext context) {
    return WButton(
      color: AppColors.amaranth,
      text: LocaleKeys.remove.tr(),
      onTap: () {
        showCustomAdaptiveDialog(
          context,
          title: "Вы действительно хотите удалить карту?",
          cancelStyle: context.textTheme.headlineLarge?.copyWith(
            color: AppColors.dodgerBlue,
          ),
          confirmText: LocaleKeys.remove.tr(),
          confirmStyle: context.textTheme.headlineLarge?.copyWith(
            fontWeight: FontWeight.w400,
            color: AppColors.amaranth,
          ),
          onConfirm: () {},
        );
      },
    );
  }
}
