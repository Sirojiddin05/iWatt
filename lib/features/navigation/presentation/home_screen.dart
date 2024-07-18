import 'dart:io';

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:formz/formz.dart';
import 'package:i_watt_app/core/config/app_colors.dart';
import 'package:i_watt_app/core/config/app_constants.dart';
import 'package:i_watt_app/core/config/storage_keys.dart';
import 'package:i_watt_app/core/services/push_notifications.dart';
import 'package:i_watt_app/core/services/storage_repository.dart';
import 'package:i_watt_app/core/util/enums/nav_bat_item.dart';
import 'package:i_watt_app/core/util/extensions/build_context_extension.dart';
import 'package:i_watt_app/core/util/my_functions.dart';
import 'package:i_watt_app/features/authorization/presentation/blocs/authentication_bloc/authentication_bloc.dart';
import 'package:i_watt_app/features/authorization/presentation/pages/sign_in.dart';
import 'package:i_watt_app/features/charge_location_single/presentation/location_single_sheet.dart';
import 'package:i_watt_app/features/charging_processes/presentation/bloc/charging_process_bloc/charging_process_bloc.dart';
import 'package:i_watt_app/features/charging_processes/presentation/widgets/check.dart';
import 'package:i_watt_app/features/charging_processes/presentation/widgets/payment_ckeck_sheet.dart';
import 'package:i_watt_app/features/common/presentation/blocs/internet_bloc/internet_bloc.dart';
import 'package:i_watt_app/features/common/presentation/blocs/present_bottom_sheet/present_bottom_sheet_bloc.dart';
import 'package:i_watt_app/features/common/presentation/blocs/theme_switcher_bloc/theme_switcher_bloc.dart';
import 'package:i_watt_app/features/common/presentation/widgets/adaptive_dialog.dart';
import 'package:i_watt_app/features/common/presentation/widgets/no_internet_bottomsheet.dart';
import 'package:i_watt_app/features/common/presentation/widgets/present_back_wrapper.dart';
import 'package:i_watt_app/features/common/presentation/widgets/single_notification_sheet.dart';
import 'package:i_watt_app/features/list/domain/entities/charge_location_entity.dart';
import 'package:i_watt_app/features/navigation/data/repositories_impl/version_check_repository_impl.dart';
import 'package:i_watt_app/features/navigation/domain/usecases/get_version_features_usecase.dart';
import 'package:i_watt_app/features/navigation/domain/usecases/get_version_usecase.dart';
import 'package:i_watt_app/features/navigation/presentation/blocs/deeplink_bloc/deep_link_bloc.dart';
import 'package:i_watt_app/features/navigation/presentation/blocs/instructions_bloc/instructions_bloc.dart';
import 'package:i_watt_app/features/navigation/presentation/blocs/version_check_bloc/version_check_bloc.dart';
import 'package:i_watt_app/features/navigation/presentation/widgets/home_tab_controller_provider.dart';
import 'package:i_watt_app/features/navigation/presentation/widgets/navigation_bar_widget.dart';
import 'package:i_watt_app/features/navigation/presentation/widgets/navigator.dart';
import 'package:i_watt_app/features/navigation/presentation/widgets/update_dialog.dart';
import 'package:i_watt_app/features/navigation/presentation/widgets/version_features_sheet.dart';
import 'package:i_watt_app/features/profile/presentation/blocs/profile_bloc/profile_bloc.dart';
import 'package:i_watt_app/service_locator.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import 'package:vibration/vibration.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> with TickerProviderStateMixin, WidgetsBindingObserver {
  late final TabController _tabController;
  late final ValueNotifier<int> _currentIndex;
  late final VersionCheckBloc _versionCheckBloc;
  late final AnimationController animationController;

  final Map<NavItemEnum, GlobalKey<NavigatorState>> _navigatorKeys = {
    NavItemEnum.map: GlobalKey<NavigatorState>(),
    NavItemEnum.list: GlobalKey<NavigatorState>(),
    NavItemEnum.chargingProcesses: GlobalKey<NavigatorState>(),
    NavItemEnum.profile: GlobalKey<NavigatorState>(),
  };

  Future<void> updateAppDialog(bool isRequired, BuildContext ctx) async {
    showDialog(
      barrierDismissible: !isRequired,
      context: context,
      builder: (context) {
        return UpdateDialog(isRequired: isRequired);
      },
    );
  }

  @override
  void initState() {
    super.initState();
    animationController = AnimationController(vsync: this, duration: const Duration(milliseconds: 120));
    _versionCheckBloc = VersionCheckBloc(
      GetAppLatestVersionUseCase(serviceLocator<VersionCheckRepositoryImpl>()),
      GetVersionFeaturesUseCase(serviceLocator<VersionCheckRepositoryImpl>()),
    )..add(GetVersionEvent());
    _currentIndex = ValueNotifier<int>(0);
    _tabController = TabController(length: 4, vsync: this, animationDuration: const Duration(milliseconds: 0))
      ..addListener(() => _currentIndex.value = _tabController.index);
    PushNotificationService.initializeAndListenFirebaseMessaging();
    FirebaseMessaging.instance.getInitialMessage().then((message) async {
      var notificationId = int.tryParse(message?.data['notification_id']);
      if (notificationId != null) {
        await Future.delayed(const Duration(seconds: 2));
        showSingleNotificationSheet(context, notificationId);
        context.read<ProfileBloc>().add(DecrementNotificationCount());
      }
    });
    FirebaseMessaging.onMessageOpenedApp.listen((message) {
      var notificationId = int.tryParse(message.data['notification_id']);
      if (notificationId != null) {
        showSingleNotificationSheet(context, notificationId);
        context.read<ProfileBloc>().add(DecrementNotificationCount());
      }
    });
    FirebaseMessaging.onMessage.listen((message) {
      var notificationId = int.tryParse(message.data['notification_id']);
      if (notificationId != null) {
        context.read<ProfileBloc>().add(GetUserData());
      }
    });

    //TODO
    // context.read<LoginBloc>().add(GetUserDataEvent());
    // context.read<ChargingProcessBloc>()
    //   ..add(DeleteAllProcesses())
    //   ..add(GetChargingBackgroundProcesses());
    // context.read<AppealBloc>().add(GetAppeals());
    // context.read<AddCarBloc>()
    //   ..add(GetCars())
    //   ..add(GetChargingTypes());
  }

  @override
  Widget build(BuildContext context) => MultiBlocProvider(
        providers: [
          BlocProvider.value(value: _versionCheckBloc),
        ],
        child: MultiBlocListener(
          listeners: [
            BlocListener<InternetBloc, InternetState>(
              listenWhen: (state1, state2) => state1.isConnected != state2.isConnected,
              listener: (context, state) {
                final isConnected = state.isConnected;
                if (!isConnected) {
                  showNoInternetBottomSheet(context);
                }
              },
            ),
            BlocListener<AuthenticationBloc, AuthenticationState>(
              listenWhen: (o, n) => o.authenticationStatus != n.authenticationStatus,
              listener: (context, state) {
                context.read<ProfileBloc>().add(GetUserData());
                if (state.authenticationStatus.isAuthenticated) {
                  context.read<ChargingProcessBloc>().add(ConnectToSocketEvent());
                } else {
                  context.read<ChargingProcessBloc>().add(DisconnectFromSocketEvent());
                }
              },
            ),
            BlocListener<ChargingProcessBloc, ChargingProcessState>(
              listenWhen: (o, n) => o.transactionCheque != n.transactionCheque,
              listener: (context, state) async {
                Navigator.popUntil(context, (route) => route.isFirst);
                showCupertinoModalBottomSheet(
                  context: context,
                  barrierColor: Colors.transparent,
                  enableDrag: true,
                  isDismissible: true,
                  overlayStyle: SystemUiOverlayStyle.dark.copyWith(
                    systemNavigationBarColor: context.theme.scaffoldBackgroundColor,
                    statusBarBrightness: Brightness.dark,
                    statusBarIconBrightness: Brightness.light,
                  ),
                  builder: (ctx) {
                    return ChargingPaymentCheck(
                      body: SingleChildScrollView(
                        padding: const EdgeInsets.all(16),
                        child: ChequeWidget(cheque: state.transactionCheque),
                      ),
                    );
                  },
                );
              },
            ),
            BlocListener<InstructionsBloc, InstructionsState>(
              listenWhen: (o, n) => o.getOnBoardingStatus != n.getOnBoardingStatus,
              listener: (context, state) {
                if (state.getOnBoardingStatus.isSuccess) {
                  StorageRepository.putBool(key: StorageKeys.onBoarding, value: true);
                  showModalBottomSheet(
                    context: context,
                    useSafeArea: true,
                    isScrollControlled: true,
                    useRootNavigator: true,
                    backgroundColor: Colors.transparent,
                    builder: (context) => BlocBuilder<InstructionsBloc, InstructionsState>(
                      builder: (context, state) {
                        return VersionFeaturesSheet(list: state.onBoarding);
                      },
                    ),
                  );
                }
              },
            ),
            BlocListener<VersionCheckBloc, VersionCheckState>(
              listenWhen: (o, n) => o.version != n.version,
              listener: (context, state) async {
                final needToUpdate = await MyFunctions.needToUpdate(state.version);
                if (needToUpdate) {
                  updateAppDialog(state.isRequired, context);
                }
              },
            ),
            BlocListener<VersionCheckBloc, VersionCheckState>(
              listenWhen: (o, n) => o.getVersionFeaturesStatus != n.getVersionFeaturesStatus,
              listener: (context, state) async {
                if (state.getVersionFeaturesStatus.isSuccess) {
                  StorageRepository.putList(StorageKeys.versionFeatures,
                      [...(StorageRepository.getList(StorageKeys.versionFeatures)), state.version]);
                  showModalBottomSheet(
                    context: context,
                    useSafeArea: true,
                    isScrollControlled: true,
                    useRootNavigator: true,
                    backgroundColor: Colors.transparent,
                    builder: (context) => BlocProvider.value(
                      value: _versionCheckBloc,
                      child: BlocBuilder<VersionCheckBloc, VersionCheckState>(
                        builder: (context, state) {
                          return VersionFeaturesSheet(list: state.versionFeatures);
                        },
                      ),
                    ),
                  );
                }
              },
            ),
            BlocListener<PresentBottomSheetBloc, PresentBottomSheetState>(
              listenWhen: (o, n) => o.isPresented != n.isPresented,
              listener: (ctx, state) {
                onToggled();
              },
            ),
            BlocListener<DeepLinkBloc, DeepLinkState>(
              listener: (context, state) {
                if (state is ChargeLocationScanned) {
                  showLocationSingle(context, const ChargeLocationEntity().copyWith(id: state.locationId));
                }
              },
            ),
          ],
          child: AnimatedBuilder(
            animation: animationController,
            builder: (ctx, child) {
              double scaleAnimation = 1 - (animationController.value * .1);
              double transformY2 = animationController.value;

              double borderRadius = 12 * animationController.value;
              return PresentSheetBackPageWrapper(
                transformY2: transformY2,
                scaleAnimation: scaleAnimation,
                borderRadius: borderRadius,
                child: child ?? const SizedBox.shrink(),
              );
            },
            child: BlocBuilder<ThemeSwitcherBloc, ThemeSwitcherState>(
              builder: (context, themeState) {
                return AnnotatedRegion(
                  value: themeState.appTheme.isDark ? SystemUiOverlayStyle.light : SystemUiOverlayStyle.dark,
                  child: HomeTabControllerProvider(
                    controller: _tabController,
                    child: PopScope(
                      onPopInvoked: (bool didPop) async {
                        final isFirstRouteInCurrentTab =
                            !await _navigatorKeys[NavItemEnum.values[_currentIndex.value]]!.currentState!.maybePop();
                        if (isFirstRouteInCurrentTab) {
                          _changePage(0);
                        }
                      },
                      child: Scaffold(
                        extendBody: true,
                        resizeToAvoidBottomInset: false,
                        body: TabBarView(
                          controller: _tabController,
                          physics: const NeverScrollableScrollPhysics(),
                          children: [
                            _buildPageNavigator(NavItemEnum.map),
                            _buildPageNavigator(NavItemEnum.list),
                            _buildPageNavigator(NavItemEnum.chargingProcesses),
                            _buildPageNavigator(NavItemEnum.profile),
                          ],
                        ),
                        bottomNavigationBar: BlocBuilder<ThemeSwitcherBloc, ThemeSwitcherState>(
                          builder: (context, state) {
                            return Container(
                              decoration: BoxDecoration(
                                color: context.bottomNavigationBarTheme.backgroundColor,
                                border: Border(top: BorderSide(color: context.themedColors.lillyWhiteToTaxBreak)),
                                boxShadow: state.appTheme.isDark
                                    ? []
                                    : [
                                        BoxShadow(
                                          color: context.appBarTheme.shadowColor!,
                                          spreadRadius: 0,
                                          blurRadius: 40,
                                          offset: const Offset(0, -2),
                                        ),
                                      ],
                              ),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: List.generate(
                                  AppConstants.navBarSections.length,
                                  (index) => ValueListenableBuilder<int>(
                                    valueListenable: _currentIndex,
                                    builder: (context, val, child) {
                                      return NavigationBarWidget(
                                        index: index,
                                        onTap: () => _onTabChange(index),
                                        currentIndex: val,
                                      );
                                    },
                                  ),
                                ),
                              ),
                            );
                          },
                        ),
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
        ),
      );

  Future<void> _onTabChange(index) async {
    final userAuthStatus = context.read<AuthenticationBloc>().state.authenticationStatus;
    final isUnAuthenticated = userAuthStatus.isUnAuthenticated;
    if (index == 2 && isUnAuthenticated) {
      showLoginDialog(
        context,
        onConfirm: () {
          Navigator.of(context).push(MaterialPageRoute(builder: (context) => const SignInPage()));
        },
      );
    } else {
      _tabController.animateTo(index);
    }
    if (Platform.isAndroid && (await Vibration.hasVibrator() ?? false)) {
      Vibration.vibrate(amplitude: 32, duration: 40);
    } else if (Platform.isIOS) {
      HapticFeedback.lightImpact();
    }
  }

  Widget _buildPageNavigator(NavItemEnum tabItem) =>
      TabNavigator(navigatorKey: _navigatorKeys[tabItem]!, tabItem: tabItem);

  Future<void> _changePage(int index) async {
    _tabController.animateTo(index);
  }

  onToggled() {
    if (animationController.isDismissed) {
      animationController.forward();
    } else {
      animationController.reverse();
    }
  }
}
