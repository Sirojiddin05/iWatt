class MeterValueMessageEntity {
  final int startCommandId;
  final int transactionId;
  final String money;
  final int batteryPercent;
  final String consumedKwh;
  final String status;

  const MeterValueMessageEntity({
    this.startCommandId = -1,
    this.transactionId = -1,
    this.money = '',
    this.batteryPercent = -1,
    this.consumedKwh = '',
    this.status = '',
  });

  MeterValueMessageEntity copyWith({
    int? startCommandId,
    int? transactionId,
    String? money,
    int? batteryPercent,
    String? consumedKwh,
    String? status,
  }) {
    return MeterValueMessageEntity(
      startCommandId: startCommandId ?? this.startCommandId,
      transactionId: transactionId ?? this.transactionId,
      money: money ?? this.money,
      batteryPercent: batteryPercent ?? this.batteryPercent,
      consumedKwh: consumedKwh ?? this.consumedKwh,
      status: status ?? this.status,
    );
  }
}
