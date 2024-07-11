import 'dart:math';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gradient_animation_text/flutter_gradient_animation_text.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:i_watt_app/core/config/app_images.dart';
import 'package:i_watt_app/core/util/extensions/build_context_extension.dart';
import 'package:i_watt_app/features/common/presentation/blocs/filter_bloc/filter_bloc.dart';
import 'package:i_watt_app/features/common/presentation/widgets/w_cupertino_switch.dart';
import 'package:i_watt_app/generated/locale_keys.g.dart';

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
                      LocaleKeys.charging_via_iwatt.tr(),
                      style: context.textTheme.bodyLarge,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    LocaleKeys.charging_via_iwatt_filter_description.tr(),
                    style: context.textTheme.labelMedium?.copyWith(color: context.textTheme.titleLarge?.color),
                  ),
                ],
              ),
            ),
            const SizedBox(width: 14),
            BlocBuilder<FilterBloc, FilterState>(
              builder: (context, state) {
                return WCupertinoSwitch(
                  isSwitched: state.integrated,
                  onChange: (value) {
                    context.read<FilterBloc>().add(SwitchIntegratedEvent());
                  },
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
