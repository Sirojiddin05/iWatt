part of 'credit_cards_bloc.dart';

@immutable
abstract class CreditCardsEvent {
  const CreditCardsEvent();
}

class GetCreditCards extends CreditCardsEvent {
  const GetCreditCards();
}

class GetMoreCreditCards extends CreditCardsEvent {
  const GetMoreCreditCards();
}

class DeleteCreditCardEvent extends CreditCardsEvent {
  final int id;
  final VoidCallback onSuccess;
  final ValueChanged<String> onError;

  const DeleteCreditCardEvent({required this.id, required this.onSuccess, required this.onError});
}

class CreateCreditCard extends CreditCardsEvent {
  final String cardNumber;
  final String expireDate;
  final ValueChanged<int> onSuccess;
  final ValueChanged<String> onError;

  const CreateCreditCard({
    required this.cardNumber,
    required this.expireDate,
    required this.onError,
    required this.onSuccess,
  });
}

class ConfirmCreditCardEvent extends CreditCardsEvent {
  final String cardNumber;
  final String otp;
  final VoidCallback onSuccess;
  final ValueChanged<String> onError;

  const ConfirmCreditCardEvent({
    required this.cardNumber,
    required this.onSuccess,
    required this.onError,
    required this.otp,
  });
}
