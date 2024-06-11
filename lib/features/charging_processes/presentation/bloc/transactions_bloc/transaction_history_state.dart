part of 'transaction_history_bloc.dart';

class TransactionHistoryState extends Equatable {
  final List<TransactionEntity> transactionHistory;
  final FormzSubmissionStatus getTransactionHistoryStatus;
  final TransactionMessageEntity singleTransactionHistory;
  final FormzSubmissionStatus getSingleTransactionHistoryStatus;
  final String next;
  final bool fetchMore;

  const TransactionHistoryState({
    this.transactionHistory = const [],
    this.getTransactionHistoryStatus = FormzSubmissionStatus.initial,
    this.singleTransactionHistory = const TransactionMessageEntity(),
    this.getSingleTransactionHistoryStatus = FormzSubmissionStatus.initial,
    this.next = '',
    this.fetchMore = false,
  });

  TransactionHistoryState copyWith({
    List<TransactionEntity>? transactionHistory,
    FormzSubmissionStatus? getTransactionHistoryStatus,
    TransactionMessageEntity? singleTransactionHistory,
    FormzSubmissionStatus? getSingleTransactionHistoryStatus,
    String? next,
    bool? fetchMore,
    String? searchPattern,
  }) {
    return TransactionHistoryState(
      transactionHistory: transactionHistory ?? this.transactionHistory,
      getTransactionHistoryStatus: getTransactionHistoryStatus ?? this.getTransactionHistoryStatus,
      singleTransactionHistory: singleTransactionHistory ?? this.singleTransactionHistory,
      getSingleTransactionHistoryStatus: getSingleTransactionHistoryStatus ?? this.getSingleTransactionHistoryStatus,
      next: next ?? this.next,
      fetchMore: fetchMore ?? this.fetchMore,
    );
  }

  @override
  List<Object> get props => [
        transactionHistory,
        getTransactionHistoryStatus,
        singleTransactionHistory,
        getSingleTransactionHistoryStatus,
        next,
        fetchMore,
      ];
}
