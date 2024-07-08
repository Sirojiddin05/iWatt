import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:i_watt_app/core/config/app_icons.dart';
import 'package:i_watt_app/core/util/extensions/build_context_extension.dart';
import 'package:i_watt_app/generated/locale_keys.g.dart';

class SupportedCards extends StatelessWidget {
  const SupportedCards({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.fromLTRB(16, 8, 8, 8),
      decoration: BoxDecoration(
        color: context.themedColors.solitudeToSolitudeO4,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Row(
        children: [
          Expanded(
            child: Text(
              LocaleKeys.supported_cards.tr(),
              style: context.textTheme.headlineSmall,
            ),
          ),
          Row(
            children: [
              SvgPicture.asset(AppIcons.uzcard),
              const SizedBox(width: 8),
              SvgPicture.asset(AppIcons.humo),
              const SizedBox(width: 8),
              SvgPicture.asset(AppIcons.visa),
              const SizedBox(width: 8),
              SvgPicture.asset(AppIcons.masterCard),
            ],
          ),
        ],
      ),
    );
  }
}
