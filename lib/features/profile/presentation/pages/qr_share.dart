import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:i_watt_app/features/common/presentation/widgets/app_bar_wrapper.dart';
import 'package:i_watt_app/generated/locale_keys.g.dart';

class QrSharePage extends StatefulWidget {
  const QrSharePage({super.key});

  @override
  State<QrSharePage> createState() => _QrSharePageState();
}

class _QrSharePageState extends State<QrSharePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarWrapper(
        hasBackButton: true,
        title: LocaleKeys.login_with_qr.tr(),
      ),
    );
  }
}
