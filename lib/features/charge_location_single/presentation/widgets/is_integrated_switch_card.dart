import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gradient_animation_text/flutter_gradient_animation_text.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_touch_ripple/flutter_touch_ripple.dart';
import 'package:i_watt_app/core/config/app_images.dart';
import 'package:i_watt_app/core/util/extensions/build_context_extension.dart';
import 'package:i_watt_app/features/common/presentation/blocs/filter_bloc/filter_bloc.dart';

class IsIntegratedSwitchCard extends StatelessWidget {
  const IsIntegratedSwitchCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(16).copyWith(bottom: 0),
      padding: EdgeInsets.zero,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        color: context.themedColors.solitudeToSolitudeO4,
      ),
      child: TouchRipple(
        rippleColor: context.theme.primaryColor.withAlpha(30),
        borderRadius: BorderRadius.circular(8),
        onTap: () {
          context.read<FilterBloc>().add(SwitchIntegratedEvent());
        },
        child: Padding(
          padding: const EdgeInsets.fromLTRB(14, 11, 19, 11),
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
                      "Показать на карте только те локации, на которых можно начать зарядную сессию через iWatt",
                      style: context.textTheme.labelMedium?.copyWith(color: context.textTheme.titleLarge?.color),
                    ),
                  ],
                ),
              ),
              const SizedBox(width: 14),
              BlocBuilder<FilterBloc, FilterState>(
                builder: (context, state) {
                  return CupertinoSwitch(
                    value: state.integrated,
                    onChanged: (value) {
                      context.read<FilterBloc>().add(SwitchIntegratedEvent());
                    },
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
