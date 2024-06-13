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

  ParkingDataMessageEntity copyWith({
    int? transactionId,
    String? locationName,
    String? parkingStartTime,
    int? freeParkingMinutes,
    String? parkingPrice,
  }) {
    return ParkingDataMessageEntity(
      transactionId: transactionId ?? this.transactionId,
      locationName: locationName ?? this.locationName,
      parkingStartTime: parkingStartTime ?? this.parkingStartTime,
      freeParkingMinutes: freeParkingMinutes ?? this.freeParkingMinutes,
      parkingPrice: parkingPrice ?? this.parkingPrice,
    );
  }
}
