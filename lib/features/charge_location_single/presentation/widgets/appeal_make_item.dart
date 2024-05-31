import 'package:flutter/material.dart';
import 'package:i_watt_app/core/config/app_colors.dart';
import 'package:i_watt_app/core/util/extensions/build_context_extension.dart';
import 'package:i_watt_app/features/common/domain/entities/id_name_entity.dart';
import 'package:i_watt_app/features/common/presentation/widgets/w_custom_tappable_button.dart';
import 'package:i_watt_app/features/common/presentation/widgets/w_radio.dart';

class AppealMakeItem<T> extends StatelessWidget {
  final T value;
  final T groupValue;
  final ValueChanged<T> onChanged;
  final IdNameEntity appealEntity;

  const AppealMakeItem({
    super.key,
    required this.appealEntity,
    required this.value,
    required this.groupValue,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return WCustomTappableButton(
      onTap: () => onChanged(value),
      borderRadius: BorderRadius.zero,
      rippleColor: AppColors.primaryRipple30,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
        child: Row(
          children: [
            WRadio(
              onChanged: onChanged,
              value: value,
              groupValue: groupValue,
            ),
            const SizedBox(width: 8),
            Expanded(
              child: Text(
                appealEntity.name,
                style: context.textTheme.bodyMedium?.copyWith(fontSize: 15),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
