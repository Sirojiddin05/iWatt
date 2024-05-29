import 'dart:async';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:i_watt_app/core/config/app_constants.dart';
import 'package:i_watt_app/core/config/app_theme/dark.dart';
import 'package:i_watt_app/core/config/app_theme/light.dart';
import 'package:i_watt_app/core/config/storage_keys.dart';
import 'package:i_watt_app/core/services/storage_repository.dart';
import 'package:i_watt_app/features/authorization/data/repositories_impl/authentication_repository_impl.dart';
import 'package:i_watt_app/features/authorization/domain/usecases/get_authentication_status.dart';
import 'package:i_watt_app/features/authorization/presentation/blocs/authentication_bloc/authentication_bloc.dart';
import 'package:i_watt_app/features/common/data/repositories_impl/about_us_repository_impl.dart';
import 'package:i_watt_app/features/common/data/repositories_impl/notifications_repository_impl.dart';
import 'package:i_watt_app/features/common/data/repositories_impl/search_history_repository_impl.dart';
import 'package:i_watt_app/features/common/domain/usecases/delete_all_search_histories.dart';
import 'package:i_watt_app/features/common/domain/usecases/delete_single_search_history.dart';
import 'package:i_watt_app/features/common/domain/usecases/get_about_usecase.dart';
import 'package:i_watt_app/features/common/domain/usecases/get_notification.dart';
import 'package:i_watt_app/features/common/domain/usecases/get_notification_detail.dart';
import 'package:i_watt_app/features/common/domain/usecases/get_search_history.dart';
import 'package:i_watt_app/features/common/domain/usecases/notification_on_off.dart';
import 'package:i_watt_app/features/common/domain/usecases/read_all_notifications.dart';
import 'package:i_watt_app/features/common/presentation/blocs/about_us_bloc/about_us_bloc.dart';
import 'package:i_watt_app/features/common/presentation/blocs/car_on_map_bloc/car_on_map_bloc.dart';
import 'package:i_watt_app/features/common/presentation/blocs/internet_bloc/internet_bloc.dart';
import 'package:i_watt_app/features/common/presentation/blocs/notification_bloc/notification_bloc.dart';
import 'package:i_watt_app/features/common/presentation/blocs/search_history_bloc/search_history_bloc.dart';
import 'package:i_watt_app/features/common/presentation/blocs/theme_switcher_bloc/theme_switcher_bloc.dart';
import 'package:i_watt_app/features/navigation/presentation/home_screen.dart';
import 'package:i_watt_app/features/profile/presentation/blocs/credit_cards_bloc/credit_cards_bloc.dart';
import 'package:i_watt_app/features/splash/presentation/splash_sreen.dart';
import 'package:i_watt_app/service_locator.dart';

Future<void> main() async {
  runZonedGuarded(() async {
    WidgetsFlutterBinding.ensureInitialized();
    await EasyLocalization.ensureInitialized();
    await setupLocator();
    //TODO uncomment to production
    // await SentryFlutter.init((options) {
    //   options.dsn = 'https://388abcb382d5d3326d84efc657c5df4d@o713327.ingest.us.sentry.io/4507299428564992';
    //   options.tracesSampleRate = 1.0;
    // }, appRunner: () {
    return runApp(const App());
    // }
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
        BlocProvider(create: (context) => CarOnMapBloc()),
        BlocProvider(create: (context) => ThemeSwitcherBloc()),
        BlocProvider(create: (context) => InternetBloc(Connectivity())),
        BlocProvider(create: (context) => CreditCardsBloc()..add(const GetCreditCards())),
        BlocProvider(
          create: (context) => AuthenticationBloc(
            GetAuthenticationStatusUseCase(repository: serviceLocator<AuthenticationRepositoryImpl>()),
          ),
        ),
        BlocProvider(
          create: (context) => AboutUsBloc(
            GetAboutUsUseCase(serviceLocator<AboutUsRepositoryImpl>()),
          ),
        ),
        BlocProvider(
          create: (context) => NotificationBloc(
            readAllUseCase: ReadAllNotificationsUseCase(
              serviceLocator<NotificationsRepositoryImpl>(),
            ),
            notificationOnOffUseCase: NotificationOnOffUseCase(
              serviceLocator<NotificationsRepositoryImpl>(),
            ),
            getNotificationUseCase: GetNotificationsUseCase(
              serviceLocator<NotificationsRepositoryImpl>(),
            ),
            getNotificationDetailUseCase: GetNotificationDetailUseCase(
              serviceLocator<NotificationsRepositoryImpl>(),
            ),
          ),
        ),
        BlocProvider(
          create: (context) => SearchHistoryBloc(
            getSearchHistoryUseCase: GetSearchHistoryUseCase(
              serviceLocator<SearchHistoryRepositoryImpl>(),
            ),
            deleteAllSearchHistoryUseCase: DeleteAllSearchHistoryUseCase(
              serviceLocator<SearchHistoryRepositoryImpl>(),
            ),
            deleteSingleSearchHistoryUseCase: DeleteSingleSearchHistoryUseCase(
              serviceLocator<SearchHistoryRepositoryImpl>(),
            ),
          ),
        ),
      ],
      child: EasyLocalization(
        path: 'assets/translations',
        supportedLocales: const [
          Locale('uz'),
          Locale('en'),
          Locale('ru'),
        ],
        fallbackLocale: Locale(StorageRepository.getString(StorageKeys.language, defValue: 'ru')),
        startLocale: Locale(StorageRepository.getString(StorageKeys.language, defValue: 'ru')),
        saveLocale: true,
        child: const MyApp(),
      ),
    );
  }
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

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
  void didChangeDependencies() {
    print('Locale changed: ${EasyLocalization.of(context)?.currentLocale?.languageCode}');
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return MediaQuery(
      data: MediaQuery.of(context).copyWith(textScaler: const TextScaler.linear(1.0)),
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
            home: const HomeScreen(),
            themeAnimationDuration: AppConstants.animationDuration,
            onGenerateRoute: (settings) => MaterialPageRoute(builder: (ctx) => const SplashScreen()),
            // builder: (context, child) {
            //   return BlocListener<AuthenticationBloc, AuthenticationState>(
            //     child: child,
            //     listenWhen: (o, n) => o.authenticationStatus != n.authenticationStatus && n.isRebuild,
            //     listener: (context, state) async {
            //       if (state.authenticationStatus.isAuthenticated) {
            //         _navigator.pushAndRemoveUntil(MaterialWithModalsPageRoute(builder: (context) => const HomeScreen()), (route) => false);
            //       } else if (state.authenticationStatus.isUnAuthenticated) {
            //         final isRegisteredOnce = StorageRepository.getBool(StorageKeys.isRegisteredOnce, defValue: false);
            //         if (isRegisteredOnce) {
            //           //TODO
            //           // _navigator.pushAndRemoveUntil(MaterialWithModalsPageRoute(builder: (context) => const SplashScreen()), (route) => false);
            //         } else {
            //           _navigator.pushAndRemoveUntil(MaterialWithModalsPageRoute(builder: (context) => const HomeScreen()), (route) => false);
            //         }
            //       }
            //     },
            //   );
            // },
          );
        },
      ),
    );
  }
}
