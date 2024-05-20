import 'package:flutter/material.dart';
import 'package:i_watt_app/core/config/app_constants.dart';
import 'package:i_watt_app/features/navigation/presentation/widgets/nav_bar_item.dart';

class NavigationBarWidget extends StatelessWidget {
  final int index;
  final VoidCallback onTap;
  final int currentIndex;

  const NavigationBarWidget({super.key, required this.index, required this.onTap, required this.currentIndex});

  @override
  Widget build(BuildContext context) {
    if (index == 3) {
      return Expanded(
        child: Stack(
          alignment: Alignment.center,
          children: [
            GestureDetector(
              behavior: HitTestBehavior.opaque,
              onTap: onTap,
              child: NavBarItem(navBar: AppConstants.navBarSections[index], currentIndex: currentIndex),
            ),
            //TODO: Uncomment this code, implement right version
            // BlocBuilder<ChargingProcessBloc, ChargingProcessState>(
            //   builder: (context, state) {
            //     final processes = state.processes.where((element) => element.taskStatus.running).toList();
            //     return processes.isNotEmpty
            //         ? Positioned(top: 2, right: (context.sizeOf.width / 5) / 3, child: NavBarBadge(number: processes.length))
            //         : const SizedBox.shrink();
            //   },
            // ),
          ],
        ),
      );
    }
    return Expanded(
      child: GestureDetector(
        behavior: HitTestBehavior.opaque,
        onTap: onTap,
        child: NavBarItem(navBar: AppConstants.navBarSections[index], currentIndex: currentIndex),
      ),
    );
  }
}
