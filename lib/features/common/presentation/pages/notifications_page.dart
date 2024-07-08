import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:formz/formz.dart';
import 'package:i_watt_app/core/config/app_icons.dart';
import 'package:i_watt_app/core/config/app_images.dart';
import 'package:i_watt_app/core/util/extensions/build_context_extension.dart';
import 'package:i_watt_app/features/common/presentation/blocs/notification_bloc/notification_bloc.dart';
import 'package:i_watt_app/features/common/presentation/widgets/adaptive_dialog.dart';
import 'package:i_watt_app/features/common/presentation/widgets/app_bar_wrapper.dart';
import 'package:i_watt_app/features/common/presentation/widgets/empty_state_widget.dart';
import 'package:i_watt_app/features/common/presentation/widgets/notification_item.dart';
import 'package:i_watt_app/features/common/presentation/widgets/notifications_loader_view.dart';
import 'package:i_watt_app/features/common/presentation/widgets/paginator.dart';
import 'package:i_watt_app/features/profile/presentation/blocs/profile_bloc/profile_bloc.dart';
import 'package:i_watt_app/generated/locale_keys.g.dart';

class NotificationsPage extends StatefulWidget {
  const NotificationsPage({super.key});

  @override
  State<NotificationsPage> createState() => _NotificationsPageState();
}

class _NotificationsPageState extends State<NotificationsPage> {
  late NotificationBloc bloc;

  @override
  void initState() {
    super.initState();
    bloc = context.read<NotificationBloc>()..add(GetNotifications());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: context.appBarTheme.backgroundColor,
      appBar: AppBarWrapper(
        hasBackButton: true,
        title: LocaleKeys.notifications.tr(),
        actions: [
          BlocBuilder<ProfileBloc, ProfileState>(builder: (ctx, state) {
            if (state.user.notificationCount > 0) {
              return GestureDetector(
                onTap: () {
                  showCustomAdaptiveDialog(
                    context,
                    title: LocaleKeys.mark_everything_as_read.tr(),
                    description: LocaleKeys.mark_everything_as_read_description.tr(),
                    cancelText: LocaleKeys.cancel.tr(),
                    confirmText: LocaleKeys.mark.tr(),
                    onConfirm: () {
                      context.read<ProfileBloc>().add(UpdateProfileLocally(notificationCount: 0));
                      bloc.add(const ReadAllNotifications());
                    },
                  );
                },
                behavior: HitTestBehavior.opaque,
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: SvgPicture.asset(AppIcons.checks),
                ),
              );
            }
            return const SizedBox.shrink();
          })
        ],
      ),
      body: RefreshIndicator(
        backgroundColor: context.colorScheme.primaryContainer,
        onRefresh: () async {
          bloc.add(GetNotifications());
          return Future.value();
        },
        child: BlocBuilder<NotificationBloc, NotificationState>(builder: (ctx, state) {
          if (state.getNotificationsStatus.isInProgress) {
            return const NotificationsLoaderView();
          } else if (state.getNotificationsStatus.isSuccess) {
            if (state.notifications.isEmpty) {
              return SingleChildScrollView(
                physics: const AlwaysScrollableScrollPhysics(),
                child: SizedBox(
                  height: context.sizeOf.height - context.padding.bottom - kToolbarHeight - context.padding.top,
                  child: Center(
                    child: EmptyStateWidget(
                      icon: AppImages.notificationsEmpty,
                      title: LocaleKeys.there_is_no_notifications_yet.tr(),
                      subtitle: LocaleKeys.notifications_empty_subtitle.tr(),
                    ),
                  ),
                ),
              );
            }
            return Paginator(
              fetchMoreFunction: () {
                context.read<NotificationBloc>().add(GetMoreNotifications());
              },
              paginatorStatus: state.getNotificationsStatus,
              hasMoreToFetch: state.fetchMore,
              physics: const AlwaysScrollableScrollPhysics(),
              separatorBuilder: (context, index) {
                if (state.notifications.length == (index + 1)) {
                  return const SizedBox.shrink();
                }
                return Divider(height: 1, color: context.theme.dividerColor, indent: 34);
              },
              itemCount: state.notifications.length,
              itemBuilder: (context, index) {
                return NotificationItem(notification: state.notifications[index]);
              },
            );
          } else if (state.getNotificationsStatus.isFailure) {
            return Center(
              child: Padding(
                padding: const EdgeInsets.all(32),
                child: Text(LocaleKeys.failure_in_loading.tr()),
              ),
            );
          }
          return const SizedBox();
        }),
      ),
    );
  }
}
