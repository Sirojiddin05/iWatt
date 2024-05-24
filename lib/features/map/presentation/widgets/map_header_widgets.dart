import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:i_watt_app/features/common/presentation/widgets/search_container.dart';
import 'package:i_watt_app/features/map/presentation/widgets/location_denied_container.dart';
import 'package:i_watt_app/features/map/presentation/widgets/parking_message_container.dart';
import 'package:i_watt_app/features/map/presentation/widgets/top_up_balance_message_container.dart';

class MapHeaderWidgets extends StatefulWidget {
  final AnimationController sizeController;

  const MapHeaderWidgets({super.key, required this.sizeController});

  @override
  State<MapHeaderWidgets> createState() => _MapHeaderWidgetsState();
}

class _MapHeaderWidgetsState extends State<MapHeaderWidgets> {
  late final ValueNotifier<bool> showNotifications;
  @override
  void initState() {
    showNotifications = ValueNotifier<bool>(false);
    super.initState();
    widget.sizeController.addStatusListener((status) {
      if (widget.sizeController.isCompleted) {
        showNotifications.value = true;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Positioned(
      right: 0,
      left: 0,
      child: SizeTransition(
        axisAlignment: 1,
        sizeFactor: widget.sizeController,
        child: Column(
          children: [
            const SearchFilterContainer(isForMap: true),
            ValueListenableBuilder<bool>(
              valueListenable: showNotifications,
              builder: (ctx, show, child) {
                if (show) {
                  return const Align(alignment: Alignment.center, child: LocationDeniedContainer());
                }
                return const SizedBox.shrink();
              },
            ),
            ValueListenableBuilder(
              valueListenable: showNotifications,
              builder: (ctx, show, child) {
                if (show) {
                  return const Align(alignment: Alignment.center, child: TopUpBalanceMessage());
                }
                return const SizedBox.shrink();
              },
            ),
            ValueListenableBuilder(
              valueListenable: showNotifications,
              builder: (ctx, show, child) {
                if (show) {
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
