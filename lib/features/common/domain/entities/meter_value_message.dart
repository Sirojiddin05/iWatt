class MeterValueMessageEntity {
  final int startCommandId;
  final int transactionId;
  final String money;
  final int batteryPercent;
  final double consumedKwh;
  final String status;

  const MeterValueMessageEntity({
    this.startCommandId = -1,
    this.transactionId = -1,
    this.money = '',
    this.batteryPercent = -1,
    this.consumedKwh = -1,
    this.status = '',
  });
}
