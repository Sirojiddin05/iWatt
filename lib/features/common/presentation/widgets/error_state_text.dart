import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:i_watt_app/generated/locale_keys.g.dart';

class ErrorStateTextWidget extends StatelessWidget {
  const ErrorStateTextWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        mainAxisSize: MainAxisSize.max,
        children: [
          const Spacer(),
          Center(
            child: Text(
              LocaleKeys.failure_in_loading.tr(),
            ),
          ),
          const Spacer(),
        ],
      ),
    );
  }
}
