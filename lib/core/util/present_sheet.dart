import 'package:flutter/material.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';

class CustomMaterialWithModalsPageRoute<T> extends MaterialPageRoute<T> {
  /// Construct a MaterialPageRoute whose contents are defined by [builder].
  ///
  /// The values of [builder], [maintainState], and [fullScreenDialog] must not
  /// be null.
  CustomMaterialWithModalsPageRoute({
    required super.builder,
    super.settings,
    super.maintainState,
    super.fullscreenDialog,
  });

  ModalSheetRoute? _nextModalRoute;

  @override
  bool canTransitionTo(TransitionRoute<dynamic> nextRoute) => true;

  @override
  void didChangeNext(Route? nextRoute) {
    if (nextRoute is ModalSheetRoute) {
      _nextModalRoute = nextRoute;
    }

    super.didChangeNext(nextRoute);
  }

  @override
  bool didPop(T? result) {
    _nextModalRoute = null;
    return super.didPop(result);
  }

  @override
  Widget buildTransitions(BuildContext context, Animation<double> animation, Animation<double> secondaryAnimation, Widget child) {
    // const theme = CupertinoPageTransitionsBuilder();
    const theme = CustomPageTransitionBuilder();
    final nextRoute = _nextModalRoute;
    if (nextRoute != null) {
      if (!secondaryAnimation.isDismissed) {
        // Avoid default transition theme to animate when a new modal view is pushed
        final fakeSecondaryAnimation = Tween<double>(begin: 0, end: 0).animate(secondaryAnimation);

        final defaultTransition = theme.buildTransitions<T>(this, context, animation, fakeSecondaryAnimation, child);
        return nextRoute.getPreviousRouteTransition(context, secondaryAnimation, defaultTransition);
      } else {
        _nextModalRoute = null;
      }
    }

    print('passed here');
    return theme.buildTransitions<T>(this, context, animation, secondaryAnimation, child);
  }
}

class CustomPageTransitionBuilder extends PageTransitionsBuilder {
  const CustomPageTransitionBuilder();
  @override
  Widget buildTransitions<T>(
    PageRoute<T> route,
    BuildContext context,
    Animation<double> animation,
    Animation<double> secondaryAnimation,
    Widget child,
  ) {
    // Directionality(textDirection: Text, child: child)
    return SizeTransition(
      sizeFactor: animation,
      child: child,
    );
  }
}

PageRouteBuilder size({required Widget page, RouteSettings? settings}) {
  return PageRouteBuilder(
    settings: settings,
    transitionDuration: const Duration(seconds: 3),
    pageBuilder: (BuildContext context, Animation<double> animation, Animation<double> secondaryAnimation) => page,
    transitionsBuilder: (context, animation, secondaryAnimation, child) {
      return FadeTransition(
        // axisAlignment: -1,
        // axis: Axis.vertical,
        opacity: CurvedAnimation(curve: const Interval(0, 1, curve: Curves.linear), parent: animation),
        child: child,
      );
    },
  );
}
