import 'dart:async';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:i_watt_app/core/config/app_theme/dark.dart';
import 'package:i_watt_app/core/config/app_theme/light.dart';
import 'package:i_watt_app/core/config/storage_keys.dart';
import 'package:i_watt_app/core/services/storage_repository.dart';
import 'package:i_watt_app/features/common/presentation/blocs/internet_bloc/internet_bloc.dart';
import 'package:i_watt_app/features/common/presentation/blocs/theme_switcher_bloc/theme_switcher_bloc.dart';
import 'package:i_watt_app/service_locator.dart';

Future<void> main() async {
  runZonedGuarded(() async {
    WidgetsFlutterBinding.ensureInitialized();
    await EasyLocalization.ensureInitialized();
    await setupLocator();
    // await SentryFlutter.init((options) {
    //   options.dsn = '';
    //   options.tracesSampleRate = 1.0;
    // }, appRunner: () {
    return runApp(const App());
  }, (error, stack) async {
    // await Sentry.captureException(error, stackTrace: stack);
  });
}

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => ThemeSwitcherBloc()),
        BlocProvider(create: (context) => InternetBloc(Connectivity())),
      ],
      child: EasyLocalization(
        path: 'lib/assets/translations',
        supportedLocales: const [
          Locale('uz'),
          Locale('en'),
          Locale('ru'),
        ],
        fallbackLocale: Locale(StorageRepository.getString(StorageKeys.language, defValue: 'en')),
        startLocale: Locale(StorageRepository.getString(StorageKeys.language, defValue: 'en')),
        saveLocale: true,
        child: const MyApp(),
      ),
    );
  }
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final _navigatorKey = GlobalKey<NavigatorState>();

  NavigatorState get _navigator => _navigatorKey.currentState!;

  @override
  void initState() {
    SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MediaQuery(
      data: MediaQuery.of(context).copyWith(textScaleFactor: 1.0),
      child: BlocBuilder<ThemeSwitcherBloc, ThemeSwitcherState>(
        builder: (context, themeState) {
          return MaterialApp(
            title: 'I WATT',
            debugShowCheckedModeBanner: false,
            localizationsDelegates: context.localizationDelegates,
            supportedLocales: context.supportedLocales,
            locale: context.locale,
            navigatorKey: _navigatorKey,
            theme: themeState.appTheme.isLight ? LightTheme.theme() : DarkTheme.theme(),
            // onGenerateRoute: (settings) => MaterialPageRoute(builder: (ctx) => const SplashScreen()),
            // builder: (context, child) {},
          );
        },
      ),
    );
  }
}
