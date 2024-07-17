import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:formz/formz.dart';
import 'package:i_watt_app/core/util/extensions/build_context_extension.dart';
import 'package:i_watt_app/core/util/my_functions.dart';
import 'package:i_watt_app/features/common/presentation/blocs/notification_bloc/notification_bloc.dart';
import 'package:i_watt_app/features/common/presentation/widgets/sheet_header_container.dart';
import 'package:i_watt_app/features/common/presentation/widgets/sheet_wrapper.dart';
import 'package:i_watt_app/features/common/presentation/widgets/w_image.dart';
import 'package:i_watt_app/generated/locale_keys.g.dart';

showSingleNotificationSheet(BuildContext context, int notification) {
  return showModalBottomSheet(
    context: context,
    barrierColor: Colors.black54,
    backgroundColor: Colors.transparent,
    isScrollControlled: true,
    enableDrag: true,
    builder: (ctx) => SingleNotificationSheet(notificationId: notification),
  );
}

class SingleNotificationSheet extends StatefulWidget {
  final int notificationId;

  const SingleNotificationSheet({super.key, required this.notificationId});

  @override
  State<SingleNotificationSheet> createState() => _SingleNotificationSheetState();
}

class _SingleNotificationSheetState extends State<SingleNotificationSheet> {
  @override
  void initState() {
    super.initState();
    context.read<NotificationBloc>().add(GetNotificationDetail(id: widget.notificationId));
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        SizedBox(height: MediaQueryData.fromView(View.of(context)).padding.top + 16),
        const SheetHeadContainer(
          margin: EdgeInsets.only(bottom: 8),
        ),
        Flexible(
          child: SheetWrapper(
            child: BlocBuilder<NotificationBloc, NotificationState>(
              builder: (context, state) {
                return SingleChildScrollView(
                  child: Padding(
                    padding: EdgeInsets.fromLTRB(16, 16, 16, context.padding.bottom + 32),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        if (state.getNotificationSingleStatus.isInProgress) ...{
                          const Center(
                              child: Padding(
                                  padding: EdgeInsets.symmetric(vertical: 16),
                                  child: CircularProgressIndicator.adaptive()))
                        } else if (state.getNotificationSingleStatus.isSuccess) ...{
                          if (state.notificationDetail.photo.isNotEmpty) ...{
                            Align(
                              alignment: Alignment.topLeft,
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(12),
                                child: WImage(
                                  imageUrl: state.notificationDetail.photo,
                                ),
                              ),
                            ),
                            const SizedBox(height: 16),
                          },
                          Text(
                            state.notificationDetail.title,
                            style: context.textTheme.headlineLarge,
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                          ),
                          const SizedBox(height: 8),
                          Text(
                            MyFunctions.getNotificationCreatedTime(
                                context.locale.languageCode, state.notificationDetail.createdAt),
                            style: context.textTheme.titleSmall?.copyWith(fontSize: 13),
                          ),
                          const SizedBox(height: 16),
                          Text(
                            state.notificationDetail.description,
                            style: context.textTheme.titleLarge?.copyWith(fontSize: 13),
                          ),
                          const SizedBox(height: 24),
                        } else if (state.getNotificationSingleStatus.isFailure) ...{
                          Center(
                            child: Padding(
                              padding: const EdgeInsets.symmetric(vertical: 16),
                              child: Text(
                                LocaleKeys.failure_in_loading.tr(),
                              ),
                            ),
                          ),
                        },
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
        ),
      ],
    );
  }
}
