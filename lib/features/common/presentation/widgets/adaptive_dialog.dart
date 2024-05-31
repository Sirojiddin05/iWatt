import 'dart:io';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:i_watt_app/core/config/app_colors.dart';
import 'package:i_watt_app/core/util/extensions/build_context_extension.dart';
import 'package:i_watt_app/generated/locale_keys.g.dart';

Future showCustomAdaptiveDialog(
  BuildContext context, {
  required String title,
  TextStyle? titleStyle,
  String? description,
  TextStyle? descriptionStyle,
  String? cancelText,
  TextStyle? cancelStyle,
  String confirmText = 'Confirm',
  TextStyle? confirmStyle,
  Function()? onCancel,
  required Function() onConfirm,
}) async {
  return await showAdaptiveDialog(
    context: context,
    builder: (ctx) => CustomAdaptiveDialog(
      title: title,
      titleStyle: titleStyle,
      description: description,
      descriptionStyle: descriptionStyle,
      cancelText: cancelText,
      cancelStyle: cancelStyle,
      confirmText: confirmText,
      confirmStyle: confirmStyle,
      onConfirm: onConfirm,
      onCancel: onCancel,
    ),
  );
}

Future showLoginDialog(
  BuildContext context, {
  required Function() onConfirm,
}) async {
  return await showCustomAdaptiveDialog(
    context,
    title: LocaleKeys.you_need_to_login_to_do_this_action.tr(),
    cancelText: LocaleKeys.cancel.tr(),
    confirmText: LocaleKeys.login.tr(),
    onConfirm: onConfirm,
  );
}

class CustomAdaptiveDialog extends StatelessWidget {
  final String title;
  final TextStyle? titleStyle;
  final String? description;
  final TextStyle? descriptionStyle;
  final String? cancelText;
  final TextStyle? cancelStyle;
  final String confirmText;
  final TextStyle? confirmStyle;
  final Function()? onCancel;
  final Function() onConfirm;

  const CustomAdaptiveDialog({
    super.key,
    required this.title,
    this.titleStyle,
    required this.description,
    required this.cancelText,
    required this.confirmText,
    this.descriptionStyle,
    this.cancelStyle,
    this.confirmStyle,
    this.onCancel,
    required this.onConfirm,
  });

  @override
  Widget build(BuildContext context) {
    if (Platform.isIOS) {
      return CupertinoAlertDialog(
        title: Text(
          title,
          style: titleStyle?.copyWith(fontFamily: 'SFProText') ?? context.textTheme.headlineLarge?.copyWith(fontSize: 17, fontFamily: 'SFProText'),
        ),
        content: description == null
            ? null
            : Text(
                description!,
                style: descriptionStyle?.copyWith(fontFamily: 'SFProText') ??
                    context.textTheme.titleLarge?.copyWith(fontSize: 13, fontFamily: 'SFProText'),
              ),
        actions: [
          CupertinoDialogAction(
            onPressed: onCancel ?? () => Navigator.pop(context),
            textStyle: cancelStyle?.copyWith(fontFamily: 'SFProText') ??
                context.textTheme.headlineLarge?.copyWith(fontWeight: FontWeight.w400, color: AppColors.dodgerBlue, fontFamily: 'SFProText'),
            child: Text(cancelText ?? LocaleKeys.cancel.tr()),
          ),
          CupertinoDialogAction(
            onPressed: () {
              Navigator.pop(context);
              onConfirm();
            },
            textStyle: confirmStyle?.copyWith(fontFamily: 'SFProText') ??
                context.textTheme.headlineLarge?.copyWith(color: AppColors.dodgerBlue, fontFamily: 'SFProText'),
            child: Text(confirmText),
          ),
        ],
      );
    }
    return AlertDialog();
  }
}
