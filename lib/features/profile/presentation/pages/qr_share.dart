import 'package:easy_localization/easy_localization.dart';
import 'package:encrypt/encrypt.dart' as encrypt;
import 'package:flutter/material.dart';
import 'package:i_watt_app/core/config/app_colors.dart';
import 'package:i_watt_app/core/config/app_images.dart';
import 'package:i_watt_app/core/config/storage_keys.dart';
import 'package:i_watt_app/core/services/storage_repository.dart';
import 'package:i_watt_app/core/util/extensions/build_context_extension.dart';
import 'package:i_watt_app/core/util/my_functions.dart';
import 'package:i_watt_app/features/common/presentation/widgets/app_bar_wrapper.dart';
import 'package:i_watt_app/generated/locale_keys.g.dart';
import 'package:qr_flutter/qr_flutter.dart';

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
            const Spacer(flex: 1),
            Container(
              margin: const EdgeInsets.fromLTRB(20, 0, 20, 24),
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
              child: FutureBuilder(
                future: MyFunctions.getEncryptionKey(),
                builder: (ctx, snapshot) {
                  if (snapshot.hasData && snapshot.data != null && snapshot.data != '') {
                    return QrImageView(
                      data: "i-watt:${encryptToken(
                        StorageRepository.getString(StorageKeys.refreshToken).replaceAll('Bearer ', ''),
                        snapshot.data!,
                      )}",
                      version: QrVersions.auto,
                      errorCorrectionLevel: QrErrorCorrectLevel.H,
                      backgroundColor: AppColors.white,
                      padding: const EdgeInsets.all(20),
                      embeddedImage: const AssetImage(AppImages.qrLogo),
                      eyeStyle: const QrEyeStyle(
                        eyeShape: QrEyeShape.circle,
                        color: Colors.black,
                      ),
                      dataModuleStyle: const QrDataModuleStyle(
                        dataModuleShape: QrDataModuleShape.square,
                        color: Colors.black,
                      ),
                      embeddedImageStyle: QrEmbeddedImageStyle(
                        size: Size(context.sizeOf.width / 6, context.sizeOf.width / 8),
                      ),
                    );
                  }
                  return const Padding(
                    padding: EdgeInsets.all(32),
                    child: CircularProgressIndicator.adaptive(),
                  );
                },
              ),
            ),
            Text(
              LocaleKeys.use_account_from_other_device.tr(),
              textAlign: TextAlign.center,
              style: context.textTheme.displayLarge,
            ),
            const SizedBox(height: 6),
            Text(
              LocaleKeys.scan_the_qr_and_login.tr(),
              textAlign: TextAlign.center,
              style: context.textTheme.labelMedium?.copyWith(
                color: context.bottomNavigationBarTheme.unselectedLabelStyle?.color,
              ),
            ),
            const Spacer(flex: 2),
          ],
        ),
      ),
    );
  }

  String encryptToken(String token, String key) {
    final encrypter = encrypt.Encrypter(encrypt.AES(encrypt.Key.fromUtf8(key), mode: encrypt.AESMode.cbc));
    final iv = encrypt.IV.fromLength(16);
    final encrypted = encrypter.encrypt(token, iv: iv);
    return iv.base64 + encrypted.base64;
  }
}
