import 'package:i_watt_app/core/error/failure_handler.dart';
import 'package:i_watt_app/core/usecases/base_usecase.dart';
import 'package:i_watt_app/core/util/either.dart';
import 'package:i_watt_app/features/common/domain/repositories/notifications_repository.dart';

class NotificationOnOffUseCase extends UseCase<void, bool> {
  final NotificationRepository notificationRepository;

  NotificationOnOffUseCase(this.notificationRepository);

  @override
  Future<Either<Failure, void>> call(bool params) {
    return notificationRepository.notificationOnOff(enabled: params);
  }
}
