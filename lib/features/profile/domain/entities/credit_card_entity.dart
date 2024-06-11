import 'package:equatable/equatable.dart';

class CreditCardEntity extends Equatable {
  final int id;
  final String cardNumber;
  final String expireDate;
  final int balance;
  final String bankName;

  const CreditCardEntity({
    this.id = -1,
    this.balance = -1,
    this.cardNumber = '',
    this.expireDate = '',
    this.bankName = '',
  });

  @override
  List<Object?> get props => [cardNumber, id, balance, expireDate, bankName];
}
