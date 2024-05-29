import 'package:equatable/equatable.dart';

class PaymentStatusEntity extends Equatable {
  final String ztyResponse;
  final String status;
  final String paidAt;

  const PaymentStatusEntity({
    this.ztyResponse = '',
    this.status = '',
    this.paidAt = '',
  });

  @override
  List<Object?> get props => [ztyResponse, status, paidAt];
}
