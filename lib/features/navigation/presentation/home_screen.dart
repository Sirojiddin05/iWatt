import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:i_watt_app/core/config/app_constants.dart';
import 'package:i_watt_app/core/util/enums/nav_bat_item.dart';
import 'package:i_watt_app/core/util/extensions/build_context_extension.dart';
import 'package:i_watt_app/core/util/my_functions.dart';
import 'package:i_watt_app/features/authorization/presentation/blocs/authentication_bloc/authentication_bloc.dart';
import 'package:i_watt_app/features/authorization/presentation/pages/sign_in.dart';
import 'package:i_watt_app/features/common/presentation/widgets/adaptive_dialog.dart';
import 'package:i_watt_app/features/navigation/data/repositories_impl/version_check_repository_impl.dart';
import 'package:i_watt_app/features/navigation/domain/usecases/get_version_usecase.dart';
import 'package:i_watt_app/features/navigation/presentation/blocs/version_check_bloc/version_check_bloc.dart';
import 'package:i_watt_app/features/navigation/presentation/widgets/home_tab_controller_provider.dart';
import 'package:i_watt_app/features/navigation/presentation/widgets/navigation_bar_widget.dart';
import 'package:i_watt_app/features/navigation/presentation/widgets/navigator.dart';
import 'package:i_watt_app/features/navigation/presentation/widgets/update_dialog.dart';
import 'package:i_watt_app/service_locator.dart';
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
    _versionCheckBloc = VersionCheckBloc(GetAppLatestVersionUseCase(serviceLocator<VersionCheckRepositoryImpl>()))..add(GetVersionEvent());

    _currentIndex = ValueNotifier<int>(0);
    _tabController = TabController(length: 4, vsync: this, animationDuration: const Duration(milliseconds: 0))
      ..addListener(() => _currentIndex.value = _tabController.index);

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
  Widget build(BuildContext context) => BlocProvider.value(
        value: _versionCheckBloc,
        child: BlocListener<VersionCheckBloc, VersionCheckState>(
          listenWhen: (o, n) => o.version != n.version,
          listener: (context, state) async {
            final needToUpdate = await MyFunctions.needToUpdate(state.version);
            if (needToUpdate) {
              updateAppDialog(state.isRequired, context);
            }
          },
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
      );

  Future<void> _onTabChange(index) async {
    final userAuthStatus = context.read<AuthenticationBloc>().state.authenticationStatus;
    final isUnAuthenticated = userAuthStatus.isUnAuthenticated;
    if (index == 2 && isUnAuthenticated) {
      showLoginDialog(context, onConfirm: () {
        Navigator.of(context).push(MaterialPageRoute(builder: (context) => const SignInPage()));
      },);
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
}
