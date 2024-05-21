import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:i_watt_app/core/config/app_constants.dart';
import 'package:i_watt_app/core/util/enums/nav_bat_item.dart';
import 'package:i_watt_app/features/authorization/presentation/blocs/authentication_bloc/authentication_bloc.dart';
import 'package:i_watt_app/features/common/presentation/blocs/internet_bloc/internet_bloc.dart';
import 'package:i_watt_app/features/common/presentation/widgets/no_internet_bottomsheet.dart';
import 'package:i_watt_app/features/navigation/presentation/widgets/home_tab_controller_provider.dart';
import 'package:i_watt_app/features/navigation/presentation/widgets/navigation_bar_widget.dart';
import 'package:i_watt_app/features/navigation/presentation/widgets/navigator.dart';
import 'package:vibration/vibration.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> with TickerProviderStateMixin, WidgetsBindingObserver {
  late final TabController _tabController;
  late final bool isUnAuthenticated;
  late final ValueNotifier<int> _currentIndex;
  // late final MapBloc mapBloc;

  final Map<NavItemEnum, GlobalKey<NavigatorState>> _navigatorKeys = {
    NavItemEnum.map: GlobalKey<NavigatorState>(),
    NavItemEnum.list: GlobalKey<NavigatorState>(),
    NavItemEnum.chargingProcesses: GlobalKey<NavigatorState>(),
    NavItemEnum.profile: GlobalKey<NavigatorState>(),
  };

  @override
  void initState() {
    super.initState();
    // mapBloc = MapBloc()..add(const GetChargeLocationsForMapEvent());
    final userAuthStatus = context.read<AuthenticationBloc>().state.authenticationStatus;
    isUnAuthenticated = userAuthStatus.isUnAuthenticated;
    _tabController = TabController(length: 3, vsync: this, animationDuration: const Duration(milliseconds: 0));
    _currentIndex = ValueNotifier<int>(0)..addListener(() => _tabController.animateTo(_getIndex()));
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
  Widget build(BuildContext context) => BlocListener<InternetBloc, InternetState>(
        listenWhen: (state1, state2) => state1.isConnected != state2.isConnected,
        listener: (context, state) {
          final isConnected = state.isConnected;
          if (!isConnected) {
            showNoInternetBottomSheet(context);
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
                ],
              ),
              bottomNavigationBar: Row(
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
      );

  Future<void> _onTabChange(index) async {
    if ((index == 2 || index == 3) && isUnAuthenticated) {
      //TODO: show login dialog
      // showLoginDialog(context);
    } else {
      _currentIndex.value = index;
    }
    if (Platform.isAndroid && (await Vibration.hasVibrator() ?? false)) {
      Vibration.vibrate(amplitude: 32, duration: 40);
    } else if (Platform.isIOS) {
      HapticFeedback.lightImpact();
    }
  }

  Widget _buildPageNavigator(NavItemEnum tabItem) => TabNavigator(navigatorKey: _navigatorKeys[tabItem]!, tabItem: tabItem);

  Future<void> _changePage(int index) async {
    _currentIndex.value = index;
    _tabController.animateTo(index);
  }

  int _getIndex() {
    if (_currentIndex.value == 2 && isUnAuthenticated) {
      return _currentIndex.value - 1;
    }
    return _currentIndex.value;
  }
}
