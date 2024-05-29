import 'package:equatable/equatable.dart';

class CreditCardEntity extends Equatable {
  final String cardNumber;
  final String expireDate;
  final int balance;
  final int id;

  const CreditCardEntity({
    this.id = -1,
    this.balance = -1,
    this.cardNumber = '',
    this.expireDate = '',
  });

  @override
  List<Object?> get props => [cardNumber, id, balance, expireDate];
}
