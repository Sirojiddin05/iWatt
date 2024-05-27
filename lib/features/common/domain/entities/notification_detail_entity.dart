import 'package:equatable/equatable.dart';
import 'package:i_watt_app/features/common/domain/entities/notification_entity.dart';

class NotificationDetailEntity extends Equatable {
  @NotificationConverter()
  final NotificationEntity data;

  const NotificationDetailEntity({
    this.data = const NotificationEntity(),
  });

  @override
  List<Object?> get props => [data];
}
