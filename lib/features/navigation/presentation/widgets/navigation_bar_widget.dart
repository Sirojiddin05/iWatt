import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:i_watt_app/core/config/app_colors.dart';
import 'package:i_watt_app/core/config/app_constants.dart';
import 'package:i_watt_app/core/util/extensions/build_context_extension.dart';
import 'package:i_watt_app/features/charging_processes/presentation/bloc/charging_process_bloc/charging_process_bloc.dart';
import 'package:i_watt_app/features/navigation/presentation/widgets/nav_bar_badge.dart';
import 'package:i_watt_app/features/navigation/presentation/widgets/nav_bar_item.dart';
import 'package:i_watt_app/features/profile/presentation/blocs/profile_bloc/profile_bloc.dart';

class NavigationBarWidget extends StatelessWidget {
  final int index;
  final VoidCallback onTap;
  final int currentIndex;

  const NavigationBarWidget({super.key, required this.index, required this.onTap, required this.currentIndex});

  @override
  Widget build(BuildContext context) {
    if (index == 2) {
      return BlocBuilder<ChargingProcessBloc, ChargingProcessState>(
        builder: (ctx, state) {
          if (state.processes.isNotEmpty) {
            final processes = state.processes;
            return Expanded(
              child: GestureDetector(
                behavior: HitTestBehavior.opaque,
                onTap: onTap,
                child: Stack(
                  alignment: Alignment.center,
                  children: [
                    NavBarItem(
                      navBar: AppConstants.navBarSections[index],
                      currentIndex: currentIndex,
                    ),
                    Positioned(
                      top: 2,
                      right: (context.sizeOf.width / 5) / 2.5,
                      child: NavBarBadge(
                        number: processes.length,
                      ),
                    ),
                    //TODO: Uncomment this code, implement right version
                    // BlocBuilder<ChargingProcessBloc, ChargingProcessState>(
                    //   builder: (context, state) {
                    //     final processes = state.processes.where((element) => element.taskStatus.running).toList();
                    //     return processes.isNotEmpty
                    //         ?
                    //         : const SizedBox.shrink();
                    //   },
                    // ),
                  ],
                ),
              ),
            );
          }
          return Expanded(
            child: GestureDetector(
              behavior: HitTestBehavior.opaque,
              onTap: onTap,
              child: NavBarItem(
                navBar: AppConstants.navBarSections[index],
                currentIndex: currentIndex,
              ),
            ),
          );
        },
      );
    }
    if (index == 3) {
      return Expanded(
        child: GestureDetector(
          behavior: HitTestBehavior.opaque,
          onTap: onTap,
          child: Stack(
            alignment: Alignment.center,
            children: [
              NavBarItem(
                navBar: AppConstants.navBarSections[index],
                currentIndex: currentIndex,
              ),
              BlocBuilder<ProfileBloc, ProfileState>(
                builder: (context, state) {
                  final unreadNotificationCount = state.user.notificationCount;
                  if (unreadNotificationCount > 0) {
                    return Positioned(
                      top: 23,
                      child: Container(
                        height: 6,
                        width: 6,
                        decoration: BoxDecoration(
                          color: AppColors.amaranth,
                          shape: BoxShape.circle,
                          border: Border.all(
                            color: AppColors.white,
                            width: 1,
                          ),
                        ),
                      ),
                    );
                  }
                  return const SizedBox.shrink();
                },
              ),
            ],
          ),
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
