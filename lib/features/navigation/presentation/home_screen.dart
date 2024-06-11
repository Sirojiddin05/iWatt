import 'dart:io';

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
import 'package:i_watt_app/features/charging_processes/presentation/bloc/charging_process_bloc/charging_process_bloc.dart';
import 'package:i_watt_app/features/charging_processes/presentation/widgets/payment_ckeck_sheet.dart';
import 'package:i_watt_app/features/common/presentation/blocs/internet_bloc/internet_bloc.dart';
import 'package:i_watt_app/features/common/presentation/blocs/present_bottom_sheet/present_bottom_sheet_bloc.dart';
import 'package:i_watt_app/features/common/presentation/widgets/adaptive_dialog.dart';
import 'package:i_watt_app/features/common/presentation/widgets/no_internet_bottomsheet.dart';
import 'package:i_watt_app/features/common/presentation/widgets/present_back_wrapper.dart';
import 'package:i_watt_app/features/navigation/data/repositories_impl/version_check_repository_impl.dart';
import 'package:i_watt_app/features/navigation/domain/usecases/get_version_features_usecase.dart';
import 'package:i_watt_app/features/navigation/domain/usecases/get_version_usecase.dart';
import 'package:i_watt_app/features/navigation/presentation/blocs/instructions_bloc/instructions_bloc.dart';
import 'package:i_watt_app/features/navigation/presentation/blocs/version_check_bloc/version_check_bloc.dart';
import 'package:i_watt_app/features/navigation/presentation/widgets/home_tab_controller_provider.dart';
import 'package:i_watt_app/features/navigation/presentation/widgets/navigation_bar_widget.dart';
import 'package:i_watt_app/features/navigation/presentation/widgets/navigator.dart';
import 'package:i_watt_app/features/navigation/presentation/widgets/update_dialog.dart';
import 'package:i_watt_app/features/navigation/presentation/widgets/version_features_sheet.dart';
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
                showCupertinoModalBottomSheet(
                  context: context,
                  barrierColor: AppColors.white,
                  enableDrag: false,
                  isDismissible: false,
                  builder: (ctx) {
                    return ChargingPaymentCheck(cheque: state.transactionCheque);
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
                  StorageRepository.putList(
                      StorageKeys.versionFeatures, [...(StorageRepository.getList(StorageKeys.versionFeatures)), state.version]);
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
            )
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
            child: AnnotatedRegion(
              value: SystemUiOverlayStyle.dark.copyWith(systemNavigationBarColor: AppColors.white),
              child: HomeTabControllerProvider(
                controller: _tabController,
                child: PopScope(
                  onPopInvoked: (bool didPop) async {
                    final isFirstRouteInCurrentTab = !await _navigatorKeys[NavItemEnum.values[_currentIndex.value]]!.currentState!.maybePop();
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
                    bottomNavigationBar: Container(
                      decoration: BoxDecoration(
                        color: context.bottomNavigationBarTheme.backgroundColor,
                        border: Border.all(color: context.themedColors.lillyWhiteToTaxBreak),
                        boxShadow: [
                          BoxShadow(color: context.appBarTheme.shadowColor!, spreadRadius: 0, blurRadius: 40, offset: const Offset(0, -2)),
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
                    ),
                  ),
                ),
              ),
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

  Widget _buildPageNavigator(NavItemEnum tabItem) => TabNavigator(navigatorKey: _navigatorKeys[tabItem]!, tabItem: tabItem);

  Future<void> _changePage(int index) async {
    _tabController.animateTo(index);
  }

  onToggled() {
    if (animationController.isDismissed) {
      HapticFeedback.mediumImpact();
      animationController.forward();
    } else {
      animationController.reverse();
    }
  }
}
