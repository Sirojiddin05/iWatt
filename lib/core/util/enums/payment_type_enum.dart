enum PaymentType {
  viaPaymentSystem,
  viaCard;

  bool get isViaCard => this == PaymentType.viaCard;
  bool get isViaPaymentSystem => this == PaymentType.viaPaymentSystem;
}