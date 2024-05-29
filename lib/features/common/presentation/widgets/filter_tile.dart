import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';
import 'package:i_watt_app/core/util/extensions/build_context_extension.dart';
import 'package:i_watt_app/features/common/presentation/widgets/w_cupertino_switch.dart';
import 'package:i_watt_app/features/common/presentation/widgets/w_custom_tappable_button.dart';
import 'package:vibration/vibration.dart';

class FilterTile extends StatelessWidget {
  final String title;
  final bool hasDivider;
  final bool isSelectedDefault;
  final bool includeIcon;
  final String icon;
  final Function(bool) onSwitch;

  const FilterTile({
    this.isSelectedDefault = false,
    required this.title,
    this.hasDivider = true,
    required this.onSwitch,
    super.key,
    this.includeIcon = false,
    this.icon = '',
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        WCustomTappableButton(
          onTap: () async {
            if (Platform.isAndroid && (await Vibration.hasVibrator() ?? false)) {
              Vibration.vibrate(amplitude: 32, duration: 40);
            } else if (Platform.isIOS) {
              HapticFeedback.lightImpact();
            }
            onSwitch(!isSelectedDefault);
          },
          borderRadius: BorderRadius.zero,
          rippleColor: context.theme.primaryColor.withAlpha(30),
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 15),
            child: Row(
              children: [
                if (icon.isNotEmpty) ...{
                  SvgPicture.network(icon, width: 32, height: 32),
                  const SizedBox(width: 12),
                },
                Text(
                  title,
                  style: context.textTheme.headlineMedium,
                ),
                const Spacer(),
                WCupertinoSwitch(
                  onChange: (value) async {
                    if (Platform.isAndroid && (await Vibration.hasVibrator() ?? false)) {
                      Vibration.vibrate(amplitude: 32, duration: 40);
                    } else if (Platform.isIOS) {
                      HapticFeedback.lightImpact();
                    }
                    onSwitch(value);
                  },
                  isSwitched: isSelectedDefault,
                )
              ],
            ),
          ),
        ),
        if (hasDivider) Divider(color: context.theme.dividerColor, thickness: 1, height: 0, indent: includeIcon ? 68 : 16)
      ],
    );
  }
}
