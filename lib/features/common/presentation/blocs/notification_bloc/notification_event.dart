part of 'notification_bloc.dart';

abstract class NotificationEvent extends Equatable {
  const NotificationEvent();

  @override
  List<Object?> get props => [];
}

class GetNotifications extends NotificationEvent {}

class GetMoreNotifications extends NotificationEvent {}

class GetNotificationDetail extends NotificationEvent {
  final int id;
  const GetNotificationDetail({required this.id});
}

class NotificationOnOff extends NotificationEvent {
  final bool enabled;

  const NotificationOnOff({required this.enabled});
}

class ReadAllNotifications extends NotificationEvent {
  const ReadAllNotifications();
}

class ReadSingleNotification extends NotificationEvent {
  final int id;
  const ReadSingleNotification({required this.id});
}
