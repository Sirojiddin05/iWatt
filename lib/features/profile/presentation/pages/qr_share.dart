import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:i_watt_app/core/config/app_images.dart';
import 'package:i_watt_app/core/util/extensions/build_context_extension.dart';
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
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              width: context.sizeOf.width * .66,
              height: context.sizeOf.width * .66,
              padding: const EdgeInsets.all(20),
              clipBehavior: Clip.antiAlias,
              decoration: ShapeDecoration(
                color: Colors.white,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                shadows: const [
                  BoxShadow(
                    color: Color(0x0C000000),
                    blurRadius: 21.10,
                    offset: Offset(0, 4),
                    spreadRadius: 0,
                  ),
                  BoxShadow(
                    color: Color(0x0C000000),
                    blurRadius: 7.90,
                    offset: Offset(0, 1),
                    spreadRadius: 1,
                  ),
                  BoxShadow(
                    color: Color(0x0C000000),
                    blurRadius: 6.30,
                    offset: Offset(0, 0),
                    spreadRadius: 1,
                  )
                ],
              ),
              child: Image.asset(AppImages.shareQrExample),
            ),
            const SizedBox(height: 24),
            Text(
              "Использовать пароль с другого устройства?",
              textAlign: TextAlign.center,
              style: context.textTheme.displayLarge,
            ),
            const SizedBox(height: 6),
            Text(
              "Отсканируйте этот QR-код с помощью устройства, на котором есть пароль, который вы хотите использовать для входа I-Watt",
              textAlign: TextAlign.center,
              style: context.textTheme.labelMedium?.copyWith(
                color: context.bottomNavigationBarTheme.unselectedLabelStyle?.color,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
