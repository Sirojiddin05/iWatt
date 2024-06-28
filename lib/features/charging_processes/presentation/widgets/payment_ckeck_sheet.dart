import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:i_watt_app/core/util/extensions/build_context_extension.dart';
import 'package:i_watt_app/features/common/presentation/widgets/present_sheet_header.dart';
import 'package:i_watt_app/features/common/presentation/widgets/w_button.dart';
import 'package:i_watt_app/generated/locale_keys.g.dart';

class ChargingPaymentCheck extends StatefulWidget {
  final Widget body;

  const ChargingPaymentCheck({super.key, required this.body});

  @override
  State<ChargingPaymentCheck> createState() => _ChargingPaymentCheckState();
}

class _ChargingPaymentCheckState extends State<ChargingPaymentCheck> with TickerProviderStateMixin {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: context.theme.scaffoldBackgroundColor,
      child: Column(
        children: [
          PresentSheetHeader(
            title: LocaleKeys.cheque.tr(),
            titleFotSize: 18,
            hasCloseIcon: true,
            paddingOfCloseIcon: const EdgeInsets.all(16),
          ),
          Divider(color: context.theme.dividerColor, thickness: 1, height: 1),
          Expanded(
            child: widget.body,
          ),
          WButton(
            text: LocaleKeys.to_back.tr(),
            margin: EdgeInsets.fromLTRB(16, 8, 16, context.padding.bottom + 4),
            onTap: () => Navigator.of(context).pop(),
          )
        ],
      ),
    );
  }
}
