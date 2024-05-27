import 'package:i_watt_app/core/error/failure_handler.dart';
import 'package:i_watt_app/core/usecases/base_usecase.dart';
import 'package:i_watt_app/core/util/either.dart';
import 'package:i_watt_app/features/common/domain/repositories/notifications_repository.dart';

class ReadAllNotificationsUseCase extends UseCase<void, NoParams> {
  final NotificationRepository notificationRepository;

  ReadAllNotificationsUseCase(this.notificationRepository);

  @override
  Future<Either<Failure, void>> call(NoParams params) {
    return notificationRepository.readAllNotifications();
  }
}
