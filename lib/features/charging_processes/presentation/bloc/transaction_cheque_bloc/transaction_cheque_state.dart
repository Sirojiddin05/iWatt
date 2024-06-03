part of 'transaction_cheque_bloc.dart';

class TransactionChequeState extends Equatable {
  final TransactionMessageEntity cheque;

  const TransactionChequeState({
    this.cheque = const TransactionMessageEntity(),
  });

  TransactionChequeState copyWith({
    TransactionMessageEntity? cheque,
  }) {
    return TransactionChequeState(
      cheque: cheque ?? this.cheque,
    );
  }

  @override
  List<Object?> get props => [cheque];
}
