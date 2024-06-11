class TransactionEntity {
  final int id;
  final String locationName;
  final String vendorName;
  final String createdAt;
  final String totalPrice;

  const TransactionEntity({
    this.id = -1,
    this.locationName = '',
    this.vendorName = '',
    this.createdAt = '',
    this.totalPrice = '',
  });
}
