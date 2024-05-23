import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class UpdateDialog extends StatelessWidget {
  final bool isRequired;
  const UpdateDialog({super.key, required this.isRequired});

  @override
  Widget build(BuildContext context) {
    return const SizedBox.shrink();
    // return AlertDialog.adaptive(
    //   shape: const RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(16))),
    //   title: Text(
    //     LocaleKeys.update_the_app.tr(),
    //     style: Theme.of(context)
    //         .textTheme
    //         .headlineMedium!
    //         .copyWith(color: black, fontWeight: FontWeight.w600, fontSize: 17),
    //   ),
    //   content: Text(
    //     LocaleKeys.update_app_subtitle.tr(),
    //     style: Theme.of(context).textTheme.headlineMedium!.copyWith(
    //       color: black,
    //       fontWeight: FontWeight.w400,
    //       fontSize: 13,
    //     ),
    //   ),
    //   actions: [
    //     if (!isRequired) ...{
    //       adaptiveAction(
    //         child: Text(
    //           LocaleKeys.cancellation.tr(),
    //           style: Theme.of(context).textTheme.headlineMedium!.copyWith(color: royalBlue),
    //         ),
    //         onPressed: () => Navigator.pop(context),
    //         context: context,
    //       ),
    //     },
    //     adaptiveAction(
    //       child: Text(
    //         LocaleKeys.update.tr(),
    //         style: Theme.of(context).textTheme.headlineMedium!.copyWith(color: royalBlue),
    //       ),
    //       onPressed: () {
    //         if (Platform.isAndroid) {
    //           launchUrl(Uri.parse('https://play.google.com/store/apps/details?id=org.uicgroup.ztymobile'),
    //               mode: LaunchMode.externalApplication);
    //         } else if (Platform.isIOS) {
    //           // launchUrlString('https://apps.apple.com/uz/app/zty-mobile/id6466305525');
    //           launchUrl(Uri.parse('https://apps.apple.com/uz/app/zty-mobile/id6466305525'),
    //               mode: LaunchMode.externalApplication);
    //         }
    //       },
    //       context: context,
    //     ),
    //   ],
    // );
  }

  Widget adaptiveAction({required BuildContext context, required VoidCallback onPressed, required Widget child}) {
    final ThemeData theme = Theme.of(context);
    switch (theme.platform) {
      case TargetPlatform.android:
        return TextButton(onPressed: onPressed, child: child);
      case TargetPlatform.fuchsia:
      case TargetPlatform.linux:
      case TargetPlatform.windows:
        return TextButton(onPressed: onPressed, child: child);
      case TargetPlatform.iOS:
        return CupertinoDialogAction(onPressed: onPressed, child: child);
      case TargetPlatform.macOS:
        return CupertinoDialogAction(onPressed: onPressed, child: child);
    }
  }
}
