import 'package:i_watt_app/core/error/failure_handler.dart';
import 'package:i_watt_app/core/usecases/base_usecase.dart';
import 'package:i_watt_app/core/util/either.dart';
import 'package:i_watt_app/features/common/data/models/generic_pagination.dart';
import 'package:i_watt_app/features/common/domain/entities/notification_entity.dart';
import 'package:i_watt_app/features/common/domain/repositories/notifications_repository.dart';

class GetNotificationsUseCase extends UseCase<GenericPagination<NotificationEntity>, String> {
  final NotificationRepository notificationRepository;

  GetNotificationsUseCase(this.notificationRepository);

  @override
  Future<Either<Failure, GenericPagination<NotificationEntity>>> call(String? params) {
    return notificationRepository.getNotifications(next: params);
  }
}
