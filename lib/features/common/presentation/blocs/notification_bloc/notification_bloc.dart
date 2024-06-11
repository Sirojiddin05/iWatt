import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:formz/formz.dart';
import 'package:i_watt_app/core/usecases/base_usecase.dart';
import 'package:i_watt_app/features/common/domain/entities/notification_entity.dart';
import 'package:i_watt_app/features/common/domain/usecases/get_notification.dart';
import 'package:i_watt_app/features/common/domain/usecases/get_notification_detail.dart';
import 'package:i_watt_app/features/common/domain/usecases/notification_on_off.dart';
import 'package:i_watt_app/features/common/domain/usecases/read_all_notifications.dart';

part 'notification_event.dart';
part 'notification_state.dart';

class NotificationBloc extends Bloc<NotificationEvent, NotificationState> {
  final ReadAllNotificationsUseCase readAllUseCase;
  final NotificationOnOffUseCase notificationOnOffUseCase;
  final GetNotificationsUseCase getNotificationUseCase;
  final GetNotificationDetailUseCase getNotificationDetailUseCase;

  NotificationBloc({
    required this.readAllUseCase,
    required this.notificationOnOffUseCase,
    required this.getNotificationUseCase,
    required this.getNotificationDetailUseCase,
  }) : super(const NotificationState()) {
    on<GetNotifications>(_getNotifications);
    on<GetMoreNotifications>(_getMoreNotifications);
    on<GetNotificationDetail>(_getNotificationDetail);
    on<ReadAllNotifications>(_readAllNotifications);
    on<NotificationOnOff>(_notificationOnOff);
  }

  void _getNotifications(GetNotifications event, Emitter<NotificationState> emit) async {
    emit(state.copyWith(getNotificationsStatus: FormzSubmissionStatus.inProgress));
    final result = await getNotificationUseCase.call(null);
    if (result.isRight) {
      int unReadNotificationsCount = 0;
      for (var item in result.right.results) {
        if (!item.isRead) {
          unReadNotificationsCount++;
        }
      }
      emit(state.copyWith(
        getNotificationsStatus: FormzSubmissionStatus.success,
        notifications: result.right.results,
        next: result.right.next ?? '',
        fetchMore: result.right.next != null,
        unReadNotificationsCount: unReadNotificationsCount,
      ));
    } else {
      emit(state.copyWith(
        getNotificationsStatus: FormzSubmissionStatus.failure,
        getNotificationsError: result.left.errorMessage,
      ));
    }
  }

  void _getMoreNotifications(GetMoreNotifications event, Emitter<NotificationState> emit) async {
    final result = await getNotificationUseCase.call(state.next);
    if (result.isRight) {
      int unReadNotificationsCount = 0;
      for (var item in result.right.results) {
        if (!item.isRead) {
          unReadNotificationsCount++;
        }
      }
      emit(state.copyWith(
        getNotificationsStatus: FormzSubmissionStatus.success,
        notifications: [...state.notifications, ...result.right.results],
        next: result.right.next ?? '',
        fetchMore: result.right.next != null,
        unReadNotificationsCount: unReadNotificationsCount,
      ));
    }
  }

  void _getNotificationDetail(GetNotificationDetail event, Emitter<NotificationState> emit) async {
    emit(state.copyWith(getNotificationDeatailStatus: FormzSubmissionStatus.inProgress));
    final result = await getNotificationDetailUseCase.call(event.id);
    if (result.isRight) {
      final newList = _readSingleNotification(event.id);
      emit(state.copyWith(
        getNotificationDeatailStatus: FormzSubmissionStatus.success,
        notificationDetail: result.right,
        notifications: newList,
      ));
    } else {
      emit(state.copyWith(
        getNotificationDeatailStatus: FormzSubmissionStatus.failure,
        getNotificationDetailError: result.left.errorMessage,
      ));
    }
  }

  void _readAllNotifications(ReadAllNotifications event, Emitter<NotificationState> emit) async {
    emit(state.copyWith(readAllNotificationsStatus: FormzSubmissionStatus.inProgress));
    final result = await readAllUseCase.call(NoParams());
    if (result.isRight) {
      final oldList = [...state.notifications];
      for (int i = 0; i < oldList.length; i++) {
        if (!oldList[i].isRead) {
          oldList[i] = oldList[i].copyWith(isRead: true);
        }
      }
      final newList = [...oldList];
      emit(
        state.copyWith(
          notifications: newList,
          readAllNotificationsStatus: FormzSubmissionStatus.success,
        ),
      );
    } else {
      emit(
        state.copyWith(
          readAllNotificationsStatus: FormzSubmissionStatus.failure,
          readAllNotificationsError: result.left.errorMessage,
        ),
      );
    }
  }

  void _notificationOnOff(NotificationOnOff event, Emitter<NotificationState> emit) async {
    emit(state.copyWith(notificationOnOffStatus: FormzSubmissionStatus.inProgress));
    final result = await notificationOnOffUseCase.call(event.enabled);
    if (result.isRight) {
      emit(state.copyWith(notificationOnOffStatus: FormzSubmissionStatus.success));
    } else {
      emit(state.copyWith(
        notificationOnOffStatus: FormzSubmissionStatus.failure,
        notificationOnOffError: result.left.errorMessage,
      ));
    }
  }

  List<NotificationEntity> _readSingleNotification(int id) {
    final oldList = [...state.notifications];
    for (int i = 0; i < oldList.length; i++) {
      if (oldList[i].id == id) {
        oldList[i] = oldList[i].copyWith(isRead: true);
        break;
      }
    }
    final newList = [...oldList];
    return newList;
  }
}
