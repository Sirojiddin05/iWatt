import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:i_watt_app/core/util/extensions/build_context_extension.dart';
import 'package:i_watt_app/generated/locale_keys.g.dart';

class ResendOtpText extends StatelessWidget {
  const ResendOtpText({super.key});

  @override
  Widget build(BuildContext context) {
    return Text(
      LocaleKeys.send_code_again_after.tr(),
      style: context.textTheme.titleSmall?.copyWith(fontSize: 13),
    );
  }
}
