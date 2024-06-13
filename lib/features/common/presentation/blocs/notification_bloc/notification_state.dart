part of 'notification_bloc.dart';

class NotificationState extends Equatable {
  const NotificationState({
    this.getNotificationsStatus = FormzSubmissionStatus.initial,
    this.getNotificationsError = '',
    this.getNotificationSingleStatus = FormzSubmissionStatus.initial,
    this.getNotificationDetailError = '',
    this.readAllNotificationsStatus = FormzSubmissionStatus.initial,
    this.readAllNotificationsError = '',
    this.notificationOnOffStatus = FormzSubmissionStatus.initial,
    this.notificationOnOffError = '',
    this.notifications = const [],
    this.notificationDetail = const NotificationEntity(),
    this.next = '',
    this.fetchMore = false,
  });

  final FormzSubmissionStatus getNotificationsStatus;
  final String getNotificationsError;
  final FormzSubmissionStatus getNotificationSingleStatus;
  final String getNotificationDetailError;
  final FormzSubmissionStatus readAllNotificationsStatus;
  final String readAllNotificationsError;
  final FormzSubmissionStatus notificationOnOffStatus;
  final String notificationOnOffError;
  final List<NotificationEntity> notifications;
  final NotificationEntity notificationDetail;
  final String next;
  final bool fetchMore;

  NotificationState copyWith({
    FormzSubmissionStatus? getNotificationsStatus,
    String? getNotificationsError,
    FormzSubmissionStatus? getNotificationDeatailStatus,
    String? getNotificationDetailError,
    FormzSubmissionStatus? readAllNotificationsStatus,
    String? readAllNotificationsError,
    FormzSubmissionStatus? notificationOnOffStatus,
    String? notificationOnOffError,
    List<NotificationEntity>? notifications,
    NotificationEntity? notificationDetail,
    String? next,
    bool? fetchMore,
    int? unReadNotificationsCount,
  }) {
    return NotificationState(
      getNotificationsStatus: getNotificationsStatus ?? this.getNotificationsStatus,
      getNotificationsError: getNotificationsError ?? this.getNotificationsError,
      getNotificationSingleStatus: getNotificationDeatailStatus ?? this.getNotificationSingleStatus,
      getNotificationDetailError: getNotificationDetailError ?? this.getNotificationDetailError,
      readAllNotificationsStatus: readAllNotificationsStatus ?? this.readAllNotificationsStatus,
      readAllNotificationsError: readAllNotificationsError ?? this.readAllNotificationsError,
      notificationOnOffStatus: notificationOnOffStatus ?? this.notificationOnOffStatus,
      notificationOnOffError: notificationOnOffError ?? this.notificationOnOffError,
      notifications: notifications ?? this.notifications,
      notificationDetail: notificationDetail ?? this.notificationDetail,
      next: next ?? this.next,
      fetchMore: fetchMore ?? this.fetchMore,
    );
  }

  @override
  List<Object> get props => [
        getNotificationsStatus,
        getNotificationsError,
        getNotificationSingleStatus,
        getNotificationDetailError,
        readAllNotificationsStatus,
        readAllNotificationsError,
        notificationOnOffStatus,
        notificationOnOffError,
        notifications,
        notificationDetail,
        next,
        fetchMore,
      ];
}
