part of 'payments_bloc.dart';

class PaymentState extends Equatable {
  final FormzSubmissionStatus payWithCardStatus;
  final String payWithCardError;
  final int selectUserCardId;
  final String amount;

  const PaymentState({
    this.payWithCardError = '',
    this.payWithCardStatus = FormzSubmissionStatus.initial,
    this.selectUserCardId = -1,
    this.amount = '',
  });

  PaymentState copyWith({
    FormzSubmissionStatus? payWithCardStatus,
    int? selectUserCardId,
    String? amount,
    String? payWithCardError,
  }) {
    return PaymentState(
      payWithCardStatus: payWithCardStatus ?? this.payWithCardStatus,
      amount: amount ?? this.amount,
      selectUserCardId: selectUserCardId ?? this.selectUserCardId,
      payWithCardError: payWithCardError ?? this.payWithCardError,
    );
  }

  @override
  List<Object?> get props => [
        payWithCardStatus,
        selectUserCardId,
        amount,
        payWithCardError,
      ];
}
