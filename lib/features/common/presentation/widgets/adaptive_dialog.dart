import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:i_watt_app/core/config/app_colors.dart';
import 'package:i_watt_app/core/util/extensions/build_context_extension.dart';

Future showCustomAdaptiveDialog(
  BuildContext context, {
  required String title,
  TextStyle? titleStyle,
  String? description,
  TextStyle? descriptionStyle,
  String cancelText = 'Cancel',
  TextStyle? cancelStyle,
  String confirmText = 'Confirm',
  TextStyle? confirmStyle,
  Function()? onCancel,
  required Function() onConfirm,
}) async {
  return await showDialog(
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

class CustomAdaptiveDialog extends StatelessWidget {
  final String title;
  final TextStyle? titleStyle;
  final String? description;
  final TextStyle? descriptionStyle;
  final String cancelText;
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
          style: titleStyle ?? context.textTheme.headlineLarge?.copyWith(fontSize: 17),
        ),
        content: description == null
            ? null
            : Text(
                description!,
                style: descriptionStyle ?? context.textTheme.titleLarge?.copyWith(fontSize: 13),
              ),
        actions: [
          CupertinoDialogAction(
            onPressed: onCancel ?? () => Navigator.pop(context),
            textStyle: cancelStyle ??
                context.textTheme.headlineLarge?.copyWith(
                  fontWeight: FontWeight.w400,
                  color: AppColors.dodgerBlue,
                ),
            child: Text(cancelText),
          ),
          CupertinoDialogAction(
            onPressed: onConfirm,
            textStyle: confirmStyle ??
                context.textTheme.headlineLarge?.copyWith(
                  color: AppColors.dodgerBlue,
                ),
            child: Text(confirmText),
          ),
        ],
      );
    }
    return AlertDialog();
  }
}
