part of 'transaction_history_bloc.dart';

@immutable
abstract class TransactionHistoryEvent {}

class GetTransactionHistoryEvent extends TransactionHistoryEvent {
  GetTransactionHistoryEvent();
}

class GetMoreTransactionHistory extends TransactionHistoryEvent {
  GetMoreTransactionHistory();
}

class GetSingleTransactionEvent extends TransactionHistoryEvent {
  final int transactionId;

  GetSingleTransactionEvent(this.transactionId);
}
