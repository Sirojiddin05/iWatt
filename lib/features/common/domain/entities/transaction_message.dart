class TransactionMessageEntity {
  final int transactionId;
  final String chargingHasStartedAt;
  final String locationName;
  final String consumedKwh;
  final String totalPrice;
  final int chargingDurationInMinute;

  const TransactionMessageEntity({
    this.transactionId = -1,
    this.chargingHasStartedAt = '',
    this.locationName = '',
    this.consumedKwh = '',
    this.totalPrice = '',
    this.chargingDurationInMinute = -1,
  });
}
