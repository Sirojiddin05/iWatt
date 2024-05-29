import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:i_watt_app/features/common/presentation/widgets/info_container.dart';
import 'package:i_watt_app/features/common/presentation/widgets/w_button.dart';
import 'package:i_watt_app/generated/locale_keys.g.dart';

class PayWithCardSheetBottom extends StatelessWidget {
  const PayWithCardSheetBottom({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const InfoContainer(
          margin: EdgeInsets.zero,
          color: Color(0xffEBC032),
          infoText: "На вашей карте должна быть минимальная сумма 150 000 UZS или добавить новую карту",
        ),
        const SizedBox(height: 20),
        WButton(
          text: LocaleKeys.start.tr(),
          onTap: () {},
        )
      ],
    );
  }
}
