class TransactionMessageEntity {
  final int transactionId;
  final String chargingHasStartedAt;
  final String chargingHasEndedAt;
  final String locationName;
  final String vendorName;
  final String parkingStartTime;
  final String parkingEndTime;
  final String consumedKwh;
  final String chargingPrice;
  final String parkingPrice;
  final String totalPrice;
  final int chargingDurationInMinute;

  const TransactionMessageEntity({
    this.transactionId = -1,
    this.chargingHasStartedAt = '',
    this.locationName = '',
    this.consumedKwh = '',
    this.totalPrice = '',
    this.chargingDurationInMinute = -1,
    this.parkingPrice = '',
    this.vendorName = '',
    this.chargingHasEndedAt = '',
    this.chargingPrice = '',
    this.parkingEndTime = '',
    this.parkingStartTime = '',
  });
}
