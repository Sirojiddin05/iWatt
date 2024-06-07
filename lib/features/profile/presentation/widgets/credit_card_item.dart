import 'package:flutter/material.dart';
import 'package:i_watt_app/core/config/app_colors.dart';
import 'package:i_watt_app/core/config/app_images.dart';
import 'package:i_watt_app/core/util/extensions/build_context_extension.dart';
import 'package:i_watt_app/features/common/presentation/widgets/w_check_box.dart';
import 'package:i_watt_app/features/common/presentation/widgets/w_custom_tappable_button.dart';
import 'package:i_watt_app/features/common/presentation/widgets/w_radio.dart';
import 'package:i_watt_app/features/profile/domain/entities/credit_card_entity.dart';

class CreditCardItem extends StatelessWidget {
  final CreditCardEntity card;
  final bool selected;
  final int? selectedId;
  final bool editing;
  final Function() onTap;

  const CreditCardItem({
    super.key,
    required this.card,
    required this.onTap,
    this.editing = false,
    this.selected = false,
    this.selectedId,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6),
      child: WCustomTappableButton(
        onTap: onTap,
        borderRadius: BorderRadius.circular(12),
        rippleColor: AppColors.primaryRipple30,
        child: Container(
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: context.theme.dividerColor, width: 1),
          ),
          child: Row(
            children: [
              Container(
                padding: const EdgeInsets.all(4),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(6),
                  border: Border.all(width: 1, color: context.theme.dividerColor),
                ),
                child: Image.asset(AppImages.humo, height: 28, width: 28),
              ),
              const SizedBox(width: 8),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(card.cardNumber, style: context.textTheme.headlineMedium),
                  const SizedBox(height: 2),
                  Text(
                    card.cardNumber,
                    style: context.textTheme.titleMedium?.copyWith(
                      fontSize: 12,
                      color: context.textTheme.titleSmall?.color,
                    ),
                  ),
                ],
              ),
              const Spacer(),
              if (selectedId != null && !editing)
                WRadio(
                  onChanged: (value) {},
                  value: card.id,
                  groupValue: selectedId,
                ),
              if (editing) WCheckBox(isChecked: selected),
            ],
          ),
        ),
      ),
    );
  }
}
