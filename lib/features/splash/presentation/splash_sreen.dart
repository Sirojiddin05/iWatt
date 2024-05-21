import 'dart:async';

import 'package:flutter/material.dart';
import 'package:i_watt_app/core/config/app_lotties.dart';
import 'package:i_watt_app/core/util/extensions/build_context_extension.dart';
import 'package:lottie/lottie.dart';

class SplashScreen extends StatefulWidget {
  static Route route() => MaterialPageRoute<void>(
        builder: (_) => const SplashScreen(),
      );

  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> with TickerProviderStateMixin {
  late Timer timer;
  bool toShowRealAnim = false;
  bool showLottieAnimation = false;
  late final AnimationController logoController;
  late final AnimationController lottieController;

  @override
  void initState() {
    super.initState();
    logoController = AnimationController(vsync: this, duration: const Duration(seconds: 1));
    timer = Timer(const Duration(milliseconds: 500), () {
      setState(() {
        logoController.forward();
      });
    });
  }

  @override
  void dispose() {
    logoController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          const Spacer(),
          FadeTransition(
            opacity: logoController,
            child: Image.asset(
              context.themedIcons.splashLogo,
            ),
          ),
          const Spacer(),
          Lottie.asset(
            AppLottie.splashLottie,
            // height: 46,
            // width: 46,
          ),
          SizedBox(height: context.padding.bottom + 20)
        ],
      ),
    );
  }
}
