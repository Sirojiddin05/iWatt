class ParkingDataMessageEntity {
  final int transactionId;
  final String locationName;
  final String parkingStartTime;
  final int freeParkingMinutes;
  final String parkingPrice;

  const ParkingDataMessageEntity({
    this.transactionId = -1,
    this.locationName = '',
    this.parkingStartTime = '',
    this.freeParkingMinutes = -1,
    this.parkingPrice = '',
  });
}
