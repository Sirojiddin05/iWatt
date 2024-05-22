import 'package:flutter/material.dart';
import 'package:i_watt_app/features/common/presentation/widgets/search_container.dart';
import 'package:i_watt_app/features/map/presentation/widgets/location_denied_container.dart';
import 'package:i_watt_app/features/map/presentation/widgets/parking_message_container.dart';
import 'package:i_watt_app/features/map/presentation/widgets/top_up_balance_message_container.dart';

class MapHeaderWidgets extends StatelessWidget {
  final AnimationController sizeController;

  const MapHeaderWidgets({super.key, required this.sizeController});

  @override
  Widget build(BuildContext context) {
    return Positioned(
      right: 0,
      left: 0,
      child: SizeTransition(
        axisAlignment: 1,
        sizeFactor: sizeController,
        child: Column(
          children: [
            const SearchFilterContainer(),
            AnimatedBuilder(
              animation: sizeController,
              builder: (ctx, child) {
                if (sizeController.isCompleted) {
                  return const Align(alignment: Alignment.center, child: LocationDeniedContainer());
                }
                return const SizedBox.shrink();
              },
            ),
            AnimatedBuilder(
              animation: sizeController,
              builder: (ctx, child) {
                if (sizeController.isCompleted) {
                  return const Align(alignment: Alignment.center, child: TopUpBalanceMessage());
                }
                return const SizedBox.shrink();
              },
            ),
            AnimatedBuilder(
              animation: sizeController,
              builder: (ctx, child) {
                if (sizeController.isCompleted) {
                  return const Align(alignment: Alignment.center, child: ParkingMessageContainer());
                }
                return const SizedBox.shrink();
              },
            ),
          ],
        ),
      ),
    );
  }
}
