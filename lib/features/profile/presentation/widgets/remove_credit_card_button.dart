import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:i_watt_app/core/config/app_colors.dart';
import 'package:i_watt_app/core/util/extensions/build_context_extension.dart';
import 'package:i_watt_app/features/common/presentation/widgets/adaptive_dialog.dart';
import 'package:i_watt_app/features/common/presentation/widgets/w_button.dart';
import 'package:i_watt_app/generated/locale_keys.g.dart';

class RemoveCreditCardButton extends StatelessWidget {
  final VoidCallback onRemove;
  final bool isDisabled;
  final bool isLoading;
  final VoidCallback onCancel;

  const RemoveCreditCardButton({super.key, required this.onRemove, required this.isDisabled, required this.isLoading, required this.onCancel});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 6),
      child: Row(
        children: [
          Expanded(
            child: WButton(
              color: AppColors.solitude,
              textColor: AppColors.cyprus,
              text: LocaleKeys.cancel.tr(),
              onTap: () {
                onCancel();
              },
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: WButton(
              color: AppColors.amaranth,
              isDisabled: isDisabled,
              isLoading: isLoading,
              disabledTextColor: AppColors.white,
              disabledColor: AppColors.amaranth.withOpacity(.5),
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
                  onConfirm: () {
                    onRemove();
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
