class MeterValueMessageEntity {
  final int startCommandId;
  final int transactionId;
  final String money;
  final int batteryPercent;
  final String consumedKwh;
  final String currentKwh;
  final String status;
  final String estimatedTime;

  const MeterValueMessageEntity({
    this.startCommandId = -1,
    this.transactionId = -1,
    this.money = '',
    this.batteryPercent = -1,
    this.consumedKwh = '',
    this.status = '',
    this.currentKwh = '',
    this.estimatedTime = '',
  });

  MeterValueMessageEntity copyWith({
    int? startCommandId,
    int? transactionId,
    String? money,
    int? batteryPercent,
    String? consumedKwh,
    String? status,
    String? currentKwh,
    String? estimatedTime,
  }) {
    return MeterValueMessageEntity(
      startCommandId: startCommandId ?? this.startCommandId,
      transactionId: transactionId ?? this.transactionId,
      money: money ?? this.money,
      batteryPercent: batteryPercent ?? this.batteryPercent,
      consumedKwh: consumedKwh ?? this.consumedKwh,
      status: status ?? this.status,
      currentKwh: currentKwh ?? this.currentKwh,
      estimatedTime: estimatedTime ?? this.estimatedTime,
    );
  }
}
