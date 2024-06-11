import 'package:i_watt_app/core/error/failure_handler.dart';
import 'package:i_watt_app/core/usecases/base_usecase.dart';
import 'package:i_watt_app/core/util/either.dart';
import 'package:i_watt_app/features/common/domain/repositories/notifications_repository.dart';

class RegisterDeviceIdAndKeyUseCase extends UseCase<void, RegisterDeviceIdAndKeyParamsEntity> {
  final NotificationRepository notificationRepository;

  RegisterDeviceIdAndKeyUseCase(this.notificationRepository);

  @override
  Future<Either<Failure, void>> call(RegisterDeviceIdAndKeyParamsEntity params) {
    return notificationRepository.registerDeviceIdAndKey(
        registrationId: params.registrationId, deviceId: params.deviceId, deviceType: params.deviceType);
  }
}

class RegisterDeviceIdAndKeyParamsEntity {
  final String registrationId;
  final String? deviceId;
  final String deviceType;

  const RegisterDeviceIdAndKeyParamsEntity({required this.registrationId, this.deviceId, required this.deviceType});
}
