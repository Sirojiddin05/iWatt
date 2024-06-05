import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';

const double _kPreviousPageVisibleOffset = 10;

Future<T?> showPresentSheet<T>({
  required BuildContext context,
  required WidgetBuilder builder,
}) async {
  final result = await Navigator.of(context, rootNavigator: true).push(CustomCupertinoModalBottomSheetRoute<T>(
    builder: builder,
    expanded: true,
  ));
  return result;
}

class CustomCupertinoModalBottomSheetRoute<T> extends ModalSheetRoute<T> {
  final SystemUiOverlayStyle? overlayStyle;

  CustomCupertinoModalBottomSheetRoute({
    required super.builder,
    required super.expanded,
    this.overlayStyle,
  });

  @override
  Widget buildTransitions(
    BuildContext context,
    Animation<double> animation,
    Animation<double> secondaryAnimation,
    Widget child,
  ) {
    final paddingTop = MediaQuery.of(context).padding.top;
    final distanceWithScale = (paddingTop + _kPreviousPageVisibleOffset) * 0.9;
    final offsetY = secondaryAnimation.value * (paddingTop - distanceWithScale);
    final scale = 1 - secondaryAnimation.value / 10;
    return AnimatedBuilder(
      builder: (context, child) => Transform.translate(
        offset: Offset(0, offsetY),
        child: Transform.scale(
          scale: scale,
          alignment: Alignment.topCenter,
          child: child,
        ),
      ),
      animation: secondaryAnimation,
      child: child,
    );
  }

  @override
  Widget getPreviousRouteTransition(BuildContext context, Animation<double> secondAnimation, Widget child) {
    final paddingTop = MediaQuery.of(context).padding.top;
    const topRadius = Radius.circular(12);
    const backgroundColor = Colors.black;
    var startRoundCorner = 0.0;
    return AnimatedBuilder(
      animation: secondAnimation,
      child: child,
      builder: (context, child) {
        final progress = secondAnimation.value;
        final yOffset = progress * paddingTop;
        final scale = 1 - progress / 10;
        final radius = progress == 0 ? 0.0 : (1 - progress) * startRoundCorner + progress * topRadius.x;
        return Stack(
          children: <Widget>[
            Container(color: backgroundColor),
            Transform.translate(
              offset: Offset(0, yOffset),
              child: Transform.scale(
                scale: scale,
                alignment: Alignment.topCenter,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(radius),
                  child: child!,
                ),
              ),
            ),
          ],
        );
      },
    );
  }
}

CupertinoThemeData createCustomPreviousRouteTheme(
  BuildContext context,
  Animation<double> animation,
) {
  final cTheme = CupertinoTheme.of(context);

  final systemBackground = CupertinoDynamicColor.resolve(
    cTheme.scaffoldBackgroundColor,
    context,
  );

  final barBackgroundColor = CupertinoDynamicColor.resolve(
    cTheme.barBackgroundColor,
    context,
  );

  var previousRouteTheme = cTheme;

  if (cTheme.scaffoldBackgroundColor is CupertinoDynamicColor) {
    final dynamicScaffoldBackgroundColor = cTheme.scaffoldBackgroundColor as CupertinoDynamicColor;

    /// BackgroundColor for the previous route with forced using
    /// of the elevated colors
    final elevatedScaffoldBackgroundColor = CupertinoDynamicColor.withBrightnessAndContrast(
      color: dynamicScaffoldBackgroundColor.elevatedColor,
      darkColor: dynamicScaffoldBackgroundColor.darkElevatedColor,
      highContrastColor: dynamicScaffoldBackgroundColor.highContrastElevatedColor,
      darkHighContrastColor: dynamicScaffoldBackgroundColor.darkHighContrastElevatedColor,
    );

    previousRouteTheme = previousRouteTheme.copyWith(
      scaffoldBackgroundColor: ColorTween(
        begin: systemBackground,
        end: elevatedScaffoldBackgroundColor.resolveFrom(context),
      ).evaluate(animation),
      primaryColor: CupertinoColors.placeholderText.resolveFrom(context),
    );
  }

  if (cTheme.barBackgroundColor is CupertinoDynamicColor) {
    final dynamicBarBackgroundColor = cTheme.barBackgroundColor as CupertinoDynamicColor;

    /// NavigationBarColor for the previous route with forced using
    /// of the elevated colors
    final elevatedBarBackgroundColor = CupertinoDynamicColor.withBrightnessAndContrast(
      color: dynamicBarBackgroundColor.elevatedColor,
      darkColor: dynamicBarBackgroundColor.darkElevatedColor,
      highContrastColor: dynamicBarBackgroundColor.highContrastElevatedColor,
      darkHighContrastColor: dynamicBarBackgroundColor.darkHighContrastElevatedColor,
    );

    previousRouteTheme = previousRouteTheme.copyWith(
      barBackgroundColor: ColorTween(
        begin: barBackgroundColor,
        end: elevatedBarBackgroundColor.resolveFrom(context),
      ).evaluate(animation),
      primaryColor: CupertinoColors.placeholderText.resolveFrom(context),
    );
  }

  return previousRouteTheme;
}
