import 'package:i_watt_app/core/error/failure_handler.dart';
import 'package:i_watt_app/core/util/either.dart';
import 'package:i_watt_app/features/common/data/models/generic_pagination.dart';
import 'package:i_watt_app/features/common/domain/entities/notification_detail_entity.dart';
import 'package:i_watt_app/features/common/domain/entities/notification_entity.dart';

abstract class NotificationRepository {
  Future<Either<Failure, GenericPagination<NotificationEntity>>> getNotifications({String? next});
  Future<Either<Failure, NotificationDetailEntity>> getNotificationDetail({required int id});
  Future<Either<Failure, void>> readAllNotifications();
  Future<Either<Failure, void>> notificationOnOff({required bool enabled});
}
