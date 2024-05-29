import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:i_watt_app/core/config/app_colors.dart';
import 'package:i_watt_app/core/config/app_images.dart';
import 'package:i_watt_app/core/util/extensions/build_context_extension.dart';
import 'package:i_watt_app/core/util/my_functions.dart';
import 'package:i_watt_app/features/common/domain/entities/notification_entity.dart';
import 'package:i_watt_app/features/common/presentation/blocs/notification_bloc/notification_bloc.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';

showSingleNotificationSheet(BuildContext context, NotificationEntity notification) {
  return showBarModalBottomSheet(
    context: context,
    expand: false,
    barrierColor: Colors.black54,
    enableDrag: true,
    topControl: Container(
      height: 4,
      width: 40,
      decoration: BoxDecoration(
        color: AppColors.blueBayoux,
        borderRadius: BorderRadius.circular(8),
      ),
    ),
    builder: (ctx) => SingleNotificationSheet(notification: notification),
  );
}

class SingleNotificationSheet extends StatefulWidget {
  final NotificationEntity notification;

  const SingleNotificationSheet({super.key, required this.notification});

  @override
  State<SingleNotificationSheet> createState() => _SingleNotificationSheetState();
}

class _SingleNotificationSheetState extends State<SingleNotificationSheet> {
  @override
  void initState() {
    super.initState();
    context.read<NotificationBloc>().add(GetNotificationDetail(id: widget.notification.id));
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<NotificationBloc, NotificationState>(
      builder: (context, state) {
        return SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(12),
                  child: Image.asset(AppImages.systemTheme),
                ),
                const SizedBox(height: 16),
                Text(
                  widget.notification.title,
                  style: context.textTheme.headlineLarge,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
                const SizedBox(height: 8),
                Text(
                  MyFunctions.getFormattedTime(DateTime.parse(widget.notification.addTime)),
                  style: context.textTheme.titleSmall?.copyWith(fontSize: 13),
                ),
                const SizedBox(height: 16),
                Text(
                  '''Обязательым условием для зарядки является наличие привязанной банковской карты в нашем приложении. Для удобства рекомендуем сделать это заранее.
Сегодня в ходе ежегодной конференции BMW Group был представлен электромобиль BMW i4. Уточним, что производитель не стал раскрывать все подробности об этой модели. Полный анонс ожидается через несколько недель.
Пока известно, что машина сможет проезжать без подзарядки до 590 км по тесту WLTP или до 480 км по тесту EPA.'''
                  '''Обязательым условием для зарядки является наличие привязанной банковской карты в нашем приложении. Для удобства рекомендуем сделать это заранее.
          Сегодня в ходе ежегодной конференции BMW Group был представлен электромобиль BMW i4. Уточним, что производитель не стал раскрывать все подробности об этой модели. Полный анонс ожидается через несколько недель.
          Пока известно, что машина сможет проезжать без подзарядки до 590 км по тесту WLTP или до 480 км по тесту EPA.'''
                  '''Обязательым условием для зарядки является наличие привязанной банковской карты в нашем приложении. Для удобства рекомендуем сделать это заранее.
          Сегодня в ходе ежегодной конференции BMW Group был представлен электромобиль BMW i4. Уточним, что производитель не стал раскрывать все подробности об этой модели. Полный анонс ожидается через несколько недель.
          Пока известно, что машина сможет проезжать без подзарядки до 590 км по тесту WLTP или до 480 км по тесту EPA.'''
                  '''Обязательым условием для зарядки является наличие привязанной банковской карты в нашем приложении. Для удобства рекомендуем сделать это заранее.
          Сегодня в ходе ежегодной конференции BMW Group был представлен электромобиль BMW i4. Уточним, что производитель не стал раскрывать все подробности об этой модели. Полный анонс ожидается через несколько недель.
          Пока известно, что машина сможет проезжать без подзарядки до 590 км по тесту WLTP или до 480 км по тесту EPA.'''
                  '''Обязательым условием для зарядки является наличие привязанной банковской карты в нашем приложении. Для удобства рекомендуем сделать это заранее.
          Сегодня в ходе ежегодной конференции BMW Group был представлен электромобиль BMW i4. Уточним, что производитель не стал раскрывать все подробности об этой модели. Полный анонс ожидается через несколько недель.
          Пока известно, что машина сможет проезжать без подзарядки до 590 км по тесту WLTP или до 480 км по тесту EPA.''',
                  style: context.textTheme.titleLarge?.copyWith(fontSize: 13),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
