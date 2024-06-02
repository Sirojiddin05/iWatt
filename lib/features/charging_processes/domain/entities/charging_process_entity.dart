import 'package:i_watt_app/features/common/domain/entities/meter_value_message.dart';

class ChargingProcessEntity {
  final int taskId;
  final int connectorId;
  final int startCommandId;
  final int stopCommandId;
  final int transactionId;
  final MeterValueMessageEntity meterValueMessage;

  ChargingProcessEntity({
    this.taskId = -1,
    this.connectorId = -1,
    this.startCommandId = -1,
    this.stopCommandId = -1,
    this.transactionId = -1,
    this.meterValueMessage = const MeterValueMessageEntity(),
  });

  ChargingProcessEntity copyWith({
    int? taskId,
    int? connectorId,
    int? startCommandId,
    int? stopCommandId,
    int? transactionId,
    MeterValueMessageEntity? meterValueMessage,
  }) {
    return ChargingProcessEntity(
      taskId: taskId ?? this.taskId,
      connectorId: connectorId ?? this.connectorId,
      startCommandId: startCommandId ?? this.startCommandId,
      stopCommandId: stopCommandId ?? this.stopCommandId,
      transactionId: transactionId ?? this.transactionId,
      meterValueMessage: meterValueMessage ?? this.meterValueMessage,
    );
  }
}
