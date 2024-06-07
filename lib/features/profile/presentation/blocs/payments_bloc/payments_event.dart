part of 'payments_bloc.dart';

abstract class PaymentEvent extends Equatable {
  const PaymentEvent();

  @override
  List<Object?> get props => [];
}

class GetAvailablePaymentSystemsEvent extends PaymentEvent {
  const GetAvailablePaymentSystemsEvent();
}

class GetTransactionLinkEvent extends PaymentEvent {
  final ValueChanged<String> onError;
  const GetTransactionLinkEvent({required this.onError});
}

class SelectPaymentSystem extends PaymentEvent {
  final String title;
  const SelectPaymentSystem(this.title);
}

class SelectUserCardEvent extends PaymentEvent {
  final int id;
  const SelectUserCardEvent({required this.id});
}

class SavePaymentSumEvent extends PaymentEvent {
  final int amount;
  const SavePaymentSumEvent(this.amount);
}

class SavePaymentTypeEvent extends PaymentEvent {
  final PaymentType paymentType;
  const SavePaymentTypeEvent(this.paymentType);
}

class GetTransactionStateEvent extends PaymentEvent {
  const GetTransactionStateEvent();
}

class PayWithCard extends PaymentEvent {
  final VoidCallback onSuccess;
  final ValueChanged<String> onError;
  const PayWithCard({
    required this.onSuccess,
    required this.onError,
  });
}
