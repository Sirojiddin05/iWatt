import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_gradient_animation_text/flutter_gradient_animation_text.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:i_watt_app/core/config/app_images.dart';
import 'package:i_watt_app/core/util/extensions/build_context_extension.dart';
import 'package:i_watt_app/features/charge_location_single/presentation/widgets/location_single_card_wrapper.dart';

class IntegratedCard extends StatelessWidget {
  const IntegratedCard({super.key});

  @override
  Widget build(BuildContext context) {
    return LocationSingleCardWrapper(
      padding: const EdgeInsets.symmetric(vertical: 11, horizontal: 14),
      margin: const EdgeInsets.all(16).copyWith(bottom: 0),
      child: Row(
        children: [
          SvgPicture.asset(AppImages.iWattSymbol),
          const SizedBox(width: 13),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                GradientAnimationText(
                  duration: const Duration(seconds: 1),
                  transform: const GradientRotation(pi / 4),
                  colors: const [Color(0xff02191B), Color(0xff09C6D9)],
                  text: Text(
                    "Зарядка через iWatt",
                    style: context.textTheme.bodyLarge,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  "Можно начать зарядку сейчас же в этом приложении",
                  style: context.textTheme.labelMedium?.copyWith(color: context.textTheme.titleLarge?.color),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
