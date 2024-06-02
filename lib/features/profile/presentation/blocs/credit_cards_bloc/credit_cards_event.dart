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

  const CreateCreditCard({
    required this.cardNumber,
    required this.expireDate,
  });
}

class ConfirmCreditCardEvent extends CreditCardsEvent {
  final String cardNumber;
  final String otp;

  const ConfirmCreditCardEvent({
    required this.cardNumber,
    required this.otp,
  });
}
