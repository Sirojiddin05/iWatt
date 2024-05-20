import 'package:flutter/cupertino.dart';
import 'package:i_watt_app/core/util/enums/nav_bat_item.dart';
import 'package:i_watt_app/features/chargings/presentation/chargings_screen.dart';
import 'package:i_watt_app/features/list/presentation/list_screen.dart';
import 'package:i_watt_app/features/map/presentation/map_screen.dart';
import 'package:i_watt_app/features/profile/presentation/profile_screen.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';

class TabNavigatorRoutes {
  static const String root = '/';
}

class TabNavigator extends StatefulWidget {
  final GlobalKey<NavigatorState> navigatorKey;
  final NavItemEnum tabItem;

  const TabNavigator({required this.tabItem, required this.navigatorKey, super.key});

  @override
  State<TabNavigator> createState() => _TabNavigatorState();
}

class _TabNavigatorState extends State<TabNavigator> with AutomaticKeepAliveClientMixin {
  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Navigator(
      key: widget.navigatorKey,
      initialRoute: TabNavigatorRoutes.root,
      onGenerateRoute: (routeSettings) {
        final routeBuilders = _routeBuilders(context: context, routeSettings: routeSettings);
        return MaterialWithModalsPageRoute(builder: (context) => routeBuilders[routeSettings.name]!(context));
      },
    );
  }

  Map<String, WidgetBuilder> _routeBuilders({required BuildContext context, required RouteSettings routeSettings}) {
    final tabItem = widget.tabItem;
    if (tabItem.isHome) {
      return {TabNavigatorRoutes.root: (context) => const MapScreen()};
    }
    if (tabItem.isList) {
      return {TabNavigatorRoutes.root: (context) => const ListScreen()};
    }
    if (tabItem.isChargers) {
      return {TabNavigatorRoutes.root: (context) => const ChargingProcessesScreen()};
    }
    if (tabItem.isProfile) {
      return {TabNavigatorRoutes.root: (context) => const ProfileScreen()};
    }
    return {};
  }

  @override
  bool get wantKeepAlive => true;
}
