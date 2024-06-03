import 'package:flutter/material.dart';
import 'package:i_watt_app/core/config/app_colors.dart';
import 'package:i_watt_app/core/util/enums/gender.dart';
import 'package:i_watt_app/core/util/extensions/build_context_extension.dart';
import 'package:i_watt_app/features/common/presentation/widgets/w_custom_tappable_button.dart';
import 'package:i_watt_app/features/common/presentation/widgets/w_radio.dart';

class EditProfileRadioContainer extends StatelessWidget {
  final String label;
  final Gender value;
  final Gender? groupValue;
  final Function() onTap;

  const EditProfileRadioContainer({
    super.key,
    required this.label,
    required this.value,
    required this.groupValue,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return WCustomTappableButton(
      onTap: onTap,
      borderRadius: BorderRadius.circular(8),
      rippleColor: AppColors.dodgerBlue.withAlpha(50),
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 13),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8),
          border: Border.all(color: AppColors.fieldBorderZircon, width: 1),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(label, style: context.textTheme.bodyMedium),
            WRadio(
              onChanged: (value) {},
              value: value,
              groupValue: groupValue,
            ),
          ],
        ),
      ),
    );
  }
}
