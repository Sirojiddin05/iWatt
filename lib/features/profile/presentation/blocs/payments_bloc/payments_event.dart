part of 'payments_bloc.dart';

abstract class PaymentEvent extends Equatable {
  const PaymentEvent();

  @override
  List<Object?> get props => [];
}

class InitializeSelectedUserCardEvent extends PaymentEvent {
  final int id;
  const InitializeSelectedUserCardEvent(this.id);
}

class SelectUserCardEvent extends PaymentEvent {
  final int id;
  const SelectUserCardEvent({required this.id});
}

class SavePaymentSumEvent extends PaymentEvent {
  final String amount;
  const SavePaymentSumEvent(this.amount);
}

class PayWithCard extends PaymentEvent {
  final String? amount;
  const PayWithCard({this.amount});
}
