import 'package:i_watt_app/core/error/failure_handler.dart';
import 'package:i_watt_app/core/util/either.dart';
import 'package:i_watt_app/features/common/data/models/generic_pagination.dart';
import 'package:i_watt_app/features/common/domain/entities/notification_entity.dart';

abstract class NotificationRepository {
  Future<Either<Failure, GenericPagination<NotificationEntity>>> getNotifications({String? next});
  Future<Either<Failure, NotificationEntity>> getNotificationDetail({required int id});
  Future<Either<Failure, void>> readAllNotifications();
  Future<Either<Failure, void>> notificationOnOff({required bool enabled});
  Future<Either<Failure, void>> registerDeviceIdAndKey({required String registrationId, required String? deviceId, required String deviceType});
}
