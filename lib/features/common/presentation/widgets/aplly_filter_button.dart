import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:i_watt_app/features/common/presentation/widgets/w_button.dart';
import 'package:i_watt_app/generated/locale_keys.g.dart';

class ApplyFilterButton extends StatelessWidget {
  final VoidCallback onTap;
  const ApplyFilterButton({
    super.key,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return WButton(
      margin: EdgeInsets.fromLTRB(16, 0, 16, MediaQuery.paddingOf(context).bottom + 8),
      text: LocaleKeys.apply.tr(),
      textColor: Colors.white,
      onTap: onTap,
      height: 44,
    );
  }
}
