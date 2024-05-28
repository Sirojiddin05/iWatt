import 'package:flutter/material.dart';
import 'package:i_watt_app/core/config/app_images.dart';
import 'package:i_watt_app/core/util/extensions/build_context_extension.dart';

class NotificationsEmptyView extends StatelessWidget {
  const NotificationsEmptyView({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Image.asset(AppImages.notificationsEmpty, width: context.sizeOf.width * .38),
          const SizedBox(height: 12),
          Text('Уведомлений пока нет', style: context.textTheme.displayLarge),
          const SizedBox(height: 2),
          Text(
            'Вы еще не получали никаких уведомлений',
            style: context.textTheme.labelMedium?.copyWith(
              color: context.bottomNavigationBarTheme.unselectedLabelStyle?.color,
            ),
          ),
        ],
      ),
    );
  }
}
