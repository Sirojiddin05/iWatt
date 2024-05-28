import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:formz/formz.dart';
import 'package:i_watt_app/core/config/app_icons.dart';
import 'package:i_watt_app/features/common/presentation/blocs/notification_bloc/notification_bloc.dart';
import 'package:i_watt_app/features/common/presentation/widgets/adaptive_dialog.dart';
import 'package:i_watt_app/features/common/presentation/widgets/app_bar_wrapper.dart';
import 'package:i_watt_app/features/common/presentation/widgets/notification_item.dart';
import 'package:i_watt_app/features/common/presentation/widgets/notifications_empty_view.dart';
import 'package:i_watt_app/features/common/presentation/widgets/paginator.dart';

class NotificationsPage extends StatefulWidget {
  const NotificationsPage({super.key});

  @override
  State<NotificationsPage> createState() => _NotificationsPageState();
}

class _NotificationsPageState extends State<NotificationsPage> {
  late NotificationBloc bloc;

  @override
  void initState() {
    bloc = context.read<NotificationBloc>()..add(GetNotifications());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<NotificationBloc, NotificationState>(
      builder: (context, state) => Scaffold(
          appBar: AppBarWrapper(
            hasBackButton: true,
            title: 'Уведомления',
            actions: [
              IconButton(
                onPressed: () {
                  showCustomAdaptiveDialog(
                    context,
                    title: 'Отметить все  прочитанными?',
                    description: 'Данное действие поменяет статус всех непрочитаных уведомлений на прочитанных',
                    cancelText: 'Отменить',
                    confirmText: 'Отметить',
                    onConfirm: () {},
                  );
                },
                icon: SvgPicture.asset(AppIcons.checks),
              ),
            ],
          ),
          body: RefreshIndicator(
            onRefresh: () async {
              bloc.add(GetNotifications());
              return Future.value();
            },
            child: state.getNotificationsStatus.isSuccess
                ? state.notifications.isEmpty
                    ? const NotificationsEmptyView()
                    : Paginator(
                        fetchMoreFunction: () {},
                        paginatorStatus: state.getNotificationsStatus,
                        hasMoreToFetch: state.fetchMore,
                        physics: const AlwaysScrollableScrollPhysics(),
                        itemCount: state.notifications.length,
                        itemBuilder: (context, index) {
                          return const NotificationItem();
                        },
                      )
                : const Center(child: CupertinoActivityIndicator(color: Colors.black)),
          )),
    );
  }
}
