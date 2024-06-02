import 'package:flutter/material.dart';
import 'package:i_watt_app/features/common/presentation/widgets/notification_loader_item.dart';
import 'package:i_watt_app/features/common/presentation/widgets/shimmer_loader.dart';

class NotificationsLoaderView extends StatelessWidget {
  const NotificationsLoaderView({super.key});

  @override
  Widget build(BuildContext context) {
    return Shimmer(
      child: ListView(
        physics: const NeverScrollableScrollPhysics(),
        children: List.generate(20, (index) => const NotificationLoaderItem()),
      ),
    );
  }
}
