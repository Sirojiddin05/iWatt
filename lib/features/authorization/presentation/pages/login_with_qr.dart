import 'dart:io';

import 'package:easy_localization/easy_localization.dart';
import 'package:encrypt/encrypt.dart' as encrypt;
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:i_watt_app/core/config/app_colors.dart';
import 'package:i_watt_app/core/config/app_icons.dart';
import 'package:i_watt_app/core/util/enums/pop_up_status.dart';
import 'package:i_watt_app/core/util/extensions/build_context_extension.dart';
import 'package:i_watt_app/core/util/my_functions.dart';
import 'package:i_watt_app/features/common/presentation/widgets/w_scale_animation.dart';
import 'package:i_watt_app/generated/locale_keys.g.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';

class LoginWithQr extends StatefulWidget {
  const LoginWithQr({super.key});

  @override
  State<LoginWithQr> createState() => _LoginWithQrState();
}

class _LoginWithQrState extends State<LoginWithQr> {
  late final QRViewController qrController;
  final GlobalKey qrKey = GlobalKey(debugLabel: 'QR');
  bool onFlash = false;
  bool isGeneration = true;

  @override
  Widget build(BuildContext context) {
    final scanArea = MediaQuery.of(context).size.width - 110;
    return AnnotatedRegion(
      value: SystemUiOverlayStyle.light,
      child: Scaffold(
        backgroundColor: AppColors.black,
        body: Stack(
          children: [
            QRView(
              key: qrKey,
              onQRViewCreated: (controller) {
                qrController = controller;
                _onQRViewCreated(context);
              },
              formatsAllowed: const [BarcodeFormat.qrcode],
              overlay: QrScannerOverlayShape(
                borderColor: AppColors.white,
                borderRadius: 6,
                borderLength: 60,
                overlayColor: AppColors.cyprus.withOpacity(.6),
                borderWidth: 12,
                cutOutBottomOffset: 50,
                cutOutSize: scanArea,
              ),
              onPermissionSet: (ctrl, p) => _onPermissionSet(context, ctrl, p),
            ),
            Positioned(
              left: 0,
              right: 0,
              top: MediaQuery.of(context).padding.top,
              child: Row(
                children: [
                  const Spacer(),
                  Expanded(
                    child: Align(
                      alignment: Alignment.topRight,
                      child: WScaleAnimation(
                        child: Container(
                          margin: const EdgeInsets.fromLTRB(16, 24, 16, 24),
                          padding: const EdgeInsets.all(6),
                          decoration: ShapeDecoration(
                            shape: const OvalBorder(),
                            color: AppColors.white.withOpacity(.1),
                          ),
                          child: SvgPicture.asset(
                            AppIcons.cancel,
                            height: 16,
                            width: 16,
                          ),
                        ),
                        onTap: () => Navigator.pop(context),
                      ),
                    ),
                  )
                ],
              ),
            ),
            Positioned(
              right: 16,
              left: 16,
              top: MediaQuery.of(context).size.height * 0.17,
              child: Column(
                children: [
                  Text(
                    LocaleKeys.qr_authorization.tr(),
                    style: Theme.of(context).textTheme.titleSmall!.copyWith(
                          fontSize: 24,
                          fontWeight: FontWeight.w700,
                          color: AppColors.white,
                        ),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 8),
                  Text(
                    LocaleKeys.in_order_to_login_scan_qr_code.tr(),
                    textAlign: TextAlign.center,
                    style: context.textTheme.titleSmall!.copyWith(
                      fontSize: 14,
                      fontWeight: FontWeight.w400,
                      color: AppColors.zircon,
                    ),
                  ),
                ],
              ),
            ),
            Positioned(
              left: MediaQuery.of(context).size.width * 0.42,
              bottom: MediaQuery.of(context).size.height * 0.16,
              child: WScaleAnimation(
                onTap: () {
                  onFlash ? _turnOffFlash(context) : _turnOnFlash(context);
                },
                child: Container(
                  height: 68,
                  width: 68,
                  clipBehavior: Clip.antiAlias,
                  padding: const EdgeInsets.all(14),
                  decoration: BoxDecoration(
                    color: onFlash ? AppColors.white : AppColors.black.withOpacity(.4),
                    shape: BoxShape.rectangle,
                    borderRadius: BorderRadius.circular(18),
                  ),
                  child: SvgPicture.asset(
                    onFlash ? AppIcons.flashLightOf : AppIcons.flashLightOn,
                    width: 40,
                    height: 40,
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  void _onQRViewCreated(BuildContext ctx) {
    String token = '';
    qrController.scannedDataStream.listen(
      (scanData) async {
        final code = scanData.code;
        if (code != null && code.contains("i-watt:")) {
          await qrController.pauseCamera();
          qrController.dispose();
          token = code.replaceAll('i-watt:', '');
        }
        final decryptedToken = await decryptToken(token);
        if (token.isNotEmpty) {
          Navigator.pop(ctx, decryptedToken);
        }
      },
    );
  }

  void _onPermissionSet(BuildContext context, QRViewController ctrl, bool granted) {
    if (!granted) {
      context.showPopUp(context, PopUpStatus.failure, message: 'Permission restricted');
    }
  }

  Future<void> _turnOnFlash(BuildContext context) async {
    try {
      await qrController.toggleFlash();
      setState(() {
        onFlash = true;
      });
    } on Exception catch (_) {
      context.showPopUp(context, PopUpStatus.failure, message: 'Could not enable Flashlight');
    }
  }

  Future<void> _turnOffFlash(BuildContext context) async {
    try {
      await qrController.toggleFlash();
      setState(() {
        onFlash = false;
      });
    } on Exception catch (_) {
      context.showPopUp(context, PopUpStatus.failure, message: 'Could not disable Flashlight');
    }
  }

  Future<String> decryptToken(String ivAndEncryptedToken) async {
    final ivBase64 = ivAndEncryptedToken.substring(0, 24); // The first 24 characters represent the base64-encoded IV
    final encryptedTokenBase64 = ivAndEncryptedToken.substring(24);
    final key = await MyFunctions.getEncryptionKey(); // The rest is the encrypted data
    if (key == null) {
      return '';
    }
    final iv = encrypt.IV.fromBase64(ivBase64);
    final encrypter = encrypt.Encrypter(encrypt.AES(encrypt.Key.fromUtf8(key), mode: encrypt.AESMode.cbc));
    final decrypted = encrypter.decrypt64(encryptedTokenBase64, iv: iv);
    print('decrypted ${decrypted}');
    return 'refresh $decrypted';
  }

  @override
  void reassemble() {
    super.reassemble();
    if (Platform.isAndroid) {
      qrController.pauseCamera();
    } else if (Platform.isIOS) {}
  }

  @override
  void dispose() {
    qrController.dispose();
    super.dispose();
  }
}
