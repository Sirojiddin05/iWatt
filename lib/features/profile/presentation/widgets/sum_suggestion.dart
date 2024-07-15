import 'package:flutter/material.dart';
import 'package:i_watt_app/core/util/extensions/build_context_extension.dart';
import 'package:i_watt_app/features/common/presentation/widgets/w_custom_tappable_button.dart';

class SumSuggestion extends StatelessWidget {
  final String sum;
  final VoidCallback onTap;

  const SumSuggestion({super.key, required this.sum, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(right: 8),
      child: WCustomTappableButton(
        onTap: onTap,
        rippleColor: context.themedColors.blueBayouxToWhite.withAlpha(30),
        borderRadius: BorderRadius.circular(6),
        child: Container(
          padding: const EdgeInsets.fromLTRB(6, 4, 6, 4),
          decoration: BoxDecoration(
            color: context.themedColors.solitudeToAliceBlueO4,
            borderRadius: BorderRadius.circular(6),
          ),
          child: Text(
            sum,
            style: context.theme.textTheme.headlineSmall!.copyWith(
              color: context.themedColors.blueBayouxToWhite,
              fontSize: 12,
            ),
          ),
        ),
      ),
    );
  }
}
