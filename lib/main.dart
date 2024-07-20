import 'dart:async';
import 'dart:io';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:i_watt_app/core/config/app_constants.dart';
import 'package:i_watt_app/core/config/app_theme/dark.dart';
import 'package:i_watt_app/core/config/app_theme/light.dart';
import 'package:i_watt_app/core/config/storage_keys.dart';
import 'package:i_watt_app/core/services/storage_repository.dart';
import 'package:i_watt_app/core/util/db_helpers/locations_db_helper.dart';
import 'package:i_watt_app/core/util/enums/instructions_type.dart';
import 'package:i_watt_app/core/util/my_functions.dart';
import 'package:i_watt_app/features/authorization/data/repositories_impl/authentication_repository_impl.dart';
import 'package:i_watt_app/features/authorization/domain/usecases/get_authentication_status.dart';
import 'package:i_watt_app/features/authorization/presentation/blocs/authentication_bloc/authentication_bloc.dart';
import 'package:i_watt_app/features/charging_processes/data/repositories_impl/charging_process_repository_impl.dart';
import 'package:i_watt_app/features/charging_processes/domain/usecases/get_charging_processes.dart';
import 'package:i_watt_app/features/charging_processes/domain/usecases/start_charging_process_usecase.dart';
import 'package:i_watt_app/features/charging_processes/domain/usecases/stop_charging_process_usecase.dart';
import 'package:i_watt_app/features/charging_processes/presentation/bloc/charging_process_bloc/charging_process_bloc.dart';
import 'package:i_watt_app/features/common/data/repositories_impl/about_us_repository_impl.dart';
import 'package:i_watt_app/features/common/data/repositories_impl/connector_types_repository_impl.dart';
import 'package:i_watt_app/features/common/data/repositories_impl/location_filter_key_repository_impl.dart';
import 'package:i_watt_app/features/common/data/repositories_impl/notifications_repository_impl.dart';
import 'package:i_watt_app/features/common/data/repositories_impl/power_groups_repository_impl.dart';
import 'package:i_watt_app/features/common/data/repositories_impl/search_history_repository_impl.dart';
import 'package:i_watt_app/features/common/data/repositories_impl/socket_repository_impl.dart';
import 'package:i_watt_app/features/common/data/repositories_impl/vendors_repository_impl.dart';
import 'package:i_watt_app/features/common/domain/usecases/connect_to_socket_usecase.dart';
import 'package:i_watt_app/features/common/domain/usecases/delete_all_search_histories.dart';
import 'package:i_watt_app/features/common/domain/usecases/delete_single_search_history.dart';
import 'package:i_watt_app/features/common/domain/usecases/disconnect_from_socket.dart';
import 'package:i_watt_app/features/common/domain/usecases/get_about_us_usecase.dart';
import 'package:i_watt_app/features/common/domain/usecases/get_connector_types_usecase.dart';
import 'package:i_watt_app/features/common/domain/usecases/get_help_usecase.dart';
import 'package:i_watt_app/features/common/domain/usecases/get_location_filter_keys_usecase.dart';
import 'package:i_watt_app/features/common/domain/usecases/get_notification.dart';
import 'package:i_watt_app/features/common/domain/usecases/get_notification_detail.dart';
import 'package:i_watt_app/features/common/domain/usecases/get_power_groups_usecase.dart';
import 'package:i_watt_app/features/common/domain/usecases/get_search_history.dart';
import 'package:i_watt_app/features/common/domain/usecases/get_vendors_usecase.dart';
import 'package:i_watt_app/features/common/domain/usecases/meter_value_stream_usecase.dart';
import 'package:i_watt_app/features/common/domain/usecases/notification_on_off.dart';
import 'package:i_watt_app/features/common/domain/usecases/parking_data_stream_usecase.dart';
import 'package:i_watt_app/features/common/domain/usecases/post_search_history_usecase.dart';
import 'package:i_watt_app/features/common/domain/usecases/read_all_notifications.dart';
import 'package:i_watt_app/features/common/domain/usecases/register_device_id_key_usecase.dart';
import 'package:i_watt_app/features/common/domain/usecases/start_command_result_usecase.dart';
import 'package:i_watt_app/features/common/domain/usecases/stop_command_result_usecase.dart';
import 'package:i_watt_app/features/common/domain/usecases/transaction_cheque_stream_usecase.dart';
import 'package:i_watt_app/features/common/presentation/blocs/about_us_bloc/about_us_bloc.dart';
import 'package:i_watt_app/features/common/presentation/blocs/car_on_map_bloc/car_on_map_bloc.dart';
import 'package:i_watt_app/features/common/presentation/blocs/connector_types_bloc/connector_types_bloc.dart';
import 'package:i_watt_app/features/common/presentation/blocs/internet_bloc/internet_bloc.dart';
import 'package:i_watt_app/features/common/presentation/blocs/location_statuses_bloc/location_statuses_bloc.dart';
import 'package:i_watt_app/features/common/presentation/blocs/notification_bloc/notification_bloc.dart';
import 'package:i_watt_app/features/common/presentation/blocs/power_types_bloc/power_types_bloc.dart';
import 'package:i_watt_app/features/common/presentation/blocs/present_bottom_sheet/present_bottom_sheet_bloc.dart';
import 'package:i_watt_app/features/common/presentation/blocs/search_history_bloc/search_history_bloc.dart';
import 'package:i_watt_app/features/common/presentation/blocs/theme_switcher_bloc/theme_switcher_bloc.dart';
import 'package:i_watt_app/features/common/presentation/blocs/vendors_bloc/vendors_bloc.dart';
import 'package:i_watt_app/features/map/data/repositories_impl/map_repository_impl.dart';
import 'package:i_watt_app/features/map/domain/usecases/delete_locations_usecase.dart';
import 'package:i_watt_app/features/map/domain/usecases/get_created_locations_usecase.dart';
import 'package:i_watt_app/features/map/domain/usecases/get_deleted_locations.dart';
import 'package:i_watt_app/features/map/domain/usecases/get_locations_from_local_source_usecase.dart';
import 'package:i_watt_app/features/map/domain/usecases/get_map_locations_usecase.dart';
import 'package:i_watt_app/features/map/domain/usecases/get_updated_locations.dart';
import 'package:i_watt_app/features/map/domain/usecases/save_location_list_usecase.dart';
import 'package:i_watt_app/features/map/presentation/blocs/map_locations_bloc/map_locations_bloc.dart';
import 'package:i_watt_app/features/navigation/data/repositories_impl/instructions_repository_impl.dart';
import 'package:i_watt_app/features/navigation/domain/usecases/get_instructions_usecase.dart';
import 'package:i_watt_app/features/navigation/presentation/blocs/deeplink_bloc/deep_link_bloc.dart';
import 'package:i_watt_app/features/navigation/presentation/blocs/instructions_bloc/instructions_bloc.dart';
import 'package:i_watt_app/features/navigation/presentation/home_screen.dart';
import 'package:i_watt_app/features/profile/data/repositories_impl/payments_repository_impl.dart';
import 'package:i_watt_app/features/profile/data/repositories_impl/profile_repository_impl.dart';
import 'package:i_watt_app/features/profile/domain/usecases/delete_account_usecase.dart';
import 'package:i_watt_app/features/profile/domain/usecases/get_user_data_usecase.dart';
import 'package:i_watt_app/features/profile/domain/usecases/pay_with_card_usecase.dart';
import 'package:i_watt_app/features/profile/domain/usecases/update_profile_usecase.dart';
import 'package:i_watt_app/features/profile/presentation/blocs/credit_cards_bloc/credit_cards_bloc.dart';
import 'package:i_watt_app/features/profile/presentation/blocs/payments_bloc/payments_bloc.dart';
import 'package:i_watt_app/features/profile/presentation/blocs/profile_bloc/profile_bloc.dart';
import 'package:i_watt_app/features/splash/presentation/splash_sreen.dart';
import 'package:i_watt_app/firebase_options.dart';
import 'package:i_watt_app/service_locator.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import 'package:sentry_flutter/sentry_flutter.dart';

void main() async {
  runZonedGuarded(() async {
    WidgetsFlutterBinding.ensureInitialized();
    await EasyLocalization.ensureInitialized();
    await setupLocator();
    serviceLocator<LocationsDbHelper>().init();
    await SentryFlutter.init((options) {
      options.dsn = 'https://388abcb382d5d3326d84efc657c5df4d@o713327.ingest.us.sentry.io/4507299428564992';
      options.tracesSampleRate = 1.0;
    }, appRunner: () async {
      await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
      await MyFunctions.currentVersionAsync;
      return runApp(const App());
    });
  }, (error, stack) async {
    await Sentry.captureException(error, stackTrace: stack);
  });
}

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => DeepLinkBloc()),
        BlocProvider(create: (context) => CarOnMapBloc()),
        BlocProvider(
          create: (context) => MapLocationsBloc(
            GetLocationsFromLocalSourceUseCase(serviceLocator<MapRepositoryImpl>()),
            GetMapLocationsUseCase(serviceLocator<MapRepositoryImpl>()),
            SaveLocationListUseCase(serviceLocator<MapRepositoryImpl>()),
            GetCreatedLocationsUseCase(serviceLocator<MapRepositoryImpl>()),
            GetUpdatedLocationsUseCase(serviceLocator<MapRepositoryImpl>()),
            GetDeletedLocationsUseCase(serviceLocator<MapRepositoryImpl>()),
            DeleteLocationsUseCase(serviceLocator<MapRepositoryImpl>()),
            context,
          ),
        ),
        BlocProvider(create: (context) => PresentBottomSheetBloc()),
        BlocProvider(create: (context) => ThemeSwitcherBloc()),
        BlocProvider(create: (context) => InternetBloc(Connectivity())),
        BlocProvider(
          create: (context) => InstructionsBloc(
            GetInstructionsUseCase(
              serviceLocator<InstructionsRepositoryImpl>(),
            ),
          ),
        ),
        BlocProvider(create: (context) => CreditCardsBloc()..add(const GetCreditCards())),
        BlocProvider(
          create: (context) => AuthenticationBloc(
            GetAuthenticationStatusUseCase(serviceLocator<AuthenticationRepositoryImpl>()),
            RegisterDeviceIdAndKeyUseCase(serviceLocator<NotificationsRepositoryImpl>()),
          ),
        ),
        BlocProvider(
          create: (context) => ChargingProcessBloc(
            startChargingProcessUseCase: StartChargingProcessUseCase(
              serviceLocator<ChargingProcessRepositoryImpl>(),
            ),
            stopChargingProcessUseCase: StopChargingProcessUseCase(
              serviceLocator<ChargingProcessRepositoryImpl>(),
            ),
            meterValueStreamUseCase: MeterValueStreamUseCase(
              serviceLocator<SocketRepositoryImpl>(),
            ),
            transactionChequeStreamUseCase: TransactionChequeStreamUseCase(
              serviceLocator<SocketRepositoryImpl>(),
            ),
            connectToSocketUseCase: ConnectToSocketUseCase(
              serviceLocator<SocketRepositoryImpl>(),
            ),
            disconnectFromSocketUseCase: DisconnectFromSocketUseCase(
              serviceLocator<SocketRepositoryImpl>(),
            ),
            getChargingProcessUseCase: GetChargingProcessUseCase(
              serviceLocator<ChargingProcessRepositoryImpl>(),
            ),
            startCommandResultStreamUseCase: StartCommandResultStreamUseCase(
              serviceLocator<SocketRepositoryImpl>(),
            ),
            stopCommandResultStreamUseCase: StopCommandResultStreamUseCase(
              serviceLocator<SocketRepositoryImpl>(),
            ),
            parkingDataStreamUseCase: ParkingDataStreamUseCase(
              serviceLocator<SocketRepositoryImpl>(),
            ),
          )..add(GetChargingProcessesEvent()),
        ),
        BlocProvider(
          create: (context) => ConnectorTypesBloc(
            GetConnectorTypesUseCase(
              serviceLocator<ConnectorTypesRepositoryImpl>(),
            ),
          )..add(GetConnectorTypesEvent()),
        ),
        BlocProvider(
          create: (context) => VendorsBloc(
            GetVendorsUseCase(
              serviceLocator<VendorsRepositoryImpl>(),
            ),
          )..add(GetVendorsEvent()),
        ),
        BlocProvider(
          create: (context) => PowerTypesBloc(
            GetPowerTypesUseCase(
              serviceLocator<PowerTypesRepositoryImpl>(),
            ),
          )..add(GetPowerTypesEvent()),
        ),
        BlocProvider(
          create: (context) => LocationStatusesBloc(
            GetLocationFilterKeysUseCase(
              serviceLocator<LocationFilterKeyRepositoryImpl>(),
            ),
          )..add(GetLocationStatusesEvent()),
        ),
        BlocProvider(
          create: (context) => AboutUsBloc(
            GetHelpUseCase(serviceLocator<AboutUsRepositoryImpl>()),
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
            postSearchHistoryUseCase: PostSearchHistoryUseCase(
              serviceLocator<SearchHistoryRepositoryImpl>(),
            ),
          )..add(GetSearchHistoryEvent()),
        ),
        BlocProvider(
          create: (context) => ProfileBloc(
            GetUserDataUseCase(serviceLocator<ProfileRepositoryImpl>()),
            UpdateProfileDataUseCase(serviceLocator<ProfileRepositoryImpl>()),
            DeleteAccountUseCase(serviceLocator<ProfileRepositoryImpl>()),
          )..add(GetUserData()),
        ),
        BlocProvider(
          create: (context) => PaymentBloc(
            PayWithCardUseCase(
              serviceLocator<PaymentsRepositoryImpl>(),
            ),
          ),
        ),
      ],
      child: EasyLocalization(
        path: 'assets/translations',
        supportedLocales: const [
          Locale('uz'),
          Locale('ta'),
          Locale('ky'),
          Locale('ka'),
          Locale('ru'),
          Locale('en'),
        ],
        fallbackLocale: Locale(StorageRepository.getString(StorageKeys.currentLanguage, defValue: 'ru')),
        startLocale: Locale(StorageRepository.getString(StorageKeys.currentLanguage, defValue: 'ru')),
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
    super.initState();
    SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]);
    bool onBoarding = StorageRepository.getBool(StorageKeys.onBoarding, defValue: false);
    if (!onBoarding) {
      context.read<InstructionsBloc>().add(GetInstructionsEvent(InstructionsType.onboarding.name));
    }
  }

  @override
  Widget build(BuildContext context) {
    return MediaQuery(
      data: MediaQuery.of(context).copyWith(textScaler: const TextScaler.linear(1.0)),
      child: BlocListener<CreditCardsBloc, CreditCardsState>(
        listenWhen: (o, n) => o.creditCards != n.creditCards,
        listener: (context, state) {
          if (state.creditCards.isNotEmpty) {
            context.read<PaymentBloc>().add(InitializeSelectedUserCardEvent(state.creditCards.first.id));
          }
        },
        child: BlocBuilder<ThemeSwitcherBloc, ThemeSwitcherState>(
          builder: (context, themeState) {
            return MaterialApp(
              title: 'iWatt',
              debugShowCheckedModeBanner: false,
              localizationsDelegates: context.localizationDelegates,
              supportedLocales: context.supportedLocales,
              locale: context.locale,
              navigatorKey: _navigatorKey,
              theme: themeState.appTheme.isLight ? LightTheme.theme() : DarkTheme.theme(),
              themeAnimationDuration: AppConstants.animationDuration,
              onGenerateRoute: (settings) => MaterialPageRoute(builder: (ctx) => const SplashScreen()),
              builder: (context, child) {
                return BlocListener<AuthenticationBloc, AuthenticationState>(
                  child: child,
                  listenWhen: (o, n) => o.authenticationStatus != n.authenticationStatus && n.isRebuild,
                  listener: (context, state) async {
                    if (state.authenticationStatus.isAuthenticated) {
                      context.read<ChargingProcessBloc>().add(ConnectToSocketEvent());
                    } else {
                      context.read<ChargingProcessBloc>().add(DisconnectFromSocketEvent());
                    }
                    if (!state.authenticationStatus.isUnKnown) {
                      _navigator.pushAndRemoveUntil(
                        MaterialWithModalsPageRoute(
                          builder: (context) => const HomeScreen(),
                        ),
                        (route) => false,
                      );
                    }
                  },
                );
              },
            );
          },
        ),
      ),
    );
  }
}
