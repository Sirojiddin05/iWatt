import 'package:flutter/material.dart';
import 'package:i_watt_app/core/config/app_theme/theme_extensions/themed_colors.dart';
import 'package:i_watt_app/core/config/app_theme/theme_extensions/themed_icons.dart';
import 'package:i_watt_app/core/util/enums/pop_up_status.dart';
import 'package:i_watt_app/features/common/presentation/widgets/pop_up_container.dart';
import 'package:top_snackbar_flutter/top_snack_bar.dart';

extension BuildContextExtensions on BuildContext {
  ThemeData get theme => Theme.of(this);

  TextTheme get textTheme => Theme.of(this).textTheme;

  ColorScheme get colorScheme => Theme.of(this).colorScheme;

  EdgeInsets get padding => MediaQuery.paddingOf(this);

  Size get sizeOf => MediaQuery.sizeOf(this);

  Brightness get brightness => theme.brightness;

  AppBarTheme get appBarTheme => theme.appBarTheme;

  BottomNavigationBarThemeData get bottomNavigationBarTheme => theme.bottomNavigationBarTheme;

  ThemedIcons get themedIcons => theme.extension<ThemedIcons>()!;

  ThemedColors get themedColors => theme.extension<ThemedColors>()!;

  Future<void> showPopUp(
    BuildContext context,
    PopUpStatus status, {
    required String message,
    Widget? child,
    double? height,
  }) async {
    AnimationController? controller;
    showTopSnackBar(
      Overlay.of(this),
      child ??
          PopUpContainer(
            status: status,
            message: message,
            onCancel: () {
              if (controller != null) controller!.reverse();
            },
          ),
      displayDuration: const Duration(seconds: 3),
      dismissType: status.isWarning ? DismissType.onSwipe : DismissType.none,
      curve: Curves.decelerate,
      reverseCurve: Curves.linear,
      onAnimationControllerInit: (ctrl) => controller = ctrl,
      animationDuration: const Duration(milliseconds: 400),
      reverseAnimationDuration: const Duration(milliseconds: 200),
    );
  }
}
