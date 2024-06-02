import 'package:flutter/material.dart';
import 'package:i_watt_app/core/config/app_colors.dart';
import 'package:i_watt_app/core/util/extensions/build_context_extension.dart';
import 'package:i_watt_app/core/util/my_functions.dart';
import 'package:i_watt_app/features/common/domain/entities/notification_entity.dart';
import 'package:i_watt_app/features/common/presentation/widgets/single_notification_sheet.dart';
import 'package:i_watt_app/features/common/presentation/widgets/w_custom_tappable_button.dart';

class NotificationItem extends StatelessWidget {
  final NotificationEntity notification;

  const NotificationItem({super.key, required this.notification});

  @override
  Widget build(BuildContext context) {
    return WCustomTappableButton(
      onTap: () {
        showSingleNotificationSheet(context, notification);
      },
      borderRadius: BorderRadius.circular(0),
      rippleColor: context.textTheme.titleLarge!.color!.withOpacity(.15),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 8,
            height: 8,
            margin: const EdgeInsets.fromLTRB(16, 16, 10, 16),
            decoration: ShapeDecoration(
              shape: const OvalBorder(),
              color: notification.isRead ? Colors.transparent : AppColors.dodgerBlue,
            ),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(0, 10, 16, 16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  notification.title,
                  style: context.textTheme.headlineMedium,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
                const SizedBox(height: 4),
                Text(
                  MyFunctions.getFormattedTime(DateTime.parse(notification.createdAt)),
                  style: context.textTheme.titleSmall?.copyWith(fontSize: 12),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
