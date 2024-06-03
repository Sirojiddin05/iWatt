import 'package:i_watt_app/features/charge_location_single/domain/entities/connector_entity.dart';
import 'package:i_watt_app/features/common/domain/entities/meter_value_message.dart';

class ChargingProcessEntity {
  final ConnectorEntity connector;
  final int startCommandId;
  final int stopCommandId;
  final int transactionId;
  final MeterValueMessageEntity meterValueMessage;
  final String status;
  final String locationName;
  final String estimatedTime;

  ChargingProcessEntity({
    this.connector = const ConnectorEntity(),
    this.startCommandId = -1,
    this.stopCommandId = -1,
    this.transactionId = -1,
    this.meterValueMessage = const MeterValueMessageEntity(),
    this.status = '',
    this.locationName = '',
    this.estimatedTime = '',
  });

  ChargingProcessEntity copyWith({
    int? taskId,
    ConnectorEntity? connector,
    int? startCommandId,
    int? stopCommandId,
    int? transactionId,
    MeterValueMessageEntity? meterValueMessage,
    String? status,
    String? locationName,
    String? estimatedTime,
  }) {
    return ChargingProcessEntity(
      connector: connector ?? this.connector,
      startCommandId: startCommandId ?? this.startCommandId,
      stopCommandId: stopCommandId ?? this.stopCommandId,
      transactionId: transactionId ?? this.transactionId,
      meterValueMessage: meterValueMessage ?? this.meterValueMessage,
      status: status ?? this.status,
      locationName: locationName ?? this.locationName,
      estimatedTime: estimatedTime ?? this.estimatedTime,
    );
  }
}
