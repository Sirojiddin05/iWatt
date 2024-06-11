import 'package:i_watt_app/core/error/failure_handler.dart';
import 'package:i_watt_app/core/usecases/base_usecase.dart';
import 'package:i_watt_app/core/util/either.dart';
import 'package:i_watt_app/features/common/domain/entities/notification_entity.dart';
import 'package:i_watt_app/features/common/domain/repositories/notifications_repository.dart';

class GetNotificationDetailUseCase extends UseCase<NotificationEntity, int> {
  final NotificationRepository notificationRepository;

  GetNotificationDetailUseCase(this.notificationRepository);

  @override
  Future<Either<Failure, NotificationEntity>> call(int params) {
    return notificationRepository.getNotificationDetail(id: params);
  }
}
